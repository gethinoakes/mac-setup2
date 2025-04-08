#!/bin/bash
#
# folder_icons_setup.sh
# Applies custom folder icons to external drives and folders
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Apply icons to the StudioX drive and common folders
apply_folder_icons() {
  local use_fileicon=true

  print_header "Setting up Folder Icons"

  # Get the current script's directory and the project root
  local current_dir
  current_dir="$(pwd)"

  # Define the base path to icons
  local icons_dir
  icons_dir="${current_dir}/config/folder-icons"

  print_info "Icons directory: ${icons_dir}"

  # Apply icon to StudioX drive
  if [ -d "/Volumes/StudioX" ]; then
    print_info "Applying icon to StudioX drive..."
    set_icon_with_fileicon "${icons_dir}/ssd.icns" "/Volumes/StudioX" "$use_fileicon"
  else
    print_warning "StudioX drive not found. Skipping icon application."
  fi

  # Apply icons to common folders on StudioX if they exist
  local folders=("Developer" "Documents" "Downloads" "Music" "Pictures" "Screenshots" "Temp" "Work")
  local icons=("developer.icns" "documents.icns" "downloads.icns" "music.icns" "pictures.icns" "screenshots.icns" "temp.icns" "work.icns")

  for i in "${!folders[@]}"; do
    local folder="/Volumes/StudioX/${folders[$i]}"
    local icon="${icons_dir}/${icons[$i]}"

    if [ -d "$folder" ]; then
      print_info "Applying icon to ${folders[$i]} folder..."
      set_icon_with_fileicon "$icon" "$folder" "$use_fileicon"
    fi
  done

  # Clear icon cache to ensure icons are refreshed
  print_info "Refreshing icon cache..."
  killall Finder
}

# Helper function to apply an icon to a folder or drive using fileicon utility
set_icon_with_fileicon() {
  local icon_path="$1"
  local target_folder="$2"

  if [[ ! -f "$icon_path" ]]; then
    print_error "Icon file not found: $icon_path"
    return 1
  fi

  if [[ ! -d "$target_folder" ]]; then
    print_error "Target folder not found: $target_folder"
    return 1
  fi

  # Apply the icon using fileicon utility
  fileicon set "$target_folder" "$icon_path"

  print_success "Set icon for $target_folder"
}

# ALTERNATIVE IMPLEMENTATION (Manual method)
# This is the original implementation that uses direct macOS commands
# to set folder icons. It's kept as a reference in case the fileicon
# utility is not available or doesn't work as expected.
#
# set_icon_manual() {
#   local icon_path="$1"
#   local target_folder="$2"
#   local temp_rsrc_file="/tmp/icon_$$.rsrc"

#   if [[ ! -f "$icon_path" ]]; then
#     print_error "Icon file not found: $icon_path"
#     return 1
#   fi

#   if [[ ! -d "$target_folder" ]]; then
#     print_error "Target folder not found: $target_folder"
#     return 1
#   fi

#   # Remove any existing icon file
#   rm -f "${target_folder}/Icon"$'\r' 2>/dev/null

#   # Create resource file from the icon
#   sips -i "$icon_path" >/dev/null 2>&1
#   DeRez -only icns "$icon_path" >"$temp_rsrc_file" 2>/dev/null

#   # Create Icon file with resource fork
#   touch "${target_folder}/Icon"$'\r'
#   Rez -a "$temp_rsrc_file" -o "${target_folder}/Icon"$'\r' 2>/dev/null

#   # Set the custom and hidden attributes
#   SetFile -a C "$target_folder"
#   SetFile -a V "${target_folder}/Icon"$'\r'

#   # Clean up
#   rm -f "$temp_rsrc_file" 2>/dev/null

#   print_success "Set icon for $target_folder (manual method)"
# }
