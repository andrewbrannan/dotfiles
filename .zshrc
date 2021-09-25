# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

export FZF_BASE=/usr/local/bin/fzf

plugins=(git osx history-substring-search fzf)

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color
export KEYTIMEOUT=1

source $ZSH/antigen.zsh
antigen bundle darvid/zsh-poetry
antigen bundle zsh-users/zsh-completions
antigen apply

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
export PATH="$HOME/.local/bin:$PATH"
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

# npx shell fallback
command_not_found_handler() {
  # Do not run within a pipe
  if test ! -t 1; then
    >&2 echo "command not found: $1"
    return 127
  fi
  if which npx > /dev/null; then
    echo "$1 not found. Trying with npx..." >&2
  else
    return 127
  fi
  if ! [[ $1 =~ @ ]]; then
    npx --no-install "$@"
  else
    npx "$@"
  fi
  return $?
}


# For agnoster theme to remove machine name beside user name
DEFAULT_USER=andrew
prompt_context(){}
# For agonster theme, only show one directory up in prompt
prompt_dir() {
  prompt_segment blue black '%1~'
}

# Whack a newline onto the prompt
NEWLINE=$'\n'
export PROMPT="$PROMPT $NEWLINE👉 "

# Reload zsh completions
autoload -U bashcompinit && bashcompinit
autoload -U compinit && compinit

# pipx completions
eval "$(register-python-argcomplete pipx)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrew/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/andrew/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrew/google-cloud-sdk/completion.zsh.inc'; fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Work specific environment vars
source ~/.berylenv

# Created by `userpath` on 2021-02-07 12:44:20
export PATH="$PATH:/Users/andrew/.local/bin"

# Pyenv setup
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
