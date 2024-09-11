# .zshrc

# -----------------------------
# general settings
## key bindings
bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

## autoload
autoload -Uz compinit ; compinit
zstyle ':completion:*:default' menu select=2
autoload -Uz colors ; colors

## prompt
PROMPT='%F{green}%~%f%F{red}$(__display_git_ps1)%f $ '
function __display_git_ps1() {
  if type __git_ps1 > /dev/null 2>&1; then
    __git_ps1 " %s"
  fi
}

# -----------------------------
# variables
## general
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
export LANG=ja_JP.UTF-8
export EDITOR=vim

## colors
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

## homebrew
export PATH=/opt/homebrew/bin:$PATH

## golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

## flutter
export PATH=$HOME/Documents/dev/flutter/bin:$PATH

## rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# -----------------------------
# options
setopt auto_cd
setopt mark_dirs
setopt correct
setopt correct_all
setopt no_beep
setopt nolistbeep
setopt PROMPT_SUBST
source ~/.zsh/.git-prompt.sh
setopt print_eight_bit

## history
setopt hist_no_store
setopt extended_history
setopt inc_append_history
setopt hist_verify
setopt hist_expand
setopt share_history
HISTTIMEFORMAT="%y/%m/%d %T"

# -----------------------------
# aliases
alias ll='ls -lah'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias mc='make commit'
alias vi='vim'
alias grep='grep --color'
alias df='df -h'
alias rl='exec $SHELL -l'
alias vs='code .'
alias dps='docker ps'
alias cg='cd ~/Documents/git'
alias awsl='aws --endpoint-url=http://localhost:4566/'
alias history='history -i'
alias tb="~/toggle_bluetooth_device_connection.sh"

## git
alias g='git'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit'
alias gcp='git cherry-pick'
alias gca='git commit --amend'
alias gl='git log -p'
alias gp='git push'
alias gm='git merge'
alias gco='git checkout'
alias gs='git stash'
alias gsm='git stash push -m'
alias gri='git rebase -i'
alias grc='git rebase --continue'

## docker
alias ds='docker stop'
alias dcs='docker-compose stop'
alias dcu='docker-compose up'

## ruby
alias s='bundle exec rspec'
