# .zshrc

# general settings
bindkey -v

## autoload
autoload -Uz compinit
compinit
autoload colors
colors

## prompt
PROMPT='%F{green}%~%f%F{red}$(__display_git_ps1)%f $ '
function __display_git_ps1() {
  if type __git_ps1 > /dev/null 2>&1; then
    __git_ps1 " %s"
  fi
}

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
alias vs='code .' # to start VSCode
alias dps='docker ps'
alias cg='cd ~/Documents/git'
alias awsl='aws --endpoint-url=http://localhost:4566/'

## git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcp='git cherry-pick'
alias gca='git commit --amend'
alias gl='git log -p'
alias gp='git push'
alias gm='git merge'
alias gs='git status'
alias gco='git checkout'
alias gss='git stash save'
alias gst='git stash'
alias gri='git rebase -i'
alias grc='git rebase --continue'

## docker
alias ds='docker stop'
alias dcs='docker-compose stop'
alias dcu='docker-compose up'

## ruby
alias s='bundle exec rspec'

# variables
## general
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000000
export LANG=ja_JP.UTF-8
setopt print_eight_bit

## homebrew
export PATH=/opt/homebrew/bin:$PATH
## golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
## flutter
export PATH=$HOME/Documents/dev/flutter/bin:$PATH
## rbenv
[[ -d ~/.rbenv  ]] && \

# options
setopt auto_cd
setopt no_beep
setopt nolistbeep
setopt PROMPT_SUBST
source ~/.zsh/.git-prompt.sh
