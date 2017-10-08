#!/bin/zsh
#zplug "NelsonBrandao/absolute", use:absolute.zsh-theme, from:github, as:theme

zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh-theme, as:theme
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false

zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/svn", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", defer:1
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # Should be loaded 2nd last.

# history subsearch
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
