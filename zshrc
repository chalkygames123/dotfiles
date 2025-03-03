alias b='[[ $(git rev-parse --is-inside-work-tree) ]] && open "${"$(git remote get-url origin)"%.git}"'
alias c="code"
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbb="git branch --all --verbose --verbose"
alias gc="git checkout"
alias gcl="git clean -d --force --interactive"
alias gclx="git clean -d --force --interactive --exclude='.husky/' --exclude='node_modules/' -x"
alias gclxx="git clean -d --force --interactive -X"
alias gco="git commit"
alias gcoa="git commit --amend"
alias gcona="git commit --no-edit --amend"
alias gd="git diff --ignore-space-change"
alias gds="git diff --staged --ignore-space-change"
alias gdx="git diff --ignore-space-change -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias gdsx="git diff --staged --ignore-space-change -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias gf="git fetch"
alias gl="git log"
alias glp="git log --patch --ignore-space-change --ext-diff"
alias glu="git log '@{upstream}^..'"
alias glpu="git log --patch --ignore-space-change --ext-diff '@{upstream}..'"
alias glpx="git log --patch --ignore-space-change --ext-diff -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias glpux="git log --patch --ignore-space-change --ext-diff '@{upstream}..' -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias gll="git log --pretty=fuller"
alias gllp="git log --pretty=fuller --patch --ignore-space-change --ext-diff"
alias gllu="git log --pretty=fuller '@{upstream}^..'"
alias gllpu="git log --pretty=fuller --patch --ignore-space-change --ext-diff '@{upstream}..'"
alias gllpx="git log --pretty=fuller --patch --ignore-space-change --ext-diff -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias gllpux="git log --pretty=fuller --patch --ignore-space-change --ext-diff '@{upstream}..' -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias gm="git merge"
alias gma="git merge --abort"
alias gp="git pull"
alias gpf="git pull --force origin main"
alias gpu="git push"
alias gpuf="git push --force-with-lease"
alias gr="git rebase"
alias gri="git rebase --interactive --autosquash"
alias grid="git rebase --interactive --autosquash --committer-date-is-author-date"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias grem="git remote --verbose"
alias gref="git reflog"
alias gre="git reset"
alias grek="git reset --keep"
alias gres="git restore"
alias grev="git revert"
alias gsh="git show --pretty=fuller --ignore-space-change --ext-diff"
alias gshx="git show --pretty=fuller --ignore-space-change --ext-diff -- ':^*package-lock.json' ':^*yarn.lock' ':^*pnpm-lock.yaml'"
alias gst="git stash"
alias gstk="git stash push --keep-index"
alias gstl="git stash list --date=iso-local"
alias gstp="git stash pop"
alias gstpi="git stash pop --index"
alias gsts="git stash --staged"
alias gstu="git stash --include-untracked"
alias gs="git status"
alias gss="git status --ignored --show-stash"
alias gsw="git switch"
alias gswc="git switch --create"
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
