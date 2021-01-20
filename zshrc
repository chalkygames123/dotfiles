# .zshrc

# User specific aliases and functions

alias ll='ls -lAFG'
alias o='open .'
alias b='npx --package=open open "$(git remote get-url origin | sed -e s/\.git$//)"'
alias g=git
alias a='git add .'
alias d='git diff'
alias l='git log --graph'
alias p='git pull --all'
alias s='git status'
alias n=npm
alias nr='npm run'
alias y=yarn
alias c='code .'
alias dcu='docker-compose up'
alias ggsv='gg status --ignored --show-stash'

touchp() {
  for arg in "$@"; do
    mkdir -p "$(dirname "$arg")" && touch "$arg"
  done
}

gc() {
  local DIR

  DIR=$(ghq list | sort | fzf)

  [[ -n $DIR ]] && cd "$(ghq root)/$DIR" || exit
}

go() {
  local DIR

  DIR=$(ghq list | sort | fzf)

  [[ -n $DIR ]] && npx --package=open open "$(git -C "$(ghq root)/$DIR" remote get-url origin | sed -e 's/\.git$//')"
}

gg() {
  local DIRS
  local ESC
  local COLUMNS

  DIRS=$(ghq list | sort)
  ESC=$(printf '\033')
  COLUMNS=$(tput cols)

  echo "$DIRS" | while IFS= read -r DIR; do
    printf '%s[34m' "${ESC}"
    printf '\n%s\n' "$DIR"
    printf '─%.0s' {1.."$COLUMNS"}
    printf '\n\n%s[m' "${ESC}"

    git -C "$(ghq root)/$DIR" "$@"
  done
}

_my-backward-delete-word() {
  local WORDCHARS=${WORDCHARS//[-\/]/}
  zle backward-delete-word
}

zle -N _my-backward-delete-word
bindkey '^W' _my-backward-delete-word
bindkey '^U' backward-kill-line
bindkey '^[[Z' reverse-menu-complete
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2

setopt MAGIC_EQUAL_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# User specific environment and startup programs

export PS1='
%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'
export HISTFILE=~/dotfiles/zsh_history

export LESSHISTFILE=-
export BAT_THEME=ansi-light

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit lucid for \
  pick'nvs.sh' atload'[[ ! -L default ]] && nvs add latest && nvs link latest; nvs auto on && nvs use auto' light-mode jasongin/nvs

zinit wait lucid as'program' for \
  from'gh-r' pick'bat/bat' mv'bat* -> bat' @sharkdp/bat \
  from'gh-r' pick'gh/bin/gh' mv'gh* -> gh' cli/cli \
  from'gh-r' pick'delta/delta' mv'delta* -> delta' dandavison/delta \
  from'gh-r' pick'direnv' src'zhook.zsh' mv'direnv* -> direnv' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' direnv/direnv \
  from'gh-r' pick'dust/dust' mv'dust* -> dust' bootandy/dust \
  from'gh-r' pick'fzf' junegunn/fzf \
  from'gh-r' pick'ghq/ghq' mv'ghq* -> ghq' x-motemen/ghq \
  pick'bin/pyenv' src'zinit.zsh' atclone'./bin/pyenv init - > zinit.zsh' atpull'%atclone' atinit'export PYENV_ROOT=$(pwd)' pyenv/pyenv \
  from'gh-r' pick'ripgrep/rg' mv'ripgrep* -> ripgrep' BurntSushi/ripgrep \
  from'gh-r' bpick'*.tar.gz' pick'yarn/bin/yarn' mv'yarn* -> yarn' yarnpkg/yarn

zinit wait lucid as'completion' for \
  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
  https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose \
  atinit'zicompinit' https://github.com/zsh-users/zsh-completions/blob/master/src/_yarn
