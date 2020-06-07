#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/kameronkincade/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ------------------- User configuration ---------------------

# ----- ENVIRONMENT VARIABLES -----

# These need to be lines 24 and 25 of the file, otherwise the vm() function won't work.
export VM_NAME="WKKINCACO01FB02"
export local_api_endpoint="172.28.98.49"

export MOBILE_PATH="/Users/kameronkincade/Developer/mobile"
export FALCOR_SOFTWARE_PATH="/Volumes/"$VM_NAME"/Falcor/Software"
export VM_NAME_FULL=$VM_NAME".dev.adcinternal.com"

# ----- HELPFUL ALIASES -----

alias cd.d="cd ~/Developer"
alias cd.ce="cd ~/Developer/software/Websites/Web/customer-ember"
alias cd.ics="cd ~/Developer/ember-applications/initial-customer-setup"
alias cd.uic="cd ~/Developer/ember-addons/adc-ui-components"
alias cd.ai="cd ~/Developer/ember-addons/adc-app-infrastructure"
alias cd.f="cd ~/Developer/falcor"
alias cd.vm="cd /Volumes/"$VM_NAME
alias cd.m="cd ~/Developer/mobile"
alias cd.ios="cd ~/Developer/mobile/de-alarm"
alias cd.android="cd ~/Developer/mobile/AlarmMobile"
alias clean-ios="cd.ios && git checkout Develop && git pull && cd ../branded-apps && git pull && cd.ios"
alias clean-build="rm -rf node_modules/ tmp/ && yarn && grunt ci && ember build --watch"
alias clean-serve="rm -rf node_modules/ tmp/ && yarn && ember s"
alias z="sublime ~/.zshrc"

function vm() {
    if mount | grep "on /Volumes/WKKINCACO01FB0"$1 > /dev/null;  
    then
        echo "WKKINCACO01FB0"$1 "is mounted."
    else
        echo "Mounting VM -> WKKINCACO01FB0"$1
        echo
        mount-vm "WKKINCACO01FB0"$1

        printf "Press y once VM is mounted...\n\n";
        read -rs -k 1 ans

        if [[ "$ans" != "y" ]]
        then
            printf "\nVM not changed in .zshrc!\n"
            return 1
        fi
    fi

    printf "Updating Environment Variables.\n"
    if [[ $1 == 1 ]]
    then
        # NOTE: This edits specific lines of this file (24 and 25).
        sed -i '' -e '24s/VM_NAME="[[:digit:][:alpha:]]*"/VM_NAME="WKKINCACO01FB01"/' ~/.zshrc
        sed -i '' -e '25s/local_api_endpoint="[[:digit:][:alpha:]\.]*"/local_api_endpoint="172.28.97.70"/' ~/.zshrc
    else
        sed -i '' -e '24s/VM_NAME="[[:digit:][:alpha:]]*"/VM_NAME="WKKINCACO01FB02"/' ~/.zshrc
        sed -i '' -e '25s/local_api_endpoint="[[:digit:][:alpha:]\.]*"/local_api_endpoint="172.28.98.49"/' ~/.zshrc
    fi

    # Refresh the terminal
    source ~/.zshrc

    point-mobile-to $local_api_endpoint
}

function mount-vm() {
    VM_TO_MOUNT=${1:-$VM_NAME}
    open "smb://"$VM_TO_MOUNT".dev.adcinternal.com"
}

function cd.ead() {
    cd ~/Developer/ember-addons/$1
}

function cd.eap() {
    cd ~/Developer/ember-applications/$1
}

function cd.jsap() {
    cd ~/Developer/js-applications/$1
}

function npm.u() {
    npm unpublish $1 --registry=http://verdaccio.dev.adcinternal.com
}

# ----- GIT ALIASES -----

git config --global alias.ignore 'update-index --assume-unchanged'
git config --global alias.unignore 'update-index --no-assume-unchanged'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
