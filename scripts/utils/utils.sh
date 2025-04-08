#!/bin/bash

# utils.sh - Helper functions for mac-setup

# Function to check if a command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Function to execute a command with sudo privileges
sudo_exec() {
  # Check if sudo_run is defined
  if declare -f sudo_run &>/dev/null; then
    sudo_run "$@"
  else
    # Fall back to regular sudo
    sudo "$@"
  fi
}
