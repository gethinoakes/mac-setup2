#!/bin/bash
#
# Mac Setup Script
# Main entry point for setting up a new Mac machine from scratch
#
# Usage: ./setup.sh [global|personal|work]
#
# This script orchestrates the setup process by:
# 1. Checking internet connectivity
# 2. Setting up the environment (Xcode CLI, Homebrew, Gum)
# 3. Selecting and executing the appropriate setup type
# 4. Managing sudo access throughout the process
#
# NOTE: Gum (https://github.com/charmbracelet/gum) is a hard requirement
# for this script. It will be automatically installed during the environment
# setup, but if it fails to install, the script will exit.
#
# NOTE: Some applications (especially Microsoft products) may require
# additional password prompts during installation despite sudo caching.
#

# Instead of using set -e, we'll handle errors manually to ensure the script
# doesn't exit prematurely
# set -e # Exit immediately if a command exits with a non-zero status

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SCRIPT_DIR

# Import print utilities first (for fallback functions)
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Import utils
source "${SCRIPT_DIR}/scripts/utils/utils.sh"

# Import sudo manager
source "${SCRIPT_DIR}/scripts/utils/sudo_utils.sh"

# Import module scripts
source "${SCRIPT_DIR}/scripts/environment_setup.sh"
source "${SCRIPT_DIR}/scripts/internet.sh"
source "${SCRIPT_DIR}/scripts/setup_types.sh"

# Set up cleanup trap
trap cleanup_sudo EXIT

# Main execution
main() {
  local setup_type="$1"

  # Check internet connection with retry
  check_internet_with_retry

  # Setup environment (checks and installs Xcode CLI, Homebrew and Gum)
  setup_environment

  # Welcome message
  print_header "Mac Setup
This script will help you set up your new Mac."

  # Initialize sudo if not already done by environment setup
  if [[ -z "$SUDO_INITIALIZED" ]]; then
    ask_for_sudo
    print_success "Sudo access granted and will be maintained throughout the script"
    print_warning "Note: Some applications may still request additional password prompts during installation"
  fi

  # Get setup type from argument or prompt
  setup_type=$(select_setup_type "$setup_type")

  # Run the setup process with the selected type
  run_setup "$setup_type"
}

# Execute main function
main "$@"
