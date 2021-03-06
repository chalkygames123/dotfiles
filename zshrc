alias ll='ls -AFGl'
alias o='open .'
alias g=git
alias a='git add .'
alias d='git diff'
alias l='git log --graph'
alias p='git pull --all'
alias s='git status'
alias dg='git -C ~/dotfiles/'
alias ggsv='gg status --ignored --show-stash'
alias n=npm
alias nr='npm run'
alias b='open "$(git remote get-url origin | sed '\''s/\.git$//'\'')"'
alias y=yarn
alias v=volta
alias c='code .'

touchp() {
  for arg in "$@"; do
    mkdir -p "$(dirname "$arg")" && touch "$arg"
  done
}

cdf() {
  DIR=$(dirname "$(fzf)")

  [[ -n $DIR ]] && cd "$DIR" || return
}

gc() {
  local DIR

  DIR=$(ghq list | sort | fzf)

  [[ -n $DIR ]] && cd "$(ghq root)/$DIR" || return
}

go() {
  local DIR

  DIR=$(ghq list | sort | fzf)

  [[ -n $DIR ]] && open "$(git -C "$(ghq root)/$DIR" remote get-url origin | sed 's/\.git$//')"
}

gg() {
  local DIRS
  local ESC
  local COLUMNS

  DIRS=$(ghq list | sort)
  ESC=$(printf '\033')
  COLUMNS=$(tput cols)

  echo "$DIRS" | while IFS= read -r DIR; do
    printf '%s[34m' "$ESC"
    printf '\n%s\n' "$DIR"
    printf '─%.0s' {1.."$COLUMNS"}
    printf '\n\n%s[m' "$ESC"

    git -C "$(ghq root)/$DIR" "$@"
  done
}

_my-backward-delete-word() {
  local WORDCHARS=${WORDCHARS//[-\/]/}

  zle backward-delete-word
}

zle -N _my-backward-delete-word
bindkey '^[[Z' reverse-menu-complete
bindkey '^[^?' _my-backward-delete-word
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=2

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt MAGIC_EQUAL_SUBST
unsetopt FLOW_CONTROL

export PS1='
%B%F{magenta}%*%f %F{cyan}%c%f %F{magenta}%%%f %b'
export HISTFILE=~/dotfiles/zsh_history

export LESSHISTFILE=-

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

zinit wait lucid as'program' for \
  from'gh-r' pick'bat/bat' mv'bat* -> bat' atclone'mkdir -p man/man1 && ln -fs ../../bat/bat.1 man/man1; ln -fs bat/autocomplete/bat.zsh _bat' atpull'%atclone' atinit'export BAT_THEME=ansi-light' @sharkdp/bat \
  from'gh-r' pick'gh/bin/gh' mv'gh* -> gh' atclone'./gh/bin/gh completion --shell zsh > _gh' atpull'%atclone' cli/cli \
  from'gh-r' pick'delta/delta' mv'delta* -> delta' dandavison/delta \
  from'gh-r' pick'direnv' src'zdirenv.zsh' mv'direnv* -> direnv' atclone'./direnv hook zsh > zdirenv.zsh' atpull'%atclone' direnv/direnv \
  from'gh-r' pick'dust/dust' mv'dust* -> dust' bootandy/dust \
  from'gh-r' pick'fd/fd' mv'fd* -> fd' atclone'mkdir -p man/man1 && ln -fs ../../fd/fd.1 man/man1' atpull'%atclone' @sharkdp/fd \
  pick'bin/fzf' atclone'./install --bin' atpull'%atclone' atinit'export FZF_DEFAULT_COMMAND="fd --hidden --follow --type file --exclude .git --color=always"; export FZF_DEFAULT_OPTS="--ansi"' junegunn/fzf \
  from'gh-r' pick'ghq/ghq' mv'ghq* -> ghq' x-motemen/ghq \
  pick'bin/pyenv' src'zpyenv.zsh' atclone'PYENV_ROOT="$PWD" ./bin/pyenv init - > zpyenv.zsh' atpull'%atclone' atinit'export PYENV_ROOT="$PWD"' pyenv/pyenv \
  from'gh-r' pick'ripgrep/rg' mv'ripgrep* -> ripgrep' atclone'mkdir -p man/man1 && ln -fs ../../ripgrep/doc/rg.1 man/man1' atpull'%atclone' BurntSushi/ripgrep \
  from'gh-r' bpick'*macos.tar.gz' pick'volta' atclone'VOLTA_HOME="$PWD" ./volta completions zsh > _volta' atpull'%atclone' atinit'export VOLTA_HOME="$PWD"; export PATH="$VOLTA_HOME/bin:$PATH"' volta-cli/volta \
  from'gh-r' bpick'*.tar.gz' pick'yarn/bin/yarn' mv'yarn* -> yarn' yarnpkg/yarn

zinit wait lucid as'completion' for \
  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
  https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose \
  atinit'zicompinit' https://github.com/zsh-users/zsh-completions/blob/master/src/_yarn
