# AGENTS.md

Persistent project instructions for Codex in this Neovim config.

## Project

- This repository is a Neovim configuration managed with `lazy.nvim`.
- Plugin specs live under `lua/plugins`, `lua/plugins/lsp`, and `lua/plugins/ui`.
- Prefer the existing style used across the repo: small plugin specs, concise config, and direct keymaps.

## Editing Rules

- Preserve the current structure and naming style.
- Keep changes minimal and local.
- Prefer Lua changes that match the surrounding files.
- Do not add unnecessary abstractions.

## Neovim Conventions

- Follow existing keymap prefixes and `which-key` groupings.
- Keep UI changes aligned with the current config.
- When adding plugins, prefer lazy-loading through `cmd`, `keys`, `event`, or `ft` when appropriate.
- Keep `markdown-preview.nvim` in the current working directory so relative local images are served; hide its HTML file and remove generated files when the preview stops.

## Maintenance

- Treat this file as persistent working context for Codex in this repository.
- When stable project-specific conventions are discovered, append them here.
