#!/bin/bash
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"
# ---- Terminal ---- #

print_info "Setting Terminal theme to Ayu Dark"
# Set the path to the Ayu Dark theme file relative to the script's location
terminalTheme="${SCRIPT_DIR}/config/terminal/ayuDark.terminal"

# Import Ayu Dark theme to Terminal
open "$terminalTheme"

# Set Ayu Dark as default Terminal theme
defaults write com.apple.Terminal "Default Window Settings" -string "ayu Dark"
defaults write com.apple.Terminal "Startup Window Settings" -string "ayu Dark"

print_success "Terminal theme has been set to Ayu Dark."

print_success "Done with Terminal Settings"
