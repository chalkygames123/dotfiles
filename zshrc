# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

alias a="git add --all"
alias b='[[ $(git rev-parse --is-inside-work-tree) ]] && open "${"$(git remote get-url origin)"%.git}"'
alias bb="git branch --all --verbose --verbose"
alias c="code ."
alias d="git diff"
alias dcu="docker compose up"
alias g="git"
alias l="git log --graph"
alias ll="ls -AFGl"
alias n="npm"
alias y="yarn"
alias pn="pnpm"
alias nb="nr build"
alias nd="nr dev"
alias ns="nr start"
alias o="open ."
alias p="git pull --all"
alias rr="git remote --verbose"
alias s="git status"
alias ss="git status --ignored --show-stash"
alias v="volta"
alias gam="$HOME/bin/gam/gam"

setopt CORRECT
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt MAGIC_EQUAL_SUBST

bindkey '^U' backward-kill-line
bindkey '^^' redo
bindkey '^[[Z' reverse-menu-complete

zstyle ':completion:*:default' menu select

export LESSHISTFILE="-"
export NODE_REPL_HISTORY=""
export PS1=$'\n%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'
export WORDCHARS="${WORDCHARS//[-\/]/}"

export path=(
	"/Applications/Sublime\ Text.app/Contents/SharedSupport/bin"
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

	if ! selected="$(ghq list | fzf)"; then
		return
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

	read -r -A ghq_list_args <<< "$GHQ_LIST_ARGS"
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

		i=$(( i + 1 ))
	done
}

eval "$(op completion zsh)"; compdef _op op
source "$XDG_CONFIG_HOME/op/plugins.sh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
