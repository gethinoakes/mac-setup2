#!/bin/bash

# sudo_utils.sh
# Utilities for handling sudo operations securely
# Uses system sudo credential caching instead of storing password

# Source print utilities
source "$(dirname "${BASH_SOURCE[0]}")/print_utils.sh"

# Function to ask for sudo access and keep it alive
ask_for_sudo() {
  # Check if sudo is already initialized
  if [[ -n "$SUDO_INITIALIZED" ]]; then
    return 0
  fi

  # Check if gum is available
  if command -v gum &>/dev/null; then
    print_subheader "Administrator Password Required"
    print_text "This script requires administrator privileges to perform some tasks."
    print_text "Your password will be cached temporarily during script execution only."
    print_text "It will never be stored to disk or transmitted elsewhere."
  else
    # Fallback to basic prints if gum is not available
    basic_print_header "Administrator Password Required"
    echo "This script requires administrator privileges to perform some tasks."
    echo "Your password will be cached temporarily during script execution only."
    echo "It will never be stored to disk or transmitted elsewhere."
  fi

  echo

  # Ask for the administrator password upfront
  sudo -v &>/dev/null

  # Function to keep sudo session alive
  keep_sudo_alive() {
    while true; do
      sudo -n true
      sleep 60
      kill -0 "$$" || exit
    done 2>/dev/null &
    SUDO_PID=$!
  }

  # Start the keep-alive process
  keep_sudo_alive

  # Set SUDO_INITIALIZED flag
  SUDO_INITIALIZED=true
  export SUDO_INITIALIZED

  # Check if gum is available
  if command -v gum &>/dev/null; then
    print_success "Password verified"
  else
    basic_print_success "Password verified"
  fi
}

# Execute a command with sudo privileges
sudo_run() {
  # Option to show a spinner for long-running sudo operations
  if [[ "$1" == "--spin" ]]; then
    shift
    local message="$1"
    shift

    # Check if gum is available
    if command -v gum &>/dev/null; then
      run_sudo_with_spinner "$message" "$@"
    else
      # Fallback: show message and run sudo command without spinner
      basic_print_info "$message"
      sudo -n "$@"
    fi
  else
    sudo -n "$@"
  fi
}

# Function to cleanup at script exit
cleanup_sudo() {
  if [[ -n "$SUDO_PID" ]]; then
    kill "$SUDO_PID" 2>/dev/null
  fi
}
