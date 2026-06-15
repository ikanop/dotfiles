# dotfiles

My personal macOS dotfiles.

## First time setup

### 1. Clone the repo
```bash
git clone https://github.com/ikanop/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. Install packages
```bash
brew bundle --file=install/Brewfile
brew bundle --file=install/Caskfile
```

### 4. Symlink dotfiles
Install stow then link everything into place:
```bash
brew install stow
stow -t "$HOME" runcom
stow -t "$HOME/.config" config
```

This makes `~/.zshrc` point to `~/dotfiles/runcom/.zshrc`
and `~/.config/nvim` etc point to `~/dotfiles/config/nvim` etc.

### 5. macOS settings
```bash
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.screencapture location ~/Pictures
defaults write com.apple.dock autohide-delay -float 0
killall SystemUIServer Dock Finder
```

## Editing
All real files live in `~/dotfiles`. Edit them there and changes are live
immediately since everything is symlinked. Commit and push as normal.
