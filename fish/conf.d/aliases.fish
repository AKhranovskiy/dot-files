# GIT quick commands
alias gsb="git status -sb"
alias gpr="git pull --rebase"
alias gca!="git commit -v --amend"
alias gco="git checkout"
alias gcob="git checkout -B"
alias gwip='git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "[WIP]"'
alias gunwip='git log -n 1 | grep -q -c "[WIP]"; and git reset HEAD~1'
alias gsts="git stash save"
alias gsta="git stash apply"
alias gstt="git stash show --text"

# ls replacement with LSD
alias ls="lsd --color auto --icon-theme fancy --icon always"
