export DATABASE_PASSWORD='your_password'

export ALTERNATE_EDITOR=vim

if [ ! `uname -r | grep -iq wsl` ]; then
    # running WSL
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # ubuntu

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # osx (homebrew)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
