# dotfiles

## Prerequisites

- Install Nix with the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).
- Install [nix-darwin](https://github.com/LnL7/nix-darwin) with flakes.

## Getting started

1. If you already have files or directories listed in [`install.conf.yaml#link`](./install.conf.yaml), merge them into your clone of this repository as needed.
2. Run `./install` to bootstrap dotfiles.
3. Run `make switch` to configure the system with flake files.
4. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and reopen the terminal.

## Usage

### Lint flake files

```shell
make lint
```

### Format flake files

```shell
make format
```

### Update flake lock file

```shell
make update
```

### Apply changes to flake files to the system

```shell
make switch
```

### Delete all old generations

```shell
make clean
```

### Back up a list of your applications into `applications`

```shell
./dump_applications
```

> [!NOTE]
> This script will not work if the application folder is excluded from Spotlight searches.
