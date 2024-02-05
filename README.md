# dotfiles

## Prerequisites

- Install Nix with the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer9)
- Install [nix-darwin](https://github.com/LnL7/nix-darwin) with flakes

## Getting started

1. If you already have files or directories listed in [`install.conf.yaml#link`](./install.conf.yaml), merge them into your clone of this repository.
2. Run `./install` (this will remove existing `~/.zsh_history`).
3. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and then reopen the terminal.

Optionally, you can run `./dump_applications` to back up your applications. Note that this will not work if Spotlight is prevented from searching the applications folder.
