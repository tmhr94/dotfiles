PS1='\[\e[34m\]\w \[\e[37m\]\$\[\e[0m\] '

export HISTTIMEFORMAT="%Y/%m/%d(%a) %T  "
HISTSIZE=10000000

alias ll='ls -la'
alias grep='grep --color'
alias df='df -h'
alias rl='exec $SHELL -l'
alias gc='git commit'
alias gs='git stash save'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gca='git commit --amend'
alias vs='code .' # to start VSCode
