# .zshrc

PS1='
%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'
HISTFILE=~/dotfiles/zsh_history
HISTSIZE=256
SAVEHIST=256

export LESSHISTFILE=-
export BAT_THEME=ansi-light
export NVS_HOME=~/.nvs

[[ -f ~/.credentials ]] && . ~/.credentials

fpath=(
  ~/.zsh/completion
  /usr/local/share/zsh-completions
  $fpath
)

[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh" && nvs auto && nvs auto on

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

gc() {
  local DIR=$(ghq list --full-path | fzf)

  [[ -n $DIR ]] && cd $DIR
}

gb() {
  local DIR=$(ghq list --full-path | fzf)

  [[ -n $DIR ]] && npx open $(git -C $DIR remote get-url origin | sed -e s/\.git$//)
}

alias ll='ls -ghloAFG'
alias git=hub
alias g=git
alias a='git add .'
alias d='git diff --ignore-space-change'
alias l='git log --abbrev-commit'
alias p='git pull --all'
alias s='git status'
alias y=yarn
alias c='code .'
alias dcu='docker-compose up'

setopt MAGIC_EQUAL_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# https://github.com/github/hub/issues/1956
[[ -r '/usr/local/share/zsh/site-functions/_git' ]] &&
   rm '/usr/local/share/zsh/site-functions/_git'

autoload -Uz compinit && compinit -u

default-backward-delete-word() {
  local WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
  zle backward-delete-word
}

zle -N default-backward-delete-word
bindkey '^W' default-backward-delete-word
bindkey '^[^?' default-backward-delete-word
bindkey "^[[Z" reverse-menu-complete
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2
