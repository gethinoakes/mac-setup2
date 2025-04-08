#!/bin/bash
#
# app_icons_setup.sh
# Apply custom icons to applications using fileicon
#

# Set SCRIPT_DIR if not already set (for when script is run directly)
if [ -z "$SCRIPT_DIR" ]; then
  # Find the root directory containing scripts/utils
  SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
fi

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"
source "${SCRIPT_DIR}/scripts/utils/sudo_utils.sh"

# Apply custom icons to applications
apply_app_icons() {
  print_header "Applying App Icons"
  local app_icons_status=0

  # Get the current script's directory and the project root
  local current_dir
  current_dir="$(pwd)"

  # Define the path to the app icons
  local icons_dir
  icons_dir="${current_dir}/config/app-icons"

  print_info "App Icons directory: ${icons_dir}"

  # Check if icons directory exists
  if [ ! -d "$icons_dir" ]; then
    print_warning "App icons directory not found: ${icons_dir}"
    print_info "Skipping app icons setup."
    return 1
  fi

  # Get list of icon files in the app-icons directory (excluding _archived directory)
  local icon_files=()
  while IFS= read -r icon_file; do
    if [[ $icon_file == *.icns ]]; then
      icon_files+=("$icon_file")
    fi
  done < <(find "$icons_dir" -type f -name "*.icns" -not -path "*/_archived/*" 2>/dev/null || echo "")

  # Check if any icon files were found
  if [ ${#icon_files[@]} -eq 0 ]; then
    print_warning "No app icon files found in ${icons_dir}"
    print_info "Skipping app icons setup."
    return 1
  fi

  print_info "Found ${#icon_files[@]} icon files to apply"

  # Check if fileicon is installed
  if ! command -v fileicon &>/dev/null; then
    print_error "The 'fileicon' utility is not installed."
    print_info "Please ensure fileicon is installed before running this script (brew install fileicon)."
    return 1
  fi

  # Show a list of icons to be applied
  local apps_to_apply=()
  local app_paths=()
  local icon_paths=()
  local errors=0

  for icon_path in "${icon_files[@]}"; do
    # Get the icon filename without extension
    icon_name=$(basename "$icon_path" .icns)

    # Get subdirectory path relative to the icons dir
    local relative_path="${icon_path#"$icons_dir"/}"
    local sub_path=""

    # Check if the icon is in a subdirectory
    if [[ "$relative_path" == */* ]]; then
      # Extract subdirectory path
      sub_path=$(dirname "$relative_path")
      sub_dir=$(basename "$sub_path")
    fi

    # Initialize app_path variables
    local app_name="$icon_name"
    local app_path=""

    # Try different app locations and naming formats
    local possible_paths=()

    # Case 1: App directly in Applications
    possible_paths+=("/Applications/${app_name}.app")

    # Case 2: App name with spaces instead of hyphens
    local app_name_with_spaces="${icon_name//-/ }"
    possible_paths+=("/Applications/${app_name_with_spaces}.app")

    # Case 3: App in subdirectory with original name (try both capitalized and non-capitalized)
    if [[ -n "$sub_path" ]]; then
      possible_paths+=("/Applications/${sub_dir}/${app_name}.app")
      possible_paths+=("/Applications/${sub_dir_cap}/${app_name}.app")
      # Case 4: App in subdirectory with spaces instead of hyphens
      possible_paths+=("/Applications/${sub_dir}/${app_name_with_spaces}.app")
      possible_paths+=("/Applications/${sub_dir_cap}/${app_name_with_spaces}.app")
    fi

    # Try each possible path
    local found=false
    for possible_path in "${possible_paths[@]}"; do
      if [ -d "$possible_path" ]; then
        app_path="$possible_path"
        app_name=$(basename "$app_path" .app)
        found=true
        break
      fi
    done

    # If app exists with any naming convention, add to array
    if $found; then
      apps_to_apply+=("$app_name")
      app_paths+=("$app_path")
      icon_paths+=("$icon_path")
    else
      print_warning "No matching application found for icon: $icon_name (searched in: ${possible_paths[*]})"
    fi
  done

  # For each application, apply the icon
  for i in "${!apps_to_apply[@]}"; do
    local app_name="${apps_to_apply[$i]}"
    local app_path="${app_paths[$i]}"
    local icon_path="${icon_paths[$i]}"

    print_info "Applying icon to $app_name at $app_path..."

    # Apply the icon using fileicon
    if fileicon set "$app_path" "$icon_path"; then
      print_success "Set icon for $app_path"
    else
      print_error "Failed to set icon for $app_path"
      print_info "Attempting with sudo..."
      if ! sudo_run fileicon set "$app_path" "$icon_path"; then
        print_error "Failed to set icon for $app_path even with sudo"
        errors=$((errors + 1))
      fi
    fi

    # Show progress with Gum
    gum spin --spinner dot --title "Processing $app_name" -- sleep 1
  done

  # Force reload the icon cache
  print_info "Refreshing icon cache..."
  # Also refresh icons in subdirectories
  for app_path in "/Applications/"*.app "/Applications/"*/*.app; do
    if [ -d "$app_path" ]; then
      touch "$app_path" &>/dev/null || true
    fi
  done

  # Restart Finder and Dock to apply changes
  print_info "Restarting Finder and Dock..."
  gum spin --spinner dot --title "Restarting Finder" -- killall Finder || app_icons_status=1
  gum spin --spinner dot --title "Restarting Dock" -- killall Dock || app_icons_status=1

  if [ $errors -gt 0 ]; then
    print_warning "App icons setup completed with $errors errors."
    app_icons_status=1
  else
    print_success "App icons setup complete!"
  fi

  return $app_icons_status
}

# Execute the main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  apply_app_icons
fi
