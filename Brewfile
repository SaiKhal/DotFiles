#!/usr/bin/env ruby
# Brewfile for dotfiles configuration
# Compatible with macOS and Linux (Homebrew on Linux)

# Check if we're on macOS or Linux
def macos?
  RUBY_PLATFORM.include?('darwin')
end

def linux?
  RUBY_PLATFORM.include?('linux')
end

# Check if work machine (via env var or prompt)
def work?
  return ENV['WORK_MACHINE'] == '1' if ENV['WORK_MACHINE']

  print "Is this a work machine? [y/N] "
  STDIN.gets.to_s.strip.downcase.start_with?('y')
end

WORK_MACHINE = work?

# Tap external repositories

#####################################
# Core Development Tools
#####################################

# Text Editors and Terminal Tools
brew "neovim"              # Modern Vim fork
brew "tmux"                # Terminal multiplexer
brew "fzf"                 # Fuzzy finder
brew "ripgrep"             # Fast text search (rg)
brew "fd"                  # Fast find alternative
brew "bat"                 # Cat with syntax highlighting
brew "eza"                 # Modern ls replacement
brew "zoxide"              # Better CD with Z functionality
brew "pure"                # CLI Prompt
brew "carapace"            # Completion engine for CLI tools

# Git and Version Control
brew "git"                 # Version control
brew "lazygit"             # Terminal UI for git
brew "delta"               # Git diff pager
brew "gh"                  # GitHub CLI

# Development Language Managers
brew "pipx"                # Python package installer

# System Information and Monitoring
brew "neofetch"            # System info display
brew "btop"                # Modern htop alternative

# Workflow and Productivity Tools
brew "jq"                  # JSON processor
brew "curl"                # HTTP client
brew "wget"                # File downloader

#####################################
# macOS-specific Applications
#####################################

if macos?
  # GUI Applications
  cask "wezterm"                  # GPU-accelerated terminal
  cask "karabiner-elements"       # Keyboard customization

  # Fonts
  cask "font-fira-code"           # Programming font with ligatures
  cask "font-fira-code-nerd-font" # Nerd Font version with icons
  cask "font-jetbrains-mono"      # JetBrains programming font
  cask "font-jetbrains-mono-nerd-font" # Nerd Font version

  # Development Tools (macOS GUI)
  cask "visual-studio-code"       # Alternative editor (optional)
  cask "obsidian"                 # Notes

  #####################################
  # Work Machine Only
  #####################################
  if WORK_MACHINE
    brew "rbenv"               # Ruby version manager
    brew "postgresql@12"       # PostgreSQL database
  end
end

#####################################
# Linux-specific packages
#####################################

if linux?
  # Additional Linux tools that might not be available or need different names
  brew "gcc"                      # Compiler collection
  brew "make"                     # Build tool
  brew "cmake"                    # Cross-platform build system

  # Terminal emulators for Linux (if available via Homebrew)
  # Note: kitty and wezterm may need manual installation on Linux
end

#####################################
# Optional Development Tools
#####################################

# Additional useful tools (uncomment as needed)
brew "rust"                      # Rust programming language
brew "go"                        # Go programming language

# brew "node"                      # Node.js runtime
# brew "python@3.13"             # Python interpreter
# brew "docker"                  # Containerization (Linux)
# brew "kubectl"                 # Kubernetes CLI
# brew "terraform"               # Infrastructure as code
# brew "aws-cli"                 # Amazon Web Services CLI

#####################################
# VS Code Extensions (if using VS Code)
#####################################

# vscode "ms-vscode.vscode-json"
# vscode "bradlc.vscode-tailwindcss"
# vscode "esbenp.prettier-vscode"

