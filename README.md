# dotfiles

## Prerequisites

Make sure you have [Homebrew](https://brew.sh/) installed, and if you haven't already, run `chmod -R go-w /opt/homebrew/share` (see: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh).

## Getting started

1. If you already have files or directories listed in [`install.conf.yaml#link`](./install.conf.yaml), merge them into your clone of this repository as needed.
2. Run `./install` to bootstrap dotfiles.
3. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and reopen the terminal.
4. Run `brew bundle`.

## Usage

### Back up a list of your applications into `applications`

```shell
./dump_applications
```

> [!NOTE]
> This script will not work if the application folder is excluded from Spotlight searches.
