#!/bin/bash
#
# environment_setup.sh
# Handles the installation of required dependencies
#

# Check and install Xcode CLI if needed
install_xcode_cli() {
  basic_print_info "Checking if Xcode Command Line Tools are installed..."

  if command_exists xcode-select && xcode-select -p &>/dev/null; then
    basic_print_success "Xcode Command Line Tools are already installed."
    return 0
  else
    basic_print_warning "Xcode Command Line Tools are not installed."

    basic_print_info "Installing Xcode Command Line Tools..."

    # Prompt user to install the Xcode Command Line Tools
    xcode-select --install &>/dev/null

    # Wait for the installation to complete
    basic_print_info "A dialog box should appear. Please click 'Install' and follow the instructions."
    basic_print_info "Waiting for installation to complete..."

    # Wait for the installation to complete
    until command_exists xcode-select && xcode-select -p &>/dev/null; do
      basic_print_info "Still waiting for Xcode Command Line Tools installation to complete..."
      sleep 10
    done

    # Verify installation
    if command_exists xcode-select && xcode-select -p &>/dev/null; then
      basic_print_info "Accepting Xcode license agreement..."
      sudo_exec xcodebuild -license accept &>/dev/null
      basic_print_success "Xcode Command Line Tools installed successfully"
      return 0
    else
      basic_print_error "Xcode Command Line Tools installation failed. Please try again manually."
      exit 1
    fi
  fi
}

# Check for Homebrew and install if not present
install_homebrew() {
  if ! command -v brew &>/dev/null; then
    basic_print_info "Homebrew is not installed. Installing..."

    # Ask for sudo access upfront
    ask_for_sudo

    # Install Homebrew
    basic_print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for the current session
    basic_print_info "Adding Homebrew to PATH..."
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"

    basic_print_success "Homebrew installed successfully!"
    return 0
  else
    basic_print_success "Homebrew is already installed."
    return 0
  fi
}

# Check for Gum and install if not present
install_gum() {
  if ! command -v gum &>/dev/null; then
    basic_print_info "Gum is not installed. Installing..."

    if ! brew install gum; then
      basic_print_error "Failed to install Gum. Gum is required for this script to run properly."
      basic_print_error "Please try to install Gum manually: brew install gum"
      exit 1
    fi

    # Add Homebrew bin to PATH to ensure gum is accessible in current session
    if [[ -d "/opt/homebrew/bin" ]]; then
      export PATH="/opt/homebrew/bin:$PATH"
    elif [[ -d "/usr/local/bin" ]]; then
      export PATH="/usr/local/bin:$PATH"
    fi

    if ! command -v gum &>/dev/null; then
      basic_print_error "Gum installation completed but command not found."
      basic_print_error "Please ensure Gum is properly installed and accessible in your PATH."
      exit 1
    fi

    basic_print_success "Gum installed successfully!"
  else
    basic_print_success "Gum is already installed."
  fi

  # Export GUM_SPIN_SPINNER to use dot spinner by default
  export GUM_SPIN_SPINNER="dot"
  return 0
}

# Setup environment for fresh install
setup_environment() {
  # Use basic_print_header since Gum is not installed yet
  basic_print_header "Setting Up Environment"

  # Install Xcode CLI first (required for Homebrew)
  install_xcode_cli

  # Install Homebrew if needed
  install_homebrew

  # Install Gum if needed
  install_gum

  # At this point, Gum is definitely installed (or script has exited)
  # Now we can use the Gum-based print functions

  # Verify gum is available before using Gum-based function
  if command -v gum &>/dev/null; then
    # Show completion with Gum styling
    print_header "Environment Setup Complete"
  else
    # Fallback to basic styling if gum still not available
    basic_print_header "Environment Setup Complete"
  fi
}
