#!/usr/bin/env python3
"""Restore the most recent local snapshot made before the Noctalia v5 migration."""
import argparse
import datetime
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tarfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="verify the backup without restoring")
    parser.add_argument("--backup", type=Path, help="use a specific snapshot directory")
    args = parser.parse_args()
    repo = Path(__file__).resolve().parent.parent
    snapshots = sorted((repo / "backups").glob("noctalia-v4-*/SHA256SUMS"))
    if not args.backup and not snapshots:
        raise SystemExit("Nenhum backup do Noctalia v4 encontrado.")
    backup = args.backup or snapshots[-1].parent
    for line in (backup / "SHA256SUMS").read_text().splitlines():
        expected, name = line.split("  ", 1)
        with (backup / name).open("rb") as source:
            actual = hashlib.file_digest(source, "sha256").hexdigest()
        if actual != expected:
            raise SystemExit(f"Backup corrompido: {name}")
    archives = [backup / "configuracoes-v4.tar.gz", backup / "temas-adicionais-v4.tar.gz"]
    home = Path.home()
    members = []
    for archive in archives:
        with tarfile.open(archive) as source:
            for member in source:
                relative = Path(member.name)
                if relative.is_absolute() or ".." in relative.parts or not (member.isfile() or member.isdir()):
                    raise SystemExit(f"Entrada inesperada no backup: {member.name}")
                if member.isfile():
                    members.append(member.name)
    if args.check:
        print(f"Backup íntegro: {backup} ({len(members)} arquivos)")
        return
    if subprocess.run(["pacman", "-Q", "noctalia-shell", "noctalia-qs"], stdout=subprocess.DEVNULL).returncode:
        raise SystemExit(f"Reinstale os pacotes v4 com sudo pacman -U {backup}/*.pkg.tar.zst")

    # Preserve current files too, so reverting does not discard later edits.
    stamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    rescue = backup / f"antes-da-restauracao-{stamp}.tar.gz"
    with tarfile.open(rescue, "w:gz", dereference=True) as target:
        for name in dict.fromkeys(members + [".config/noctalia/config.toml", ".local/state/noctalia"]):
            current = home / name
            if current.exists():
                target.add(current, arcname=name)

    subprocess.run(["pkill", "-u", str(os.getuid()), "-x", "noctalia"], check=False)
    config = home / ".config/noctalia/config.toml"
    if config.exists() or config.is_symlink():
        config.rename(config.with_name(f"config.toml.v5-{stamp}"))
    for archive in archives:
        with tarfile.open(archive) as source:
            for member in source:
                if not member.isfile():
                    continue
                target = home / member.name
                target.parent.mkdir(parents=True, exist_ok=True)
                # Write through existing dotfile symlinks, preserving the links.
                with source.extractfile(member) as content, target.open("wb") as output:
                    shutil.copyfileobj(content, output)
                target.chmod(member.mode)
    subprocess.run(["niri", "validate"], check=True)
    subprocess.run(["niri", "msg", "action", "load-config-file"], check=False)
    running = subprocess.run(["pgrep", "-u", str(os.getuid()), "-f", "^qs -c noctalia-shell$"], stdout=subprocess.DEVNULL)
    if running.returncode:
        with (backup / "restauracao-v4.log").open("a") as log:
            subprocess.Popen(["qs", "-c", "noctalia-shell"], stdout=log, stderr=log, start_new_session=True)
    subprocess.run(["bash", str(repo / "scripts/kitty-noctalia-colors.sh")], check=False)
    print(f"Noctalia v4 restaurado. Configurações anteriores à restauração salvas em {rescue}")


if __name__ == "__main__":
    main()
