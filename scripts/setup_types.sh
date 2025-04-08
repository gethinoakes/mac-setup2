#!/bin/bash
#
# setup_types.sh
# Handles setup type selection and validation
#

# Source the print utils
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"

# Select setup type
select_setup_type() {
  local setup_type="$1"
  local clean_setup_type=""

  # If setup type is not provided as an argument, prompt the user
  if [[ -z "$setup_type" ]]; then
    print_info "Please select a setup type:"
    local choice
    choice=$(gum choose --header "Select a setup type" "global (brew, apps, shell, node)" "personal (macos settings & dock)" "work (macos settings & dock)")

    # Extract just the first word (global/personal/work) from the selection
    setup_type=$(echo "$choice" | awk '{print $1}')

    # Handle case where user exits without selecting
    if [[ -z "$setup_type" ]]; then
      print_error "No setup type selected. Exiting."
      exit 1
    fi
  fi

  # Convert to lowercase for comparison
  setup_type_lower=$(echo "$setup_type" | tr '[:upper:]' '[:lower:]')

  # Store clean setup type
  clean_setup_type="$setup_type_lower"

  # Validate the setup type
  case "$setup_type_lower" in
  global | personal | work)
    print_success "Selected setup type: $setup_type"
    ;;
  *)
    print_error "Invalid setup type: $setup_type"
    print_info "Valid options are: global, personal, work"
    exit 1
    ;;
  esac

  # Return only the clean setup type value
  echo "$clean_setup_type"
}

# Run the setup flow based on type
run_setup() {
  local setup_type="$1"
  local setup_status=0

  # Extract only global, personal, or work from the input
  setup_type=$(echo "$setup_type" | grep -o -E '^(global|personal|work)$')

  # Start the setup header
  print_subheader "Starting Setup: $setup_type"

  # Run the appropriate setup based on the type
  case "$setup_type" in
  global)
    # Source and run global setup
    source "${SCRIPT_DIR}/scripts/global_setup.sh"
    run_global_setup
    setup_status=$?
    
    # Completion message based on setup status
    if [ $setup_status -eq 0 ]; then
      print_success "Global setup completed successfully!"
    else
      print_warning "Global setup completed with some warnings or errors."
      print_info "You may want to check the log output above for details."
    fi
    
    # Ask if user wants to continue with account setup
    print_info "Would you like to continue with account setup?"
    local continue_choice
    continue_choice=$(gum choose --header "Continue with account setup?" "Yes" "No")
    
    if [[ "$continue_choice" == "Yes" ]]; then
      # Ask which account type to setup
      print_info "Which account type would you like to set up?"
      local account_choice
      account_choice=$(gum choose --header "Select account type" "personal" "work")
      
      if [[ -n "$account_choice" ]]; then
        # Run the selected account setup
        print_subheader "Starting Setup: $account_choice"
        
        # Source and run account setup with account type
        source "${SCRIPT_DIR}/scripts/account_setup.sh"
        run_account_setup "$account_choice"
        local account_status=$?
        
        # Update overall setup status
        if [ $account_status -ne 0 ]; then
          setup_status=1
        fi
        
        # Completion message for account setup
        if [ $account_status -eq 0 ]; then
          print_success "$account_choice setup completed successfully!"
        else
          print_warning "$account_choice setup completed with some warnings or errors."
          print_info "You may want to check the log output above for details."
        fi
        
        # Ask for restart after account setup
        print_info "Setup complete. Would you like to restart your computer now?"
        local restart_choice
        restart_choice=$(gum choose --header "Restart computer?" "Yes" "No")
        
        if [[ "$restart_choice" == "Yes" ]]; then
          print_info "Restarting your computer now..."
          sudo shutdown -r now
        else
          print_info "No restart selected. You may want to restart manually later."
        fi
      fi
    else
      print_info "No additional setup selected. Global setup is complete."
    fi
    ;;
  personal | work)
    # Source and run account setup with account type
    source "${SCRIPT_DIR}/scripts/account_setup.sh"
    run_account_setup "$setup_type"
    setup_status=$?
    
    # Completion message based on setup status
    if [ $setup_status -eq 0 ]; then
      print_success "$setup_type setup completed successfully!"
    else
      print_warning "$setup_type setup completed with some warnings or errors."
      print_info "You may want to check the log output above for details."
    fi
    
    # Ask for restart
    print_info "Setup complete. Would you like to restart your computer now?"
    local restart_choice
    restart_choice=$(gum choose --header "Restart computer?" "Yes" "No")
    
    if [[ "$restart_choice" == "Yes" ]]; then
      print_info "Restarting your computer now..."
      sudo shutdown -r now
    else
      print_info "No restart selected. You may want to restart manually later."
    fi
    ;;
  *)
    # Handle unexpected setup type
    log "Unknown setup type: $setup_type" "ERROR"
    setup_status=1
    ;;
  esac

  # Return the setup status
  return $setup_status
}
