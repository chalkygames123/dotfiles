# dotfiles

## Prerequisites

- Install Nix with the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)
- Install [nix-darwin](https://github.com/LnL7/nix-darwin) with flakes

## Getting started

1. If you already have files or directories listed in [`install.conf.yaml#link`](./install.conf.yaml), merge them into your clone of this repository.
2. Run `./install` (this will remove existing `~/.zsh_history`).
3. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and then reopen the terminal.

## Usage

Back up a list of your applications into `applications`:

```shell
./dump_applications
```

> [!NOTE]
> This script will not work if the application folder is excluded from Spotlight searches.
