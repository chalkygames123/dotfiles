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

gc() {
  local DIR

  DIR=$(ghq list | sort | fzf)

  [[ -n $DIR ]] && cd "$(ghq root)/$DIR" || exit
}

go() {
  local DIR

  DIR=$(ghq list | fzf)

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

touchp() {
  for arg in "$@"; do
    mkdir -p "$(dirname "$arg")" && touch "$arg"
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
export fpath=(
  ~/.zsh/completion
  /usr/local/share/zsh-completions
  $fpath
)

export LESSHISTFILE=-
export BAT_THEME=ansi-light
export NVS_HOME=~/.nvs

# https://github.com/github/hub/issues/1956
[[ -L '/usr/local/share/zsh/site-functions/_git' ]] &&
  rm '/usr/local/share/zsh/site-functions/_git'

autoload -U compinit && compinit -u

eval "$(direnv hook zsh)"

[[ -s "$NVS_HOME/nvs.sh" ]] && . "$NVS_HOME/nvs.sh" && nvs auto on && nvs use auto

command -v pyenv &> /dev/null && eval "$(pyenv init -)"
