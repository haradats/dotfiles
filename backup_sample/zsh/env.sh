export DATABASE_PASSWORD='your_password'

export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export ALTERNATE_EDITOR=vim

local uname=`uname -r`
local wsl1='[ -][mM]icrosoft'
local wsl2='[ -](wsl | WSL)'
local mac='[0-9]+\.[0-9]+\.[0-9]+'

echo -n $uname
if [[ $uname =~ $wsl1 || $uname =~ $wsl2 ]]; then
    # running WSL
    echo " (WSL)"
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # ubuntu
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
elif [[ $uname =~ $mac ]]; then
    ### running mac (homebrew)
    echo " (mac)"
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
else
    echo ""
fi
