# dotfiles

## Prerequisites

Make sure you have Command Line Tools for Xcode installed. If not, run `xcode-select --install`.

## Usage

1. Run `./install` (this will remove existing `~/.zsh_history`)
2. Run `unset HISTFILE` and then reopen the terminal
3. Install [Homebrew](https://brew.sh/) and then run `chmod -R go-w "$(brew --prefix)/share"`, if you haven't already (see: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh)
4. Run `brew bundle; rm ~/.zcompdump; compinit`
