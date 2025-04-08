#!/bin/bash
#
# dependency-utils.sh
# Consolidated dependency management utilities
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Fix Homebrew permissions for multi-user support
setup_homebrew_permissions() {
  print_subheader "Setting Up Homebrew Permissions"

  print_info "Setting up Homebrew for multi-user support..."

  # Get Homebrew prefix
  local brew_prefix
  brew_prefix=$(brew --prefix)

  # Set proper permissions for Homebrew directories
  sudo_run chown -R :admin "$brew_prefix"
  sudo_run chmod -R g+w "$brew_prefix"

  print_success "Homebrew permissions set for multi-user support."
}

# Import Brewfile from the new config structure
install_brew_packages() {
  print_subheader "Installing Homebrew Packages"
  local brew_status=0

  # Check for Brewfile
  if [[ -f "${SCRIPT_DIR}/config/dependencies/Brewfile" ]]; then
    print_info "Installing packages from Brewfile (this may take a while)..."
    print_warning "Some applications like Microsoft products may require additional password prompts."
    
    # Run brew bundle with the Brewfile (which now excludes mas entries)
    if ! brew bundle --file="${SCRIPT_DIR}/config/dependencies/Brewfile" --verbose; then
      print_warning "Some Homebrew packages failed to install. Check the output above for details."
      print_info "Continuing with the rest of the setup despite Brewfile installation issues."
      brew_status=1
    else
      print_success "Homebrew packages installed successfully."
    fi
  else
    print_error "Brewfile not found at ${SCRIPT_DIR}/config/dependencies/Brewfile"
    return 1
  fi

  return $brew_status
}

# Prompt for and handle Mac App Store application installation
install_mas_packages() {
  print_subheader "Mac App Store Applications"
  local mas_status=0
  local mas_brewfile="${SCRIPT_DIR}/config/dependencies/Brewfile_mas"
  
  # List the Mac App Store apps to be installed
  local app_names=()
  echo
  while read -r line; do
    if [[ "$line" =~ ^mas\ +\"([^\"]+)\" ]]; then
      local app_name="${BASH_REMATCH[1]}"
      app_names+=("$app_name")
      print_info "• $app_name"
    fi
  done < "$mas_brewfile"
  echo
  
  # Ask if user wants to install Mac App Store apps with Gum confirm
  if gum confirm --affirmative "Install" --negative "Skip" "Would you like to install these Mac App Store applications?"; then
    # Show spinner while installing
    if ! run_with_spinner "Installing Mac App Store applications..." brew bundle --file="$mas_brewfile" --verbose; then
      print_warning "Some Mac App Store applications failed to install."
      print_info "This could be due to apps already being installed or other issues with the Mac App Store."
      mas_status=1
    else
      print_success "Mac App Store applications installed successfully!"
    fi
  else
    print_text "Skipping Mac App Store application installation."
  fi
  
  return $mas_status
}

# Set up Homebrew's autoupdate functionality
setup_brew_autoupdate() {
  # Weekly interval (604800 seconds = 7 days)
  local INTERVAL=604800

  print_subheader "Setting up Homebrew Autoupdate"

  # Check if tap is already installed
  if ! brew tap | grep -q "domt4/autoupdate"; then
    run_with_spinner "Adding domt4/autoupdate tap..." brew tap domt4/autoupdate
    # Check if the tap was added successfully
    if ! brew tap | grep -q "domt4/autoupdate"; then
      print_error "Failed to add domt4/autoupdate tap."
      print_warning "Skipping Homebrew autoupdate setup, but continuing with the rest of the installation."
      return 1
    fi
  fi

  # Check if pinentry-mac is installed
  if ! brew list --formula | grep -q "pinentry-mac"; then
    run_with_spinner "Installing pinentry-mac..." brew install pinentry-mac
    # Check if pinentry-mac was installed successfully
    if ! brew list --formula | grep -q "pinentry-mac"; then
      print_error "Failed to install pinentry-mac."
      print_warning "Skipping Homebrew autoupdate setup, but continuing with the rest of the installation."
      return 1
    fi
  fi

  # Stop existing autoupdate if it's running
  if brew autoupdate status 2>/dev/null | grep -q "running"; then
    run_with_spinner "Stopping existing autoupdate..." brew autoupdate stop
  fi

  # Start autoupdate with weekly updates, cleanup, upgrade and sudo options
  run_with_spinner "Starting Homebrew autoupdate..." brew autoupdate start $INTERVAL --cleanup --upgrade --sudo

  # Verify it's running
  if brew autoupdate status | grep -q "running"; then
    print_success "Homebrew autoupdate has been successfully configured!"
    print_info "Your Homebrew installation will be automatically updated every 7 days."
  else
    print_error "Failed to set up Homebrew autoupdate. Please check the error output."
    print_warning "Continuing with the rest of the installation despite the autoupdate issue."
    return 1
  fi
}
