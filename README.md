# dotfiles

My minimalistic dotfiles for macOS, bootstrapped with [Dotbot](https://github.com/anishathalye/dotbot).

## Prerequisites

1. Install [Homebrew](https://brew.sh/).
2. Run `chmod -R go-w "$(brew --prefix)/share"` to configure permissions correctly. For more details, see the [Homebrew documentation on shell completions](https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh).

## Getting started

1. Clone this repository to your home directory.
2. Review your existing configuration:
   - Check if you already have any files listed in [`install.conf.yaml` under the `link` section](./install.conf.yaml) (such as `.zshrc` or `.gitconfig`).
   - If you do, either back them up or merge their contents into the corresponding files in this repository.
3. Run `./install` to bootstrap dotfiles.
4. Clean up your environment to ensure the new configurations take effect:

   ```shell
   unset HISTFILE
   rm -rf ~/.zsh_sessions
   ```

   Then restart your terminal.

5. Run `brew bundle` to install all packages listed in the [Brewfile](./Brewfile).

## Backing up your applications

You can use the following script to back up your currently installed applications to the `applications` file:

```shell
./dump_applications
```

This can be useful for future reference or reinstallation.

> [!NOTE]
> This script requires that your Applications folder is indexed by Spotlight. Check your Spotlight settings in System Settings > Spotlight > Search Privacy to ensure the Applications folder is not excluded.
