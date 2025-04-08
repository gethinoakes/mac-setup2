#!/bin/bash
source "${SCRIPT_DIR}/scripts/utils/print_utils.sh"
# ---- Firewall ---- #
print_step "Enabling Firewall"
if [[ $(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate) == "Enabled" ]]; then
  print_success_muted "Firewall is already enabled."
else
  sudo_run /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
  print_success "Firewall enabled"
fi
