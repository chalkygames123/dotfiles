# dotfiles

## Prerequisites

Make sure you have Command Line Tools for Xcode installed. If not, run `xcode-select --install`.

## Usage

1. Install [Homebrew](https://brew.sh/) and then run `chmod -R go-w /opt/homebrew/share`, if you haven't already (see: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh)
2. Run `/opt/homebrew/bin/brew bundle`
3. Run `./install` (this will remove existing `~/.zsh_history`)
4. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and then reopen the terminal

Optionally, you can run `./dump_applications` to back up your applications.
