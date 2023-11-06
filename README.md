# dotfiles

## Usage

1. Clone this repository into your home directory and `cd` into it
2. Run `./install` (this will remove existing `~/.zsh_history`)
3. Run `unset HISTFILE; rm -rf ~/.zsh_sessions` and then reopen the terminal

Optionally, you can run `./dump_applications` to back up your applications. Note that this will not work if Spotlight is prevented from searching the applications folder.
