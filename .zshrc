# Path to your oh-my-zsh installation.
export ZSH="/Users/andrew/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

export FZF_BASE=/usr/local/bin/fzf

plugins=(git osx history-substring-search poetry zsh-completions fzf)

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color
export KEYTIMEOUT=1

# vim bindings - thanks https://dougblack.io/words/zsh-vi-mode.html
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[2 q"
        else
            # the insert mode for vi
            echo -ne "\e[5 q"
        fi
    fi
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# History search on k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Disable up and down arrows to force vim keybinding navigation
bindkey -s '^[[A' ''
bindkey -s '^[[B' ''
# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en

export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Random additions to path
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# Set personal aliases
alias prp="pipenv run python"
alias sp="spotify"
alias spp="spotify play"
alias sps="spotify pause"
alias spn="spotify next"
alias spt="spotify status"
alias vim="nvim"
alias diff="colordiff"

# For agnoster theme to remove machine name beside user name
DEFAULT_USER=andrew
prompt_context(){}
# For agonster theme, only show one directory up in prompt
prompt_dir() {
  prompt_segment blue black '%1~'
}

# Reload zsh completions
autoload -U compinit && compinit

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrew/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/andrew/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrew/google-cloud-sdk/completion.zsh.inc'; fi

# Pyenv setup
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Work specific environment vars
source ~/.berylenv
