#!/bin/bash

# print_utils.sh - Helper functions for printing messages
# Provides both basic print functions (for before Gum is installed)
# and Gum-based functions (for after it's installed)

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Basic print functions (for use before Gum is installed)

# Function to print section header without Gum
basic_print_header() {
  local title="$1"
  local width
  width=$(tput cols)
  local header_width
  header_width=$((width - 4))
  local padding
  padding=$(((header_width - ${#title}) / 2))

  echo
  printf '='%.0s $(seq 1 "$width")
  echo
  printf "%*s%s%*s\n" $padding "" "$title" $padding ""
  printf '='%.0s $(seq 1 "$width")
  echo
}

# Function to print a success message without Gum
basic_print_success() {
  local msg="$1"
  echo -e "${GREEN}✓ $msg${NC}"
}

# Function to print a warning message without Gum
basic_print_warning() {
  local msg="$1"
  echo -e "${YELLOW}⚠ $msg${NC}"
}

# Function to print an error message without Gum
basic_print_error() {
  local msg="$1"
  echo -e "${RED}✗ $msg${NC}"
}

# Function to print an info message without Gum
basic_print_info() {
  local msg="$1"
  echo -e "${BLUE}ℹ $msg${NC}"
}

# Gum-based print functions (for use after Gum is installed)

# Function to print section header with Gum
print_header() {
  local title="$1"
  gum style \
    --border double \
    --border-foreground 212 \
    --align center \
    --width 50 \
    --margin "1 2" \
    --padding "2 4" \
    "$title"
}

# Function to print a subheader with Gum
print_subheader() {
  local title="$1"
  gum style \
    --border normal \
    --border-foreground 33 \
    --align center \
    --width 50 \
    --padding "1 2" \
    "$title"
}

# Function to print a success message with Gum
print_success() {
  local msg="$1"
  gum style --foreground 46 --bold "✓ $msg"
}

# Function to print a warning message with Gum
print_warning() {
  local msg="$1"
  gum style --foreground 208 --bold "⚠ $msg"
}

# Function to print a error message with Gum
print_error() {
  local msg="$1"
  gum style --foreground 196 --bold "✗ $msg"
}

# Function to print a info message with Gum
print_info() {
  local msg="$1"
  gum style --foreground 33 --bold "ℹ $msg"
}

# Function to print normal text with Gum
print_text() {
  local msg="$1"
  gum style "$msg"
}

# Gum-based spinner functions

# Function to run a command with a spinner
# Accepts a message and a command to run
run_with_spinner() {
  local message="$1"
  shift
  gum spin --spinner dot --title "$message" -- "$@"
}

# Function to run a sudo command with a spinner
run_sudo_with_spinner() {
  local message="$1"
  shift
  gum spin --spinner dot --title "$message" -- sudo "$@"
}
