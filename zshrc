alias b='[[ $(git rev-parse --is-inside-work-tree) ]] && open "${"$(git remote get-url origin)"%.git}"'
alias c="code"
alias g="git"
alias l="eza --long --all"
alias n="npm"
alias o="open"
alias pn="pnpm"
alias pnf="pnpm -F"
alias z="zoxide"

setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt MAGIC_EQUAL_SUBST
setopt NO_FLOW_CONTROL

bindkey "^U" backward-kill-line
bindkey "^^" redo

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

export path=(
	"$PNPM_HOME"
	"$HOME/.local/bin"
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
		if ! selected="$(ghq list | fzf --query $1)"; then
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

			[[ i -gt 0 ]] && printf "\n"
			printf "\e[34m%s\n" "$repository"
			printf "─%.s" $(seq 1 "$COLUMNS")
			printf "\e[m\n"

			eval "$*"
		)

		i=$((i + 1))
	done
}

gh_copilot_suggest_git() {
	gh copilot suggest --target git -- "$@"
}
alias "git?"="gh_copilot_suggest_git"

gh_copilot_suggest_gh() {
	gh copilot suggest --target gh -- "$@"
}
alias "gh?"="gh_copilot_suggest_gh"

gh_copilot_suggest_shell() {
	gh copilot suggest --target shell -- "$@"
}
alias "??"="gh_copilot_suggest_shell"

gh_copilot_explain() {
	gh copilot explain -- "$@"
}
alias "?"="gh_copilot_explain"

source "$XDG_CONFIG_HOME/op/plugins.sh"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
