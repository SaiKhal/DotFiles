####################################
#         ZSH CORE SETUP           #
####################################

autoload -Uz compinit && compinit

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory \
       hist_ignore_space hist_ignore_all_dups \
       hist_ignore_dups hist_save_no_dups

####################################
#          ZINIT / PLUGINS         #
####################################

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Core plugins
zinit wait lucid for \
  OMZP::git \
  OMZP::common-aliases

zinit ice wait"0" lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait"0" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"0" lucid atload"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
"
zinit light zsh-users/zsh-history-substring-search

# fzf-tab for completion UI
zinit light Aloxaf/fzf-tab

# Syntax highlighting (last)
zinit ice wait"0" lucid
zinit light zsh-users/zsh-syntax-highlighting

####################################
#       ENVIRONMENT VARIABLES      #
####################################

export EDITOR="nvim"

# FZF + fd integration
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd . $HOME"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd -t d . $HOME"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# Simple profile hook (work, server, etc.)
: "${SHELL_PROFILE:=default}"

####################################
#            PATH / TOOLS          #
####################################

# Homebrew (Linux)
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Mac
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
  export PATH="$PATH:/Users/sai/.local/bin"

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

  alias oo='cd "$HOME/library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"'

  # Apple Silicon
  if [[ "$(uname -m)" == "arm64" ]]; then
    alias brew="arch -arm64 brew"
    alias rben="arch -x86_64 rbenv"
  fi
fi

# rbenv
if command -v rbenv >/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

#####################################
#             ALIASES               #
#####################################

# ZSH configuration shortcuts
alias zshconfig="nvim ~/.zshrc"    # Edit this file
alias zshsource='source ~/.zshrc'  # Reload this file

# Editor shortcuts
alias v='nvim'      # Quick Neovim access
alias vim='nvim'    # Override vim with Neovim

# Enhanced file listing with exa (replacement for ls)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --color=always --group-directories-first'
  alias lsl='eza --git --icons --color=always --group-directories-first --long'
  alias lst='eza --git --icons --color=always --group-directories-first --tree'
else
  alias lsl='ls -lah'
  alias lst='ls -R'
fi

# Directory navigation shortcuts (not included in common-aliases)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git workflow shortcuts
alias gfu='git commit --fixup'                                    # Create fixup commit
alias fix='git diff --name-only | uniq | xargs $EDITOR'          # Edit all changed files

# General tools
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'  # Dotfiles management
alias ctig='GIT_DIR=$HOME/.cfg GIT_WORK_TREE=$HOME tig'             # Dotfiles with tig

if command -v tmux >/dev/null 2>&1; then
  alias tm='tmux'
fi

#####################################
#         PROMPT CONFIGURATION      #
#####################################

# Pure prompt - minimal, fast, and customizable ZSH prompt
autoload -U promptinit; promptinit

# Show command execution time if longer than 3 seconds
PURE_CMD_MAX_EXEC_TIME=3

# Nord theme colors for Pure prompt
# zstyle :prompt:pure:path color '#8fbcbb'        # Path color (frost)
# zstyle :prompt:pure:git:branch color '#d8dee9'  # Git branch (snow storm)
# zstyle :prompt:pure:git:arrow color '#88c0d0'   # Git arrows (frost)
# zstyle :prompt:pure:git:stash color '#88c0d0'   # Git stash indicator (frost)
zstyle :prompt:pure:git:stash show yes          # Show git stash count

# Activate Pure prompt
prompt pure

#####################################
#           COMPLETIONS             #
#####################################

# Case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
