# set aliases for frequently used commands
alias ch='pushd +1'
alias b='bundle exec'
alias less='less -R'
alias ec='exec code'
alias ecode='exec code'

# hexdump
alias hexdump1='od -t x1 -Ax'
alias hexdump2='od -t x2 -Ax'
alias hexdump4='od -t x4 -Ax'

# heroku
alias heroku-rebuild="git commit --amend --no-edit; git push -f heroku master"

# google cloud sdk on docker
alias dgcloud-init="docker run -it --name gcloud-config google/cloud-sdk gcloud auth login"
alias dgcloud="docker run --rm -it -v $PWD:/work -w /work --volumes-from gcloud-config google/cloud-sdk gcloud"
alias dgsutil="docker run --rm -it -v $PWD:/work -w /work --volumes-from gcloud-config google/cloud-sdk gsutil"

# for ls
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

# typo
alias l='ls'
alias sl='ls'
alias scd='cd'
alias svi='vi'
