
# set aliases for frequently used commands
alias vi='vim'
alias ch='pushd +1'
alias b='bundle exec'
alias less='less -R'

# heroku
alias heroku-rebuild="git commit --amend -C HEAD; git push -f heroku master"

# google cloud sdk on docker
alias dgcloud-init="docker run -it --name gcloud-config google/cloud-sdk gcloud auth login"
alias dgcloud="docker run --rm -it -v $PWD:/work -w /work --volumes-from gcloud-config google/cloud-sdk gcloud"
alias dgsutil="docker run --rm -it -v $PWD:/work -w /work --volumes-from gcloud-config google/cloud-sdk gsutil"

#for ls
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'

#typo
alias l='ls'
alias sl='ls'
alias scd='cd'
alias svi='vi'
