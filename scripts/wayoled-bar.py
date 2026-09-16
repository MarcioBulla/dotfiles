#!/usr/bin/env python3
"""Run WayOLED and keep its top-layer mask above the Noctalia bar on eDP-1."""
import json
import subprocess
import time
import signal
from pathlib import Path

BINDIR = Path.home() / '.local/lib/wayoled'
CTL = str(BINDIR / 'oledctl')

def control(action):
    result = subprocess.run([CTL, action, '--monitor', 'eDP-1'], capture_output=True, text=True, timeout=3)
    if result.returncode or result.stdout.strip() != 'ok':
        raise RuntimeError(result.stderr or result.stdout)


def decision(layers):
    surfaces = [s for s in layers if s['output'] == 'eDP-1']
    bar = next((i for i, s in enumerate(surfaces) if s['namespace'] == 'noctalia-bar-default'), None)
    mask = next((i for i, s in enumerate(surfaces) if s['namespace'] == 'wayoled-mask'), None)
    if bar is None or surfaces[bar]['layer'] != 'Top':
        return 'hide' if mask is not None else None
    if mask is None:
        return 'show'
    if mask < bar:
        return 'raise'
    return None

def main():
    stopping = False

    def stop(signum, frame):
        nonlocal stopping
        stopping = True

    signal.signal(signal.SIGTERM, stop)
    signal.signal(signal.SIGINT, stop)
    daemon = subprocess.Popen([str(BINDIR / 'wayoled')])
    last_error = None
    try:
        while not stopping:
            if daemon.poll() is not None:
                raise RuntimeError(f'WayOLED exited: {daemon.returncode}')
            try:
                result = subprocess.run(['niri', 'msg', '--json', 'layers'], capture_output=True, text=True, check=True, timeout=3)
                action = decision(json.loads(result.stdout))
                if action in ('hide', 'raise'):
                    control('restore')
                if action in ('show', 'raise'):
                    control('dim')
                if action:
                    print(f'eDP-1 mask: {action}', flush=True)
                last_error = None
            except (OSError, ValueError, RuntimeError, subprocess.SubprocessError) as exc:
                if str(exc) != last_error:
                    print(f'Layer check failed: {exc}', flush=True)
                    last_error = str(exc)
            time.sleep(0.75)
    finally:
        if daemon.poll() is None:
            daemon.terminate()
            try:
                daemon.wait(timeout=5)
            except subprocess.TimeoutExpired:
                daemon.kill()
                daemon.wait()


if __name__ == '__main__':
    main()
