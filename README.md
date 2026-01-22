# Dotfiles Management with GNU Stow

This repository uses **GNU Stow** for managing dotfiles. Stow is a symlink farm manager that makes it easy to manage your configuration files by creating symlinks from a central repository to your home directory.

## 📦 What's Inside

This repository contains configuration files for:

- **nvim** - Neovim configuration with Lazy.nvim plugin manager
- **tmux** - Terminal multiplexer configuration
- **wezterm** - WezTerm terminal emulator configuration
- **zsh** - Zsh shell configuration
- **Brewfile** - Homebrew package definitions (macOS/Linux)

## 🚀 Quick Start

<details>
<summary><strong>Installing on a New Machine</strong></summary>

### Prerequisites

First, install GNU Stow:

```shell
# macOS (with Homebrew)
brew install stow

# Ubuntu/Debian
sudo apt install stow

# Fedora/RHEL
sudo dnf install stow

# Arch Linux
sudo pacman -S stow
```

### Installation Steps

1. **Clone this repository to your home directory:**
   ```shell
   cd ~
   git clone https://github.com/SaiKhal/DotFiles.git
   cd DotFiles
   ```

2. **Stow the packages you want:**
   ```shell
   # Stow individual packages
   stow nvim
   stow tmux
   stow wezterm
   stow zsh
   
   # Or stow everything at once
   stow */
   ```

3. **Verify the symlinks were created:**
   ```shell
   ls -la ~/.config/nvim    # Should be a symlink
   ls -la ~/.zshrc          # Should be a symlink
   ```

4. **(Optional) Install Homebrew packages:**
   ```shell
   # macOS or Linux with Homebrew
   brew bundle --file=~/DotFiles/Brewfile
   ```

</details>

<details>
<summary><strong>⚠️ Important: Handling Existing Files</strong></summary>

If you have existing configuration files, Stow will **refuse to create symlinks** and show an error. This is a safety feature.

### Solution: Backup or Remove Existing Files

```shell
# Option 1: Backup existing configs
mkdir -p ~/.dotfiles-backup
mv ~/.config/nvim ~/.dotfiles-backup/
mv ~/.zshrc ~/.dotfiles-backup/
mv ~/.tmux.conf ~/.dotfiles-backup/

# Then run stow again
cd ~/DotFiles
stow nvim zsh tmux

# Option 2: Remove existing configs (if you don't need them)
rm -rf ~/.config/nvim
rm ~/.zshrc

# Then run stow
cd ~/DotFiles
stow nvim zsh
```

### Checking for Conflicts Before Stowing

```shell
# Dry-run to see what would happen (no changes made)
stow -n -v nvim

# The -n flag simulates the operation
# The -v flag shows verbose output
```

</details>

## 📚 How GNU Stow Works

<details>
<summary><strong>Understanding the Magic</strong></summary>

Stow creates symlinks from your package directories to your home directory, maintaining the directory structure.

### Directory Structure

```
~/DotFiles/
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.lua       → symlinked to ~/.config/nvim/init.lua
├── zsh/
│   └── .zshrc                 → symlinked to ~/.zshrc
└── tmux/
    ├── .config/
    │   └── tmux/              → symlinked to ~/.config/tmux/
    └── .tmux.conf             → symlinked to ~/.tmux.conf
```

### The Stow Command

```shell
cd ~/DotFiles
stow <package-name>
```

When you run `stow nvim`, Stow:
1. Looks in the `nvim/` directory
2. Finds `.config/nvim/`
3. Creates a symlink from `~/.config/nvim/` → `~/DotFiles/nvim/.config/nvim/`

The key is that Stow assumes the parent directory of the package directories (`~/DotFiles`) is where you want the symlinks to point **from**, and your home directory (`~`) is where you want them to point **to**.

</details>

## 🛠️ Essential Stow Commands

<details>
<summary><strong>Common Operations</strong></summary>

### Stowing (Installing) Packages

```shell
# Stow a single package
stow nvim

# Stow multiple packages
stow nvim tmux zsh

# Stow all packages
stow */

# Stow with verbose output (see what's happening)
stow -v nvim

# Dry-run (simulate without making changes)
stow -n -v nvim
```

### Unstowing (Removing) Packages

```shell
# Remove symlinks for a package
stow -D nvim

# Remove multiple packages
stow -D nvim tmux zsh

# Remove all packages
stow -D */
```

### Restowing (Update) Packages

Useful when you've changed the structure of your dotfiles:

```shell
# Remove and re-create symlinks (updates everything)
stow -R nvim

# Restow multiple packages
stow -R nvim tmux zsh

# Restow all packages
stow -R */
```

### Adopting Existing Files

If you have existing configuration files you want to move into your dotfiles repo:

```shell
# Adopt existing files (moves them into the package and creates symlinks)
stow --adopt nvim

# WARNING: This moves files from ~ to ~/DotFiles/nvim/
# Review changes with git diff before committing!
```

</details>

## ⚙️ Managing Your Dotfiles

<details>
<summary><strong>Daily Workflow</strong></summary>

### Making Changes

Since your dotfiles are symlinked, you can edit them in place:

```shell
# Edit config files as normal
vim ~/.config/nvim/init.lua
vim ~/.zshrc

# Changes are automatically in the git repo
cd ~/DotFiles
git status
git diff

# Commit and push
git add .
git commit -m "Update nvim config"
git push
```

### Adding New Configuration Files

```shell
# Let's say you want to add a new Git config
cd ~/DotFiles

# Create a new package directory
mkdir -p git

# Move your gitconfig there
mv ~/.gitconfig git/

# Stow it
stow git

# Add to git
git add git/
git commit -m "Add git configuration"
git push
```

### Syncing Changes Across Machines

```shell
# On machine A: Make changes and push
cd ~/DotFiles
git add .
git commit -m "Update tmux config"
git push

# On machine B: Pull and restow
cd ~/DotFiles
git pull
stow -R tmux  # Restow to update symlinks if structure changed
```

</details>

## ⚠️ Things to Watch Out For

<details>
<summary><strong>Common Pitfalls and Solutions</strong></summary>

### 1. **Stow From the Wrong Directory**

❌ **Wrong:**
```shell
cd ~/DotFiles/nvim
stow nvim  # Error! Stow can't find the package
```

✅ **Correct:**
```shell
cd ~/DotFiles
stow nvim
```

### 2. **Existing Files Block Stowing**

Stow won't overwrite existing files. You'll see an error like:
```
WARNING! stowing nvim would cause conflicts:
  * existing target is neither a link nor a directory: .config/nvim
```

**Solution:** Backup or remove the existing file first (see "Handling Existing Files" section above).

### 3. **Wrong Directory Structure**

Your package directory structure must mirror where files should go.

❌ **Wrong:**
```
DotFiles/
└── nvim/
    └── init.lua              # Won't work - will try to create ~/init.lua
```

✅ **Correct:**
```
DotFiles/
└── nvim/
    └── .config/
        └── nvim/
            └── init.lua      # Creates ~/.config/nvim/init.lua
```

### 4. **Forgetting to Restow After Structural Changes**

If you add/remove directories in your package, you need to restow:

```shell
# After adding new directories or files
stow -R nvim
```

### 5. **Accidentally Adopting the Wrong Files**

The `--adopt` flag moves files from your home directory into the dotfiles repo. Be careful!

```shell
# Always check what would be adopted first
stow -n --adopt nvim

# Review what was moved before committing
git status
git diff
```

### 6. **Nested Stow Directories**

Don't create nested stow directories. Keep packages flat:

❌ **Wrong:**
```
DotFiles/
└── configs/
    └── nvim/
        └── .config/nvim/
```

✅ **Correct:**
```
DotFiles/
└── nvim/
    └── .config/nvim/
```

</details>

## 🔧 Troubleshooting

<details>
<summary><strong>Common Issues</strong></summary>

### Symlinks Not Being Created

```shell
# Check if you're in the right directory
pwd  # Should be ~/DotFiles

# Check package structure
ls -la nvim/  # Should show the directory structure

# Try with verbose output to see what's happening
stow -v nvim
```

### "Cannot Stow" Errors

```shell
# Common causes:
# 1. Existing files/directories in the way
ls -la ~/.config/nvim  # Check if it exists

# 2. Wrong directory structure
ls -la ~/DotFiles/nvim/  # Verify structure

# 3. Permission issues
ls -ld ~  # Check home directory permissions
```

### Broken Symlinks

```shell
# Find broken symlinks in your home directory
find ~ -maxdepth 3 -xtype l 2>/dev/null

# Remove broken symlinks
find ~ -maxdepth 3 -xtype l -delete 2>/dev/null

# Restow the package
cd ~/DotFiles
stow -R nvim
```

### Unstowing Doesn't Remove All Symlinks

```shell
# Force unstow (removes even if there are issues)
stow -D --force nvim

# Clean up manually if needed
rm ~/.config/nvim  # if it's a symlink
```

</details>

## 📖 Additional Resources

<details>
<summary><strong>Learn More</strong></summary>

### Official Documentation
- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [GNU Stow Info Page](https://www.gnu.org/software/stow/)

### Tutorials and Guides
- [Using GNU Stow to Manage Dotfiles](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
- [Stow Has Forever Changed The Way I Manage My Dotfiles](https://www.jakewiesler.com/blog/managing-dotfiles)
- [Brandon Invergo's Guide](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)

### Video Tutorials
- [Dreams of Autonomy - Stow Dotfiles](https://www.youtube.com/watch?v=y6XCebnB9gs)
- [DevInsideYou - GNU Stow Tutorial](https://www.youtube.com/watch?v=CxAT1u8G7is)

</details>

## 💡 Tips and Best Practices

<details>
<summary><strong>Pro Tips</strong></summary>

### 1. **Use a Makefile or Script**

Create a `Makefile` or installation script:

```makefile
# Makefile
.PHONY: install uninstall restow

install:
	stow nvim tmux wezterm zsh

uninstall:
	stow -D nvim tmux wezterm zsh

restow:
	stow -R nvim tmux wezterm zsh
```

Usage: `make install`, `make uninstall`, `make restow`

### 2. **Organize by Functionality**

Keep related configs together:
```
DotFiles/
├── shell/           # All shell-related configs
│   ├── .zshrc
│   └── .bashrc
├── editors/
│   ├── .vimrc
│   └── .config/nvim/
└── terminal/
    └── .config/wezterm/
```

### 3. **Use .stow-local-ignore**

Ignore files within packages from being stowed:

```shell
# Create .stow-local-ignore in your package directory
cd ~/DotFiles/nvim
cat > .stow-local-ignore << EOF
README.md
.git
.gitignore
*.swp
EOF
```

### 4. **Machine-Specific Configs**

Use git branches for different machines:

```shell
# Create a branch for your work machine
git checkout -b work-laptop
# Make machine-specific changes
git add .
git commit -m "Work laptop specific configs"

# Switch back to main for shared configs
git checkout main
```

### 5. **Ignore Packages You Don't Want**

Don't stow everything on every machine:

```shell
# On a server, you might not need wezterm
cd ~/DotFiles
stow nvim tmux zsh  # Skip wezterm
```

### 6. **Document Your Setup**

Keep notes about dependencies or special setup:

```markdown
## nvim
Requires:
- Node.js (for LSP servers)
- ripgrep (for telescope.nvim)
- fd (for telescope.nvim)

Install: `brew install node ripgrep fd`
```

</details>

## 🔐 Security Notes

- **Never commit private keys** or sensitive credentials
- Use environment variables or separate private config files for secrets
- Review commits before pushing to public repositories
- Consider using `git-crypt` or `blackbox` for encrypting sensitive files
- Add sensitive files to `.gitignore`

## ❓ Why GNU Stow?

<details>
<summary><strong>Advantages and Disadvantages</strong></summary>

### Advantages
✅ Simple and lightweight (no complex framework)  
✅ Uses symlinks - edit configs in place  
✅ Easy to see what's managed (just check for symlinks)  
✅ Selective installation (pick and choose packages)  
✅ Easy to add/remove configurations  
✅ Version control friendly  
✅ Works on any Unix-like system  
✅ No special uninstall needed (just `stow -D`)  

### Disadvantages
❌ Requires GNU Stow to be installed  
❌ Must maintain specific directory structure  
❌ Symlinks can be confusing for beginners  
❌ Need to handle conflicts manually  
❌ Can't easily track files outside home directory without sudo  

</details>

---

**Happy Stowing! 🎉**

For issues or questions about this dotfiles setup, please [open an issue](https://github.com/SaiKhal/DotFiles/issues).
