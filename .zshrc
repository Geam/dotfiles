#### MY_CONFIG ################################################################
MY_CONFIG=$HOME/.config/my_config

#### PATH and FPATH ###########################################################
## local npm packages
PATH=$HOME/.npm-packages/bin:$PATH
## local programs
PATH=$HOME/.local/bin:$PATH
## manually install local programs or scripts
PATH=$HOME/bin:$PATH

#### ZSH CONFIG ###############################################################
# zsh history
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTSIZE=5000
setopt inc_append_history
setopt share_history
setopt hist_ignore_dups

# better autocomplete
autoload -U compinit && compinit

# completion style
zstyle ':completion:*' menu select                              # menu styled completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# ssh completion
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|sftp):*' users $users
zstyle ':completion:*' matcher-list ''

# prompt color
autoload -U colors && colors

# better word selection (usefull for ctrl+w)
autoload -U select-word-style
select-word-style bash

# vim mode
bindkey -v

# vim bindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

#### LOAD SUB FILE ############################################################
# Load user variables
source $HOME/.profile

# Load aliases
source "$MY_CONFIG/aliases"

# Load prompt
source "$MY_CONFIG/prompt"

# Load fzf config
source "$MY_CONFIG/fzf"

# Load secrets
if [[ -e "$MY_CONFIG/secrets" ]]; then
    source "$MY_CONFIG/secrets"
fi

#### GLOBAL ###################################################################
# Couleurs pour le man
man()
{
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# ssh-agent socket
# disable as it is not needed with KDE
#export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# vim: filetype=zsh tabstop=4 shiftwidth=4 expandtab

