#!/bin/bash
#
# internet.sh
# Handles internet connection checking
#

source "${SCRIPT_DIR}/scripts/utils/utils.sh"
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Check internet connection and prompt for retry if unavailable
check_internet_with_retry() {
  while ! check_internet; do
    if command_exists gum; then
      if ! gum confirm "Internet connection is not available. Do you want to try again?"; then
        print_warning "Setup cancelled. Please run the script again when you have internet connection."
        exit 0
      fi
      run_with_spinner "Checking internet connection again..." sleep 2
    else
      # Fallback to basic prompt if gum is not installed
      basic_print_warning "Internet connection is not available."
      read -r -p "Do you want to try again? (y/n): " retry
      if [[ ! "$retry" =~ ^[Yy]$ ]]; then
        basic_print_warning "Setup cancelled. Please run the script again when you have internet connection."
        exit 0
      fi
      basic_print_info "Checking internet connection again..."
      sleep 2
    fi
  done
}

# Function to check if the internet is accessible
check_internet() {
  local endpoints=("google.com" "apple.com" "cloudflare.com")

  if command_exists gum; then
    print_info "Checking internet connection..."
  else
    basic_print_info "Checking internet connection..."
  fi

  for endpoint in "${endpoints[@]}"; do
    if ping -c 1 "$endpoint" &>/dev/null; then
      if command_exists gum; then
        print_success "Internet connection is available"
      else
        basic_print_success "Internet connection is available"
      fi
      return 0
    fi
  done

  if command_exists gum; then
    print_error "Internet connection is not available."
  else
    basic_print_error "Internet connection is not available."
  fi
  return 1
}
