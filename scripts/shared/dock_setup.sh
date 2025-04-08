#!/bin/bash
#
# dock_setup.sh
# Handles dock configuration for personal and work accounts
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Check if dockutil is installed and install if needed
check_dockutil() {
  if ! command -v dockutil &>/dev/null; then
    print_warning "dockutil not found. Installing dockutil..."

    # Install dockutil using Homebrew
    brew install dockutil
  fi
}

# Configure personal dock
configure_personal_dock() {
  print_subheader "Configuring Personal Dock"

  # Check if dockutil is installed
  check_dockutil

  # Clear the dock first
  dockutil --remove all --no-restart

  dockutil --add "/Applications/Arc.app" --no-restart
  dockutil --add "/Applications/Zen.app" --after "Arc" --no-restart
  dockutil --add "/Applications/FMail2.app" --after "Zen" --no-restart
  dockutil --add "/Applications/Shortwave.app" --after "FMail2" --no-restart
  dockutil --add "/System/Applications/Messages.app" --after "Shortwave" --no-restart
  dockutil --add "/System/Applications/Photos.app" --after "Messages" --no-restart
  dockutil --add "/System/Applications/Notes.app" --after "Photos" --no-restart
  dockutil --add "/Applications/Spotify.app" --after "Notes" --no-restart
  dockutil --add '' --type spacer --after "Spotify" --section apps --no-restart

  # Development applications
  dockutil --add "/Applications/Cursor.app" --no-restart
  dockutil --add "/Applications/Ghostty.app" --after "Cursor" --no-restart
  dockutil --add "/Applications/ChatGPT.app" --after "Ghostty" --no-restart
  dockutil --add "/Applications/Sketch.app" --after "ChatGPT" --no-restart
  dockutil --add "/Applications/Figma.app" --after "Sketch" --no-restart
  dockutil --add '' --type spacer --after "Figma" --section apps --no-restart

  # System applications
  dockutil --add "/System/Applications/System Settings.app" --no-restart

  # Add folders to Dock
  print_info "Adding folders to Dock..."
  dockutil --add "/Volumes/StudioX/Downloads" --view grid --display folder --no-restart
  dockutil --add "/Volumes/StudioX/Developer" --view grid --display folder --no-restart

  # Restart the dock to apply changes
  killall Dock

  print_success "Personal Dock preferences configured."
}

# Configure work dock
configure_work_dock() {
  print_subheader "Configuring Work Dock"

  # Check if dockutil is installed
  check_dockutil

  # Clear the dock first
  dockutil --remove all --no-restart

  # Personal applications
  dockutil --add "/Applications/Arc.app" --no-restart
  dockutil --add "/Applications/Zen.app" --after "Arc" --no-restart
  dockutil --add "/Applications/Microsoft Teams.app" --after "Zen" --no-restart
  dockutil --add "/Applications/Mail.app" --after "Microsoft Teams" --no-restart
  dockutil --add "/Applications/Notes.app" --after "Mail" --no-restart
  dockutil --add "/Applications/Spotify.app" --after "Notes" --no-restart
  dockutil --add '' --type spacer --after "Spotify" --section apps --no-restart

  # Development applications
  dockutil --add "/Applications/Cursor.app" --no-restart
  dockutil --add "/Applications/Ghostty.app" --after "Cursor" --no-restart
  dockutil --add "/Applications/Setapp/Gitfox.app" --after "Ghostty" --no-restart
  dockutil --add '' --type spacer --after "Gitfox" --section apps --no-restart

  # System applications
  dockutil --add "/System/Applications/System Settings.app" --no-restart

  # Add folders to Dock
  print_info "Adding folders to Dock..."
  dockutil --add "/Volumes/StudioX/DX/Downloads" --view grid --display folder --no-restart
  dockutil --add "/Volumes/StudioX/DX/Developer" --view grid --display folder --no-restart
  dockutil --add "/Volumes/StudioX/DX/Screenshots" --view grid --display folder --no-restart

  # Restart the dock to apply changes
  killall Dock

  print_success "Work Dock preferences configured."
}
