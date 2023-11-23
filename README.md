# dotfiles

## Prerequisites

Make sure you have [Nix](https://github.com/NixOS/nix) and [nix-darwin](https://github.com/LnL7/nix-darwin) installed.

Also, make sure you have [Home Manager](https://github.com/nix-community/home-manager) channel added.

## Usage

1. Run `darwin-rebuild switch -I darwin-config="$HOME/dotfiles/nixpkgs/darwin-configuration.nix"`
2. Run `unset HISTFILE` and then reopen the terminal

Optionally, you can run `./dump_applications` to back up your applications. Note that this will not work if Spotlight is prevented from searching the applications folder.
