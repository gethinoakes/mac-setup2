#!/bin/bash
#
# global_setup.sh
# Handles global setup configuration: homebrew multi-user permissions, brewfile installation, brew autoupdate, and custom app icons
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Source modular script files
source "${SCRIPT_DIR}/scripts/utils/dependency-utils.sh"
source "${SCRIPT_DIR}/scripts/shared/app_icons_setup.sh"

# Run the global setup
run_global_setup() {
  print_header "Running Global Setup"
  local setup_status=0

  # Set up Homebrew permissions for multi-user support
  setup_homebrew_permissions
  if [ $? -ne 0 ]; then
    print_warning "Homebrew permissions setup had some issues."
    setup_status=1
  fi

  # Install packages from Brewfile
  install_brew_packages
  if [ $? -ne 0 ]; then
    print_warning "Some Homebrew packages may not have installed correctly."
    setup_status=1
  fi

  # Handle Mac App Store applications separately with user prompt
  install_mas_packages
  if [ $? -ne 0 ]; then
    print_warning "Some Mac App Store applications may not have installed correctly."
    setup_status=1
  fi

  # Set up Homebrew autoupdate
  setup_brew_autoupdate
  if [ $? -ne 0 ]; then
    print_warning "Homebrew autoupdate setup had some issues."
    setup_status=1
  fi

  # Apply custom app icons
  apply_app_icons
  if [ $? -ne 0 ]; then
    print_warning "App icons setup had some issues."
    setup_status=1
  fi

  return $setup_status
}
