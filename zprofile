if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -p "$HOME/.copilot/.env" ]]; then
	export "$(grep -v '^#' "$HOME/.copilot/.env" | xargs)"

	launchctl setenv HEROUI_PRO_PERSONAL_TOKEN "$HEROUI_PRO_PERSONAL_TOKEN"
fi

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

source "$HOME/.cargo/env"

export BAT_THEME="ansi"
export EDITOR="vim"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude=.git --type=file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export LANG="ja_JP.UTF-8"
export LESSHISTFILE="-"
export NODE_REPL_HISTORY=""
export PNPM_HOME="$HOME/.local/share/pnpm"

export path=(
	"$PNPM_HOME/bin"
	"$PNPM_HOME"
	"$HOME/.local/bin"
	"/opt/homebrew/opt/libpq/bin"
	"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
	$path
)
