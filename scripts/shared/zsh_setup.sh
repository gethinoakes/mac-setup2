#!/bin/bash
#
# zsh_setup.sh
# Handles configuration of ZSH with Oh-My-ZSH for the current user
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Configure ZSH with Oh-My-ZSH
configure_zsh_environment() {
  print_header "Configuring ZSH Environment"

  # Install and configure components
  install_oh_my_zsh
  
  # Dotfiles setup is handled separately and includes the .zshrc file
  # which already contains the proper source commands for Homebrew plugins
  
  # Fix permissions for ZSH-related directories to prevent compaudit warnings
  # fix_zsh_permissions

  print_success "ZSH environment configured with Oh-My-ZSH."
}

# Install Oh-My-ZSH for the current user
install_oh_my_zsh() {
  # Check if Oh-My-ZSH is already installed
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_subheader "Installing Oh-My-ZSH"

    # Install Oh-My-ZSH via the official installer
    # Store current ZDOTDIR
    local zdotdir=$ZDOTDIR
    # Unset ZDOTDIR to ensure installer creates .zshrc in $HOME
    unset ZDOTDIR
    # Run installer
    if run_with_spinner "Installing Oh-My-ZSH..." sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
      print_success "Oh-My-ZSH installed successfully."
    else
      print_error "Failed to install Oh-My-ZSH."
      # Restore ZDOTDIR
      export ZDOTDIR=$zdotdir
      return 1
    fi
    # Restore ZDOTDIR
    export ZDOTDIR=$zdotdir
  else
    print_info "Oh-My-ZSH already installed for current user."
  fi
}

# Fix ZSH permissions to avoid compaudit warnings
fix_zsh_permissions() {
  print_subheader "Fixing ZSH permissions"
  
  # Fix permissions for Oh-My-ZSH directories
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    run_with_spinner "Fixing Oh-My-ZSH directory permissions..." chmod -R 755 "$HOME/.oh-my-zsh"
    print_success "Permissions fixed for Oh-My-ZSH directories."
  fi
  
  # Fix permissions for Homebrew ZSH completions
  local brew_prefix
  brew_prefix=$(brew --prefix)
  local zsh_site_functions="$brew_prefix/share/zsh/site-functions"
  
  if [[ -d "$zsh_site_functions" ]]; then
    run_with_spinner "Fixing Homebrew ZSH completion permissions..." chmod -R 755 "$zsh_site_functions"
    print_success "Permissions fixed for Homebrew ZSH completions."
  fi
  
  # Fix permissions for Homebrew ZSH plugins
  for plugin in zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search; do
    local plugin_dir="$brew_prefix/share/$plugin"
    if [[ -d "$plugin_dir" ]]; then
      run_with_spinner "Fixing permissions for $plugin..." chmod -R 755 "$plugin_dir"
      print_success "Permissions fixed for $plugin."
    fi
  done
  
  # Clear compdump files
  run_with_spinner "Clearing compdump files..." rm -f "$HOME/.zcompdump"*
  print_success "Compdump files cleared. Will be regenerated on next shell start."
}
