# Dotfiles Management with Bare Git Repository

This repository uses the "bare git repository" method for managing dotfiles. This approach allows you to version control your configuration files directly in your home directory without symlinks or special tools.

## How It Works

Instead of storing dotfiles in a separate folder and symlinking them, this method:
- Creates a bare git repository in `~/.cfg/`
- Uses a custom `config` alias that points git to this bare repository
- Treats your entire home directory as the working tree
- Only tracks files you explicitly add (ignores everything else)

## Initial Setup (First Time)

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

## Installing Dotfiles on a New Machine

To set up your dotfiles on a fresh system:

```shell
# 1. Clone the repository as a bare repo
git clone --bare https://github.com/yourusername/dotfiles.git $HOME/.cfg

# 2. Create the config alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# 3. Checkout the files to your home directory
config checkout
```

If the checkout fails due to existing files, back them up:
```shell
# Create backup directory
mkdir -p .config-backup

# Move conflicting files to backup
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}

# Try checkout again
config checkout

# 4. Hide untracked files
config config --local status.showUntrackedFiles no

# 5. Add the alias to your shell config permanently
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc

# 6. Reload your shell
source ~/.zshrc
```

## One-Line Installation Script

For convenience, you can create a script to automate the installation:

```shell
curl -Lks https://raw.githubusercontent.com/yourusername/dotfiles/main/install.sh | /bin/bash
```

Example `install.sh` script:
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

## Daily Usage

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

## Useful Commands

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

## Tips and Best Practices

### File Organization
- Keep machine-specific configs in separate branches
- Use conditional logic in config files for different environments
- Document any special setup requirements

### What to Track
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

### Ignoring Files
The repository is configured to hide untracked files, but you can also create a `.gitignore` file in your home directory for explicit ignoring:

```shell
# Add to ~/.gitignore
.DS_Store
*.log
node_modules/
.cache/
```

### Branch Strategy
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

## Troubleshooting

### Config alias not working
Make sure the alias is properly set and your shell config is sourced:
```shell
# Check if alias exists
alias config

# If not, add it again
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> ~/.zshrc
source ~/.zshrc
```

### Files showing as untracked
This is normal! The repository is configured to hide untracked files:
```shell
# Verify the setting
config config --local status.showUntrackedFiles

# Should return: no
```

### Accidentally committed too many files
```shell
# Remove files from tracking (but keep local copies)
config rm --cached unwanted-file

# Commit the removal
config commit -m "Remove unwanted file from tracking"
```

### Reset to clean state
```shell
# Hard reset to last commit (DESTRUCTIVE!)
config reset --hard HEAD

# Or reset specific file
config checkout HEAD -- filename
```

## Migration from Other Methods

### From symlink-based dotfiles
1. Remove existing symlinks
2. Copy actual config files to home directory
3. Follow the "Initial Setup" instructions above

### From existing git repository
If you already have dotfiles in a regular git repository:
1. Clone this repository method alongside your existing one
2. Copy files from old repo to home directory
3. Use `config add` to track them
4. Remove old repository when satisfied

## Security Notes

- **Never commit private keys** or sensitive credentials
- Use environment variables or separate private config files for secrets
- Consider encrypting sensitive dotfiles with tools like `git-crypt`
- Review commits before pushing to public repositories

## Why This Method?

**Advantages:**
- No symlinks to manage or break
- Native git functionality - no wrapper tools
- Easy to replicate on new machines
- Can use branches for different environments
- Files stay in their expected locations

**Disadvantages:**
- Slightly more complex initial setup
- Need to remember to use `config` instead of `git`
- Can be confusing if you're not familiar with bare repositories

## Resources

- [Original Hacker News discussion](https://news.ycombinator.com/item?id=11070797)
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
- [Git bare repository documentation](https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---bare)
