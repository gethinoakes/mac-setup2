#!/bin/bash
#
# dotfiles_setup.sh
# Handles dotfiles setup
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Define dotfiles location
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../dotfiles" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Create symlink for a dotfile
create_symlink() {
  local source_file="$1"
  local target_file="$2"

  # Check if the target file exists and is not a symlink
  if [[ -f "$target_file" && ! -L "$target_file" ]]; then
    # Create backup directory if it doesn't exist
    mkdir -p "$BACKUP_DIR"

    run_with_spinner "Backing up $target_file to $BACKUP_DIR" cp "$target_file" "$BACKUP_DIR/"
  fi

  # Create symlink
  run_with_spinner "Creating symlink for $source_file" ln -sf "$source_file" "$target_file"
}

# Deploy dotfiles
deploy_dotfiles() {
  print_subheader "Deploying Dotfiles"

  create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
  create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
  create_symlink "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
}

# Deploy Ghostty configuration
deploy_ghostty_config() {
  print_subheader "Setting up Ghostty configuration"

  # Create Ghostty config directory if it doesn't exist
  mkdir -p "$HOME/.config/ghostty"

  # Create symlink for Ghostty config
  create_symlink "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

  print_success "Ghostty configuration deployed to $HOME/.config/ghostty/config"
}

# Deploy Starship configuration
deploy_starship_config() {
  print_subheader "Setting up Starship configuration"

  # Create Starship config directory if it doesn't exist
  mkdir -p "$HOME/.config"

  # Create symlink for Starship config
  create_symlink "${SCRIPT_DIR}/config/starship.toml" "$HOME/.config/starship.toml"

  print_success "Starship configuration deployed to $HOME/.config/starship.toml"

}

# Setup dotfiles
setup_dotfiles() {
  print_header "Setting up Dotfiles"

  # Deploy dotfiles
  deploy_dotfiles

  # Deploy Ghostty configuration
  deploy_ghostty_config

  # Deploy Starship configuration
  deploy_starship_config

  print_success "Dotfiles setup complete."
}
