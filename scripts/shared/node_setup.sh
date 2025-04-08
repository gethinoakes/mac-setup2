#!/bin/bash
#
# node_setup.sh
# Handles installation and configuration of Node.js via n and npm packages
# for the current user account
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Install Node.js via n and configure npm for the current user
install_node_via_n() {
  print_subheader "Installing Node.js via n"

  # Check if n is installed via Homebrew
  if ! command -v n &>/dev/null; then
    if ! brew list n &>/dev/null; then
      brew install n
    fi
  fi

  # Create user-specific n directory
  mkdir -p "$HOME/.n"

  # Install Node.js LTS for current user
  export N_PREFIX="$HOME/.n"
  export PATH="$N_PREFIX/bin:$PATH"
  n lts

  # Verify node and npm are available
  if command -v node >/dev/null && command -v npm >/dev/null; then
    print_success "n and Node.js LTS installed and configured for current user."
    print_info "Node version: $(node --version)"
    print_info "NPM version: $(npm --version)"

    # Add n and Node.js to user's .zshrc if not already present and if .zshrc is not a symlink
    if [[ ! -L "$HOME/.zshrc" ]]; then
      if ! grep -q "N_PREFIX=" "$HOME/.zshrc"; then
        {
          echo -e "\n# n and Node.js configuration"
          echo "export N_PREFIX=\"$HOME/.n\""
          echo "export PATH=\"\$N_PREFIX/bin:\$PATH\""
        } >>"$HOME/.zshrc"
      fi
    else
      # .zshrc is a symlink (managed by dotfiles)
      print_info "Not modifying .zshrc as it is a symlink. Node.js configuration should be managed in your dotfiles."
    fi
  else
    print_error "Failed to install or configure Node/NPM properly."
    return 1
  fi
}

# Install npm packages from configuration file
install_npm_packages() {
  print_subheader "Installing NPM Packages"

  # Check for npm_packages in the dependencies configuration directory
  if [[ -f "${SCRIPT_DIR}/config/dependencies/npm_packages" ]]; then
    run_with_spinner "Installing NPM packages..." \
      xargs npm install -g <"${SCRIPT_DIR}/config/dependencies/npm_packages"

    print_success "NPM packages installed successfully."
  else
    print_error "npm_packages not found at ${SCRIPT_DIR}/config/dependencies/npm_packages"
    return 1
  fi
}
