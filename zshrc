# .zshrc

# User specific aliases and functions

alias ll='ls -ghloAFG'
alias o='open .'
alias b='npx open $(git remote get-url origin | sed -e s/\.git$//)'
alias git=hub
alias g=git
alias a='git add .'
alias d='git diff'
alias l='git log --graph --pretty=format:"%C(auto)%h%d %s %Cgreen(%cr) %Cblue<%an>"'
alias p='git pull --all'
alias s='git status'
alias y=yarn
alias c='code .'
alias dcu='docker-compose up'

gb() {
  local DIR=$(ghq list | fzf)

  [[ -n $DIR ]] && npx open $(git -C "$(ghq root)/$DIR" remote get-url origin | sed -e 's/\.git$//')
}

gc() {
  local DIR=$(ghq list | fzf)

  [[ -n $DIR ]] && cd "$(ghq root)/$DIR"
}

gs() {
  local DIRS=$(ghq list)
  local ESC=$(printf '\033')
  local SHOULD_VERBOSE=0

  for arg in "$@"
  do
    case $arg in
      -v|--verbose)
      SHOULD_VERBOSE=1
      shift
      ;;
    esac
  done

  echo $DIRS | while IFS= read -r DIR; do
    printf "\n${ESC}[1;34m%s:${ESC}[m\n\n" $DIR

    if [[ $SHOULD_VERBOSE == 1 ]]; then
      git -C "$(ghq root)/$DIR" status --ignored --show-stash
    else
      git -C "$(ghq root)/$DIR" status
    fi
  done
}

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

export LESSHISTFILE=-
export BAT_THEME=ansi-light
export NVS_HOME=~/.nvs

fpath=(
  ~/.zsh/completion
  /usr/local/share/zsh-completions
  $fpath
)

# https://github.com/github/hub/issues/1956
[[ -s '/usr/local/share/zsh/site-functions/_git' ]] &&
   rm '/usr/local/share/zsh/site-functions/_git'

autoload -U compinit && compinit -u

eval "$(direnv hook zsh)"

[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh" && nvs auto on && nvs auto

command -v pyenv &> /dev/null && eval "$(pyenv init -)"
