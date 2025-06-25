#####################################
#         ZSH CONFIGURATION         #
#####################################

# Zinit installation and initialization
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load plugins with turbo loading for better performance
zinit wait lucid for \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::common-aliases

# Additional completions (loaded immediately)
zinit ice wait"0" lucid blockf
zinit light zsh-users/zsh-completions

# Command autosuggestions (loaded with slight delay)
zinit ice wait"0" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# History substring search (load before syntax highlighting)
zinit ice wait"0" lucid atload"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
"
zinit light zsh-users/zsh-history-substring-search

# Syntax highlighting (must load last, with delay)
zinit ice wait"0" lucid
zinit light zsh-users/zsh-syntax-highlighting

#####################################
#       ENVIRONMENT VARIABLES       #
#####################################

# Set Neovim as default editor for git commits, etc.
export EDITOR="nvim"

# FZF (fuzzy finder) configuration
export FZF_DEFAULT_COMMAND="fd . $HOME"        # Default search command using fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"  # CTRL-T file search
export FZF_ALT_C_COMMAND="fd -t d . $HOME"     # ALT-C directory search

#####################################
#            PATH SETUP             #
#####################################

# Ruby version manager - adds rbenv to PATH and initializes it
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# PostgreSQL 12 binaries for Grailed development
export PATH="$PATH:/opt/homebrew/Cellar/postgresql@12/12.16/bin"

# Python tools installed via pipx
export PATH="$PATH:/Users/sai/.local/bin"

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
alias ls='eza --icons --color=always --group-directories-first'           # Basic listing
alias lsl='eza --git --icons --color=always --group-directories-first --long'  # Detailed listing
alias lst='eza --git --icons --color=always --group-directories-first --tree'  # Tree view

# Directory navigation shortcuts (not included in common-aliases)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git workflow shortcuts
alias gfu='git commit --fixup'                                    # Create fixup commit
alias fix='git diff --name-only | uniq | xargs $EDITOR'          # Edit all changed files

# General tools
alias t='tmux'                                                     # Quick tmux access
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'  # Dotfiles management

# Apple Silicon Mac - force specific architectures
if [[ "$(uname -s)" == "Darwin" && "$(uname -m)" == "arm64" ]]; then
  alias brew="arch -arm64 brew"      # Use ARM64 Homebrew
fi
alias rben="arch -x86_64 rbenv"    # Use x86_64 rbenv if needed

# Quick navigation to Obsidian notes
alias oo='cd $HOME/library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain'

#####################################
#         EXTERNAL TOOLS            #
#####################################

# Zoxide - allows quick directory jumping based on frecency (frequency + recency)
eval "$(zoxide init zsh)"

# FZF fuzzy finder integration - adds CTRL-R history search, CTRL-T file search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#####################################
#         PROMPT CONFIGURATION      #
#####################################

# Pure prompt - minimal, fast, and customizable ZSH prompt
autoload -U promptinit; promptinit

# Show command execution time if longer than 3 seconds
PURE_CMD_MAX_EXEC_TIME=3

# Nord theme colors for Pure prompt
zstyle :prompt:pure:path color '#8fbcbb'        # Path color (frost)
zstyle :prompt:pure:git:branch color '#d8dee9'  # Git branch (snow storm)
zstyle :prompt:pure:git:arrow color '#88c0d0'   # Git arrows (frost)
zstyle :prompt:pure:git:stash color '#88c0d0'   # Git stash indicator (frost)
zstyle :prompt:pure:git:stash show yes          # Show git stash count

# Activate Pure prompt
prompt pure

#####################################
#           COMPLETIONS             #
#####################################

# Enable ZSH completions system
autoload -U compinit && compinit

# GT (GraphTerm) tool completions - provides tab completion for gt command
_gt_yargs_completions() {
  local reply
  local si=$IFS
  IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
