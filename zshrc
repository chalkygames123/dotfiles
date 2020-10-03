# .zshrc

# User specific aliases and functions

alias ll='ls -AFG'
alias o='open .'
alias b='npx open $(git remote get-url origin | sed -e s/\.git$//)'
alias g=git
alias a='git add .'
alias d='git diff'
alias l='git log --graph'
alias p='git pull --all'
alias s='git status'
alias y=yarn
alias c='code .'
alias dcu='docker-compose up'
alias ggs='gg status'
alias ggsv='gg status --ignored --show-stash'
alias ggf='gg fetch --all'

gc() {
  local DIR=$(ghq list | fzf)

  [[ -n $DIR ]] && cd "$(ghq root)/$DIR"
}

gg() {
  local DIRS=$(ghq list)
  local ESC=$(printf '\033')
  local COLUMNS=$(tput cols)

  echo $DIRS | while IFS= read -r DIR; do
    printf "${ESC}[34m"
    printf "\n%s\n" $DIR
    printf '─%.0s' {1..$COLUMNS}
    printf '\n\n'
    printf "${ESC}[m"

    git -C "$(ghq root)/$DIR" "$@"
  done
}

go() {
  local DIR=$(ghq list | fzf)

  [[ -n $DIR ]] && npx open $(git -C "$(ghq root)/$DIR" remote get-url origin | sed -e 's/\.git$//')
}

my-backward-delete-word() {
  local WORDCHARS=${WORDCHARS//[-\/]/}
  zle backward-delete-word
}

touchp() {
  for arg in "$@"; do
    mkdir -p $(dirname $arg) && touch $arg
  done
}

zle -N my-backward-delete-word
bindkey '^W' my-backward-delete-word
bindkey '^U' backward-kill-line
bindkey "^[[Z" reverse-menu-complete
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2

setopt MAGIC_EQUAL_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# User specific environment and startup programs

PS1='
%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'
HISTFILE=~/dotfiles/zsh_history
HISTSIZE=256
SAVEHIST=256
fpath=(
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
