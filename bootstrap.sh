#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/fedora-release ]]; then
        echo "fedora"
    elif [[ -f /etc/os-release ]]; then
        source /etc/os-release
        echo "${ID:-linux}"
    else
        echo "unknown"
    fi
}

install_homebrew() {
    if command -v brew &>/dev/null; then
        log_success "Homebrew already installed"
        return 0
    fi

    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    if [[ "$OS" == "macos" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
    else
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    log_success "Homebrew installed"
}

install_fedora_deps() {
    log_info "Installing Fedora dependencies for Homebrew..."

    sudo dnf groupinstall -y 'Development Tools'
    sudo dnf install -y \
        procps-ng \
        curl \
        file \
        git \
        which \
        stow

    log_success "Fedora dependencies installed"
}

install_macos_deps() {
    # Install Xcode Command Line Tools if needed
    if ! xcode-select -p &>/dev/null; then
        log_info "Installing Xcode Command Line Tools..."
        xcode-select --install
        read -p "Press enter after Xcode CLI tools finish installing..."
    fi
    log_success "Xcode CLI tools ready"
}

install_packages() {
    log_info "Installing packages from Brewfile..."

    if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
        brew bundle --verbose --file="$DOTFILES_DIR/Brewfile"
        log_success "Brewfile packages installed"
    else
        log_warn "No Brewfile found at $DOTFILES_DIR/Brewfile"
    fi

    log_info "Finished install_packages"
}

install_stow() {
    if command -v stow &>/dev/null; then
        log_success "GNU Stow already installed"
        return 0
    fi

    log_info "Installing GNU Stow..."
    if [[ "$OS" == "fedora" ]]; then
        sudo dnf install -y stow
    else
        brew install stow
    fi
    log_success "GNU Stow installed"
}

stow_dotfiles() {
    log_info "Stowing dotfiles..."

    cd "$DOTFILES_DIR"

    # List of packages to stow (directories in dotfiles repo)
    local packages=(zsh nvim tmux claude ghostty wezterm)

    for pkg in "${packages[@]}"; do
        if [[ -d "$pkg" ]]; then
            log_info "Stowing $pkg..."
            stow --restow "$pkg" || log_warn "Failed to stow $pkg (conflicts?)"
        else
            log_warn "Package $pkg not found, skipping"
        fi
    done

    log_success "Dotfiles stowed"
}

install_fedora_extras() {
    log_info "Installing Fedora-specific packages..."

    # Install Ghostty (if available in COPR or manually)
    if ! command -v ghostty &>/dev/null; then
        log_warn "Ghostty not available via dnf. Install manually from: https://ghostty.org"
    fi

    # Install fonts
    sudo dnf install -y \
        fira-code-fonts \
        jetbrains-mono-fonts \
        2>/dev/null || log_warn "Some fonts may not be available"

    log_success "Fedora extras installed"
}

setup_shell() {
    # Ensure zsh is the default shell
    if [[ "$SHELL" != *"zsh"* ]]; then
        if command -v zsh &>/dev/null; then
            log_info "To set zsh as default shell, run: chsh -s \$(which zsh)"
        else
            log_warn "zsh not found"
        fi
    else
        log_success "zsh is already the default shell"
    fi
}

print_summary() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Bootstrap complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal (or run: exec zsh)"
    echo "  2. Run 'rbenv install <version>' for Ruby"
    echo "  3. Run 'pipx ensurepath' for Python tools"
    echo ""
    if [[ "$OS" == "fedora" ]]; then
        echo "Fedora-specific:"
        echo "  - Install Ghostty: https://ghostty.org"
        echo "  - Install WezTerm: https://wezfurlong.org/wezterm/install/linux.html"
        echo ""
    fi
}

main() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  Dotfiles Bootstrap Script${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""

    OS=$(detect_os)
    log_info "Detected OS: $OS"

    case "$OS" in
        macos)
            install_macos_deps
            install_homebrew
            install_packages
            install_stow
            ;;
        fedora)
            install_fedora_deps
            install_homebrew
            install_packages
            install_fedora_extras
            ;;
        *)
            log_error "Unsupported OS: $OS"
            log_error "This script supports macOS and Fedora Linux"
            exit 1
            ;;
    esac

    stow_dotfiles
    setup_shell
    print_summary
}

main "$@"
