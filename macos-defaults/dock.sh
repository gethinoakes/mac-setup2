#!/bin/bash
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"
# ---- Dock ---- #
# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 50

# Dock magnification
defaults write com.apple.dock magnification -bool false

# Icon size of magnified Dock items
# defaults write com.apple.dock largesize -int 90

# Minimization effect: 'genie', 'scale', 'suck'
defaults write com.apple.dock mineffect -string 'scale'

# Prefer tabs when opening documents: 'always', 'fullscreen', 'manual'
defaults write NSGlobalDomain AppleWindowTabbingMode -string 'always'

# Double-click a window's title bar to:
# None
# Mimimize
# Maximize (zoom)
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Mimimize"

# Don't minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

# Animate opening applications
defaults write com.apple.dock launchanim -bool true

# Automatically hide and show the Dock & remove show delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock autohide-delay -float 0
# defaults delete com.apple.Dock autohide-delay

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Highlight hover effect for the grid view of a stack
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false
killall Dock

print_success "Done with Dock Settings"
