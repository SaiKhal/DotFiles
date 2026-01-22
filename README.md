# Dotfiles Management with Bare Git Repository

This repository uses the "bare git repository" method for managing dotfiles. This approach allows you to version control your configuration files directly in your home directory without symlinks or special tools.

## 📖 Table of Contents

- [How It Works](#how-it-works)
- [Quick Start](#quick-start)
- [Setup Instructions](#setup-instructions)
- [Daily Usage](#daily-usage)
- [Tips and Best Practices](#tips-and-best-practices)
- [Troubleshooting](#troubleshooting)
- [Migration Guide](#migration-guide)
- [Resources](#resources)

---

## How It Works

Instead of storing dotfiles in a separate folder and symlinking them, this method:
- Creates a bare git repository in `~/.cfg/`
- Uses a custom `config` alias that points git to this bare repository
- Treats your entire home directory as the working tree
- Only tracks files you explicitly add (ignores everything else)

---

## Quick Start

<details open>
<summary><b>🚀 Installing on a New Machine</b></summary>

<br>

To set up your dotfiles on a fresh system:

```shell
# 1. Clone the repository as a bare repo
git clone --bare https://github.com/yourusername/dotfiles.git $HOME/.cfg

# 2. Create the config alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# 3. Checkout the files to your home directory
config checkout

# 4. Hide untracked files
config config --local status.showUntrackedFiles no

# 5. Add the alias to your shell config permanently
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc

# 6. Reload your shell
source ~/.zshrc
```

**If checkout fails due to existing files:**

```shell
# Create backup directory
mkdir -p .config-backup

# Move conflicting files to backup
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}

# Try checkout again
config checkout
```

</details>

<details>
<summary><b>📦 One-Line Installation</b></summary>

<br>

For convenience, you can create a script to automate the installation:

```shell
curl -Lks https://raw.githubusercontent.com/yourusername/dotfiles/main/install.sh | /bin/bash
```

**Example `install.sh` script:**

```shell
#!/bin/bash
git clone --bare https://github.com/yourusername/dotfiles.git $HOME/.cfg

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

mkdir -p .config-backup
config checkout

if [ $? = 0 ]; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files."
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi

config checkout
config config --local status.showUntrackedFiles no
echo "Dotfiles installed successfully!"
```

</details>

---

## Setup Instructions

<details>
<summary><b>🆕 Initial Setup (First Time)</b></summary>

<br>

If you're starting from scratch and want to begin tracking your dotfiles:

```shell
# 1. Create a bare git repository
git init --bare $HOME/.cfg

# 2. Create the config alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# 3. Hide untracked files (important!)
config config --local status.showUntrackedFiles no

# 4. Add the alias to your shell config (zsh)
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc

# 5. Reload your shell or source the config
source ~/.zshrc

# 6. Add your dotfiles to version control
config add .vimrc
config add .bashrc
config add .zshrc
config commit -m "Initial commit: Add basic dotfiles"

# 7. Add remote repository (replace with your repo URL)
config remote add origin https://github.com/yourusername/dotfiles.git
config push -u origin main
```

</details>

---

## Daily Usage

<details open>
<summary><b>💻 Common Commands</b></summary>

<br>

Once set up, use the `config` command instead of `git` for managing dotfiles:

```shell
# Check status
config status

# Add new files
config add .gitconfig
config add .tmux.conf

# Commit changes
config commit -m "Add tmux configuration"

# Push to remote
config push

# Pull updates
config pull

# View history
config log --oneline

# Check differences
config diff
```

</details>

<details>
<summary><b>🛠️ Useful Commands</b></summary>

<br>

```shell
# See what files are tracked
config ls-tree -r HEAD --name-only

# Add a file and commit in one go
config add .vimrc && config commit -m "Update vim config"

# Create and switch to a new branch (useful for different machines)
config checkout -b laptop

# List all branches
config branch -a

# Compare branches
config diff main..laptop
```

</details>

---

## Tips and Best Practices

<details>
<summary><b>📁 File Organization</b></summary>

<br>

- Keep machine-specific configs in separate branches
- Use conditional logic in config files for different environments
- Document any special setup requirements

</details>

<details>
<summary><b>✅ What to Track</b></summary>

<br>

**Good candidates:**
- Shell configs (`.zshrc`, `.zsh_profile`, `.profile`)
- Editor configs (`.vimrc`, `.emacs.d/`)
- Git config (`.gitconfig`)
- SSH config (`.ssh/config` - **not** private keys!)
- Application configs (`.tmux.conf`, `.inputrc`)

**Avoid tracking:**
- Private keys or sensitive data
- Cache directories
- Large binary files
- OS-specific files that shouldn't be shared

</details>

<details>
<summary><b>🚫 Ignoring Files</b></summary>

<br>

The repository is configured to hide untracked files, but you can also create a `.gitignore` file in your home directory for explicit ignoring:

```shell
# Add to ~/.gitignore
.DS_Store
*.log
node_modules/
.cache/
```

</details>

<details>
<summary><b>🌿 Branch Strategy</b></summary>

<br>

Use different branches for different machines or environments:

```shell
# Create branches for different setups
config checkout -b work-laptop
config checkout -b personal-desktop
config checkout -b server

# Merge common changes back to main
config checkout main
config merge work-laptop
```

</details>

<details>
<summary><b>🔒 Security Notes</b></summary>

<br>

- **Never commit private keys** or sensitive credentials
- Use environment variables or separate private config files for secrets
- Consider encrypting sensitive dotfiles with tools like `git-crypt`
- Review commits before pushing to public repositories

</details>

---

## Troubleshooting

<details>
<summary><b>⚙️ Config alias not working</b></summary>

<br>

Make sure the alias is properly set and your shell config is sourced:

```shell
# Check if alias exists
alias config

# If not, add it again
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> ~/.zshrc
source ~/.zshrc
```

</details>

<details>
<summary><b>📝 Files showing as untracked</b></summary>

<br>

This is normal! The repository is configured to hide untracked files:

```shell
# Verify the setting
config config --local status.showUntrackedFiles

# Should return: no
```

</details>

<details>
<summary><b>❌ Accidentally committed too many files</b></summary>

<br>

```shell
# Remove files from tracking (but keep local copies)
config rm --cached unwanted-file

# Commit the removal
config commit -m "Remove unwanted file from tracking"
```

</details>

<details>
<summary><b>🔄 Reset to clean state</b></summary>

<br>

```shell
# Hard reset to last commit (DESTRUCTIVE!)
config reset --hard HEAD

# Or reset specific file
config checkout HEAD -- filename
```

</details>

---

## Migration Guide

<details>
<summary><b>🔗 From symlink-based dotfiles</b></summary>

<br>

1. Remove existing symlinks
2. Copy actual config files to home directory
3. Follow the "Initial Setup" instructions above

</details>

<details>
<summary><b>📦 From existing git repository</b></summary>

<br>

If you already have dotfiles in a regular git repository:

1. Clone this repository method alongside your existing one
2. Copy files from old repo to home directory
3. Use `config add` to track them
4. Remove old repository when satisfied

</details>

---

## Why This Method?

<details>
<summary><b>✨ Advantages</b></summary>

<br>

- No symlinks to manage or break
- Native git functionality - no wrapper tools
- Easy to replicate on new machines
- Can use branches for different environments
- Files stay in their expected locations

</details>

<details>
<summary><b>⚠️ Disadvantages</b></summary>

<br>

- Slightly more complex initial setup
- Need to remember to use `config` instead of `git`
- Can be confusing if you're not familiar with bare repositories

</details>

---

## Resources

- [Original Hacker News discussion](https://news.ycombinator.com/item?id=11070797)
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
- [Git bare repository documentation](https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---bare)

---

<p align="center">
  <i>Made with ❤️ for better dotfile management</i>
</p>
