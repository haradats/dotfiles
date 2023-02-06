export DATABASE_PASSWORD='your_password'
export ALTERNATE_EDITOR=vim

local uname=`uname -r`
local wsl1='*[mM]icrosoft'
local wsl2='*wsl'
local mac='[0-9]+.[0-9]+.[0-9]+'

if [[ "$uname" == $~wsl1 || "$uname" == $~wsl2 ]]; then
    # running WSL
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # ubuntu
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
elif [[ $uname == $~mac ]]; then
    ### running mac (homebrew)
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

if [ -f env-`hostname`.sh ]; then
    source env-`hostname`.sh
fi
