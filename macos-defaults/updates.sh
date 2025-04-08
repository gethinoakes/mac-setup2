#!/bin/bash
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"
# ---- App Store & Software Updates ---- #
# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Enable automatic checking for updates
sudo_run defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Enable automatic download of updates
sudo_run defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true

# Enable automatic app updates
sudo_run defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

# Disable restarting after updates
sudo_run defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool false

# Enable configuration/critical updates
sudo_run defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo_run defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

print_success "Done with Update Settings"
