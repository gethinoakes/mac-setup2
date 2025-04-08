#!/bin/bash
#
# macos_preferences.sh
# Handles macOS preferences configuration
#

# Source print utilities
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Apply macOS preferences
apply_macos_preferences() {
  print_header "macOS Preferences"

  # Path to macOS preference scripts
  MACOS_PREFS_DIR="macos-defaults"

  if [ ! -d "$MACOS_PREFS_DIR" ]; then
    print_error "macOS preferences directory not found: $MACOS_PREFS_DIR"
    return 1
  fi

  # Count the number of scripts for progress tracking
  TOTAL_SCRIPTS=$(find "$MACOS_PREFS_DIR" -name "*.sh" | wc -l)
  CURRENT_SCRIPT=0

  print_subheader "Applying macOS preference scripts"

  # Process each preference script
  find "$MACOS_PREFS_DIR" -name "*.sh" -type f | sort | while read -r pref_script; do
    script_name=$(basename "$pref_script")
    CURRENT_SCRIPT=$((CURRENT_SCRIPT + 1))

    # Display progress info
    print_info "Processing ($CURRENT_SCRIPT/$TOTAL_SCRIPTS): $script_name"

    # Run the script with spinner
    if run_with_spinner "Applying $script_name" bash "$pref_script"; then
      print_success "$script_name applied successfully"
    else
      print_error "Failed to apply $script_name"
    fi
  done

  print_success "All macOS preferences applied successfully"
}
