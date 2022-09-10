alias ll='ls -AFGl'
alias o='open .'
alias g='git'
alias a='git add .'
alias bb='git branch --all --verbose --verbose'
alias d='git diff --ignore-space-change'
alias l='git log --graph'
alias p='git pull --all'
alias rr='git remote --verbose'
alias s='git status'
alias ss='git status --ignored --show-stash'
alias b='open "${$(git remote get-url origin)%.git}"'
alias nd='nr dev'
alias nb='nr build'
alias v='volta'
alias c='code .'
alias dcu='docker compose up'

function touchp() {
	for arg in "$@"; do
		mkdir -p "$(dirname "$arg")" && touch "$arg"
	done
}

function fzc() {
	local DIR

	DIR=$(dirname "$(fzf)")

	[[ $DIR ]] && cd "$DIR" || return
}

function gc() {
	local DIR

	DIR=$(ghq list | fzf)

	[[ $DIR ]] && cd "$(ghq root)/$DIR" || return
}

function gg() {
	if [[ $# = 0 ]]; then
		echo 'fatal: You must specify a command to run.'

		return
	fi

	local DIRS
	local ESC
	local COLUMNS

	DIRS=$(ghq list "$QUERY")
	ESC=$(printf '\033')
	COLUMNS=$(tput cols)

	(
		echo "$DIRS" | while IFS= read -r DIR; do
			printf '%s[34m' "$ESC"
			printf '\n%s\n' "$DIR"
			printf '─%.0s' {1.."$COLUMNS"}
			printf '\n\n%s[m' "$ESC"

			cd "$(ghq root)/$DIR" || return
			eval "$*"
			cd - > /dev/null || return
		done
	)
}

function _my-backward-delete-word() {
	local WORDCHARS=${WORDCHARS//[-\/]/}

	zle backward-delete-word
}

export PS1='
%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export HISTFILE="$HOME/dotfiles/zsh_history"
export LESSHISTFILE=-
export NODE_REPL_HISTORY=-
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

zle -N _my-backward-delete-word
bindkey '^[[Z' reverse-menu-complete
bindkey '^[^?' _my-backward-delete-word
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt MAGIC_EQUAL_SUBST
unsetopt FLOW_CONTROL

if type brew &>/dev/null; then
	fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

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

zinit wait lucid as'program' for \
	from'gh-r' pick'actionlint' atclone'mkdir -p man/man1 && ln -fs ../actionlint.1 man/man1' atpull'%atclone' \
		rhysd/actionlint \
	from'gh-r' pick'bat/bat' mv'bat* -> bat' atclone'mkdir -p man/man1 && ln -fs ../../bat/bat.1 man/man1; ln -fs bat/autocomplete/bat.zsh _bat' atpull'%atclone' atinit'export BAT_THEME=ansi' \
		@sharkdp/bat \
	from'gh-r' ver'latest' pick'gh/bin/gh' mv'gh* -> gh' atclone'./gh/bin/gh completion --shell zsh > _gh' atpull'%atclone' \
		cli/cli \
	from'gh-r' pick'delta/delta' mv'delta* -> delta' \
		dandavison/delta \
	from'gh-r' pick'direnv' src'zdirenv.zsh' mv'direnv* -> direnv' atclone'./direnv hook zsh > zdirenv.zsh' atpull'%atclone' \
		direnv/direnv \
	from'gh-r' pick'dust/dust' mv'dust* -> dust' \
		bootandy/dust \
	from'gh-r' pick'fd/fd' mv'fd* -> fd' atclone'mkdir -p man/man1 && ln -fs ../../fd/fd.1 man/man1' atpull'%atclone' \
		@sharkdp/fd \
	from'gh-r' pick'fzf' atinit'export FZF_DEFAULT_COMMAND="fd --hidden --follow --type file --exclude .git --color=always"; export FZF_DEFAULT_OPTS="--ansi"' \
		junegunn/fzf \
	from'gh-r' pick'ghq/ghq' mv'ghq* -> ghq' \
		x-motemen/ghq \
	from'gh-r' pick'lazygit/lazygit' mv'lazygit* -> lazygit' \
		jesseduffield/lazygit \
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

zinit wait lucid as'completion' for \
	https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
	atinit'zicompinit' https://github.com/zsh-users/zsh-completions/blob/master/src/_yarn
