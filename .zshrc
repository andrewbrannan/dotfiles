# Path to your oh-my-zsh installation.
export ZSH="/Users/andrew/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git history-substring-search)

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color

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
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

# History search on up/down arrows
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=en:el

export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Random additions to path
export PATH="$HOME/.rbenv/bin:$PATH"

# Set personal aliases
alias prp="pipenv run python"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrew/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/andrew/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrew/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# For agnoster theme to remove machine name beside user name
DEFAULT_USER=andrew
prompt_context(){}
# For agonster theme, only show one directory up in prompt
prompt_dir() {
  prompt_segment blue black '%1~'
}