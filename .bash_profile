GIT_PS1_SHOWDIRTYSTATE=true
#PS1='[\u@\h: $(__git_ps1 "(%s)")\W]\$ '
PS1='\[\e[34m\]\w \[\e[37m\]\$\[\e[0m\] '

export HISTTIMEFORMAT="%Y/%m/%d(%a) %T  "
HISTSIZE=10000000

alias ll='ls -la'
alias grep='grep --color'
alias df='df -h'
alias rl='exec $SHELL -l'
alias gc='git commit'
alias gl='git log -p'
alias gp='git push'
alias gb='git branch'
alias gm='git merge'
alias gco='git checkout'
alias gs='git stash save'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gca='git commit --amend'
alias gcp='git cherry-pick'
alias mc='make commit'
alias vs='code .' # to start VSCode
alias dps='docker ps'
alias ds='docker stop'
alias dcs='docker-compose stop'
alias dcu='docker-compose up'
alias cg='cd ~/Documents/git'
alias awsl='aws --endpoint-url=http://localhost:4566/'
alias s='bundle exec rspec'

export BASH_SILENCE_DEPRECATION_WARNING=1

# For golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# homebrew for m1
export PATH=/opt/homebrew/bin:$PATH

export PATH=/Users/chiyuu/Documents/dev/flutter/bin:$PATH

# nodenv
PATH="$HOME/.nodenv/bin:$PATH"
if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi
# To use firebase-tools installed in npm of nodenv node
export PATH=$HOME/.nodenv/versions/16.19.1/bin:$PATH

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"
