function cask-install() {
    brew list $1 || brew cask install $1
}

function brew-install() {
    brew list $1 || brew install $1
}

# ------ Development -------

echo "Installing Development Software..."

echo "  - Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor

echo "  - Installing VS Code"
cask-install visual-studio-code

echo "  - Installing Sublime Text"
cask-install sublime-text

echo "  - Installing iTerm2"
cask-install iterm2

echo "  - Installing zsh + powerlevel10k theme"
brew-install zsh
brew-install romkatv/powerlevel10k/powerlevel10k

echo "  - Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "  - Installing Node.js + NPM"
brew-install node

echo "  - Installing Yarn"
brew-install yarn

echo "  - Installing Git"
brew-install git

# ------ Personal ------

echo "  - Installing Fantastical"
cask-install fantastical

echo "  - Installing Chrome"
cask-install google-chrome

echo "  - Installing Alfred"
cask-install alfred

echo "  - Installing Bear"
cask-install bear

echo "  - Installing 1Password"
cask-install 1password

echo "  - Installing Rectangle"
cask-install rectangle

echo "  - Installing Hazeover"
cask-install hazeover

echo "  - Installing Figma"
cask-install figma

# ----- System Preferences -----

echo "Modifying System Preferences Defaults..."

# Finder
defaults write com.apple.finder AppleShowAllFiles -string YES
killall Finder

# Prevent .DS_Store files in Network folders.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean true

# Screen Capture
defaults write com.apple.screencapture type PNG
defaults write com.apple.screencapture location ~/Desktop
defaults write com.apple.screencapture "include-date" 1
defaults write com.apple.screencapture name "screenshot"
killall SystemUIServer

# Dock
defaults write com.apple.Dock autohide-delay -float 0
killall Dock

# Other
chflags nohidden ~/Library/ # Show the Library folder

# ----- Manual Reminders -----

echo "Other software you should install:"
echo "  - Spark"
echo "  - Todoist"
echo "  - Irvue"
echo "  - Take a Break"
echo "  - Record It"
