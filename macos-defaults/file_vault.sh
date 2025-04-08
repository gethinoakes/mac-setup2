#!/bin/bash
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"
# ---- FileVault ---- #
print_info "Enabling FileVault"
if fdesetup status | grep -q "FileVault is On"; then
  print_success "FileVault is already enabled."
else
  sudo fdesetup enable
  print_success "FileVault has been enabled."
fi
