#!/bin/bash
#
# account_setup.sh
# Handles setup configuration for both personal and work accounts
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Source required files
source "${SCRIPT_DIR}/scripts/shared/zsh_setup.sh"
source "${SCRIPT_DIR}/scripts/shared/dotfiles_setup.sh"
source "${SCRIPT_DIR}/scripts/shared/node_setup.sh"
source "${SCRIPT_DIR}/scripts/shared/dock_setup.sh"
source "${SCRIPT_DIR}/scripts/shared/macos_preferences.sh"
source "${SCRIPT_DIR}/scripts/shared/folder_icons_setup.sh"

# Run the account setup with the specified type
run_account_setup() {
  local account_type="$1"

  # Set up ZSH environment (install Oh-My-ZSH)
  configure_zsh_environment

  # Set up dotfiles (creates symlinks to .zshrc, .gitconfig, etc.)
  setup_dotfiles

  # Install Node.js via n
  install_node_via_n

  # Install dependencies
  install_npm_packages

  # Configure macOS Dock based on account type
  if [[ "$account_type" == "personal" ]]; then
    configure_personal_dock
  elif [[ "$account_type" == "work" ]]; then
    configure_work_dock
  else
    print_error "Invalid account type: $account_type"
    exit 1
  fi

  # Apply macOS preferences
  apply_macos_preferences

  # Apply folder icons
  # apply_folder_icons
}
