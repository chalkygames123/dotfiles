alias a='git add .'
alias b='open "${"$(git remote get-url origin)"%.git}"'
alias bb='git branch --all --verbose --verbose'
alias c='code .'
alias d='git diff'
alias dcu='docker compose up'
alias g='git'
alias l='git log --graph'
alias ll='ls -AFGl'
alias n='npm'
alias nb='nr build'
alias nd='nr dev'
alias o='open .'
alias p='git pull --all'
alias rr='git remote --verbose'
alias s='git status'
alias ss='git status --ignored --show-stash'
alias v='volta'

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
	declare -i i=1

	if [[ ! $* ]]; then
		echo 'fatal: The command to be executed must be specified.'

		return 1
	fi

	read -r -A ghq_list_args <<< "$GHQ_LIST_ARGS"
	readonly ghq_list_args

	for repository in $(ghq list "${ghq_list_args[@]}"); do
		cd "$(ghq root)/$repository" || return

		[[ i -gt 1 ]] && printf '\n'
		printf '\e[34m%s\n' "$repository"
		printf '─%.s' $(seq 1 "$COLUMNS")
		printf '\e[m\n'

		eval "$*"

		i=$(( i + 1 ))
	done
}

_my-backward-delete-word() {
	declare WORDCHARS=${WORDCHARS//[-\/]/}

	zle backward-delete-word
}

export PS1=$'\n%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export HISTFILE="$HOME/dotfiles/zsh_history"
export LESSHISTFILE=-
export NODE_REPL_HISTORY=
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
[[ ! -d $WAKATIME_HOME ]] && mkdir "$XDG_CONFIG_HOME/wakatime"

zle -N _my-backward-delete-word
bindkey '^[^?' _my-backward-delete-word
bindkey '^U' backward-kill-line
bindkey '^^' redo
bindkey '^[[Z' reverse-menu-complete
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt MAGIC_EQUAL_SUBST
unsetopt FLOW_CONTROL

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
		print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
		command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
		command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
				print -P "%F{33} %F{34}Installation successful.%f%b" || \
				print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit as'program' light-mode for \
	from'gh-r' pick'actionlint' atclone'mkdir -p man/man1 && ln -fs ../actionlint.1 man/man1' atpull'%atclone' \
		rhysd/actionlint \
	from'gh-r' pick'bat/bat' mv'bat* -> bat' atclone'mkdir -p man/man1 && ln -fs ../../bat/bat.1 man/man1; ln -fs bat/autocomplete/bat.zsh _bat' atpull'%atclone' atinit'export BAT_THEME=ansi' \
		@sharkdp/bat \
	from'gh-r' pick'gh/bin/gh' mv'gh* -> gh' atclone'./gh/bin/gh completion --shell zsh > _gh' atpull'%atclone' \
		cli/cli \
	from'gh-r' pick'delta/delta' mv'delta* -> delta' \
		dandavison/delta \
	from'gh-r' pick'direnv' src'zdirenv.zsh' mv'direnv* -> direnv' atclone'./direnv hook zsh > zdirenv.zsh' atpull'%atclone' \
		direnv/direnv \
	from'gh-r' pick'dust/dust' mv'dust* -> dust' \
		bootandy/dust \
	from'gh-r' pick'fd/fd' mv'fd* -> fd' atclone'mkdir -p man/man1 && ln -fs ../../fd/fd.1 man/man1' atpull'%atclone' \
		@sharkdp/fd \
	from'gh-r' mv'bin/ec* -> ec' cp'ec -> editorconfig-checker' \
		editorconfig-checker/editorconfig-checker \
	from'gh-r' pick'fzf' atinit'export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude .git --type file --color=always"; export FZF_DEFAULT_OPTS="--ansi"' \
		junegunn/fzf \
	from'gh-r' pick'ghq/ghq' mv'ghq* -> ghq' \
		x-motemen/ghq \
	from'gh-r' pick'ripgrep/rg' mv'ripgrep* -> ripgrep' atclone'mkdir -p man/man1 && ln -fs ../../ripgrep/doc/rg.1 man/man1' atpull'%atclone' \
		BurntSushi/ripgrep \
	from'gh-r' pick'rnr/rnr' mv'rnr* -> rnr' \
		ismaelgv/rnr \
	from'gh-r' pick'shellcheck/shellcheck' mv'shellcheck* -> shellcheck' \
		koalaman/shellcheck \
	from'gh-r' pick'volta' atclone'./volta completions zsh > _volta' atpull'%atclone' atinit'export VOLTA_HOME="$PWD"; export PATH="$VOLTA_HOME/bin:$PATH"' \
		volta-cli/volta \
	from'gh-r' pick'watchexec/watchexec' mv'watchexec* -> watchexec' atclone'mkdir -p man/man1 && ln -fs ../../watchexec/watchexec.1 man/man1; ln -fs watchexec/completions/zsh _watchexec' atpull'%atclone' \
		watchexec/watchexec

zinit as'completion' light-mode for \
	https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
	atinit'zicompinit' https://github.com/zsh-users/zsh-completions/blob/master/src/_yarn
