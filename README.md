# dotfiles

## Prerequisites

- Install [Nix](https://github.com/NixOS/nix) and [nix-darwin](https://github.com/LnL7/nix-darwin)
- Add nixpkgs-unstable channel with `nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs`

## Usage

1. Run `./install` (this will remove existing `~/.zsh_history`)
2. Run `darwin-rebuild switch`
3. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and then reopen the terminal

Optionally, you can run `./dump_applications` to back up your applications. Note that this will not work if Spotlight is prevented from searching the applications folder.
