alias o="open"
alias v="volta"
alias z="zoxide"

alias b='[[ $(git rev-parse --is-inside-work-tree) ]] && open "${"$(git remote get-url origin)"%.git}"'
alias c="code"
alias d="docker compose up"
alias g="git"
alias l="eza --long --all"

alias n="npm"
alias pn="pnpm"
alias y="yarn"

alias nb="nr build"
alias nd="nr dev"
alias ns="nr start"

pnfr() {
	pnpm --filter="$1" run "${@:2}"
}

pnfb() {
	pnpm --filter="$1" build "${@:2}"
}

pnfd() {
	pnpm --filter="$1" dev "${@:2}"
}

pnfd() {
	pnpm --filter="$1" start "${@:2}"
}

pnfx() {
	pnpm --filter="$1" exec "${@:2}"
}

alias gam="$HOME/bin/gam/gam"

setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt MAGIC_EQUAL_SUBST
setopt NO_FLOW_CONTROL

bindkey '^U' backward-kill-line
bindkey '^^' redo

export EDITOR="vim"
export HISTFILE="$HOME/dotfiles/zsh_history"
export LANG="ja_JP.UTF-8"
export LESSHISTFILE="-"
export PS1=$'\n%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'
export SAVEHIST=0
export WORDCHARS="${WORDCHARS//[-\/]/}"

export BAT_THEME="ansi"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude=.git --type=file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export NODE_REPL_HISTORY=""
export PNPM_HOME="$HOME/.local/share/pnpm"
export VOLTA_FEATURE_PNPM=1
export VOLTA_HOME="$HOME/.volta"

export path=(
	"$HOME/.local/bin"
	"$PNPM_HOME"
	"$VOLTA_HOME/bin"
	"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
	$path
)

manzsh() {
	man zshbuiltins | less -p "^       $1"
}

touchp() {
	declare arg

	for arg in "$@"; do
		mkdir -p "$(dirname "$arg")" && touch "$arg"
	done
}

cdf() {
	declare selected

	if ! selected="$(fzf)"; then
		return
	fi

	readonly selected

	cd "$selected" || return
}

cdg() {
	declare selected

	if [[ $1 ]]; then
		if ! selected="$(ghq list | fzf --query=$1)"; then
			return
		fi
	else
		if ! selected="$(ghq list | fzf)"; then
			return
		fi
	fi

	readonly selected

	cd "$(ghq root)/$selected" || return
}

xargsg() {
	declare -a ghq_list_args
	declare -i i=0

	if [[ ! $* ]]; then
		echo "fatal: The command to be executed must be specified."

		return 1
	fi

	read -r -A ghq_list_args <<<"$GHQ_LIST_ARGS"
	readonly ghq_list_args

	for repository in $(ghq list "${ghq_list_args[@]}"); do
		(
			cd "$(ghq root)/$repository" || return

			[[ i -gt 0 ]] && printf '\n'
			printf '\e[34m%s\n' "$repository"
			printf '─%.s' $(seq 1 "$COLUMNS")
			printf '\e[m\n'

			eval "$*"
		)

		i=$((i + 1))
	done
}

gh_copilot_suggest_git() {
	gh copilot suggest --target=git -- "$@"
}
alias 'git?'='gh_copilot_suggest_git'

gh_copilot_suggest_gh() {
	gh copilot suggest --target=gh -- "$@"
}
alias 'gh?'='gh_copilot_suggest_gh'

gh_copilot_suggest_shell() {
	gh copilot suggest --target=shell -- "$@"
}
alias '??'='gh_copilot_suggest_shell'

gh_copilot_explain() {
	gh copilot explain -- "$@"
}
alias '?'='gh_copilot_explain'

eval "$(starship init zsh)"

source "$XDG_CONFIG_HOME/op/plugins.sh"
