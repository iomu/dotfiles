# history
source $HOME/.config/zsh/history.zsh

### zplug

# Check if zplug is installed and install it if necessary
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source $HOME/.zplug/init.zsh

source $HOME/.config/zsh/plugins.zsh

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load
source /usr/share/nvm/init-nvm.sh
