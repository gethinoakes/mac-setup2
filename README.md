# My Mac Setup Script

A personal script for setting up fresh macOS with my preferred configurations.

## Structure

- **scripts/** - Main functionality modules
  - `environment_setup.sh` - Handles dependency installation (Xcode CLI, Homebrew, Gum)
  - `internet.sh` - Manages internet connectivity with retry logic
  - `setup_types.sh` - Manages setup type selection and execution
  - `global_setup.sh` - Orchestrates the global setup process
  - `account_setup.sh` - Consolidated setup for personal and work accounts
  - **shared/** - Shared functionality used across setup types
    - `node_setup.sh` - Sets up Node.js environment with n
    - `zsh_setup.sh` - Configures Zsh with plugins and themes
    - `dotfiles_setup.sh` - Manages dotfiles installation
    - `macos_preferences.sh` - Sets macOS system preferences
    - `dock_setup.sh` - Configures dock items and appearance
    - `folder_icons_setup.sh` - Customizes folder icons
    - `app_icons_setup.sh` - Customizes application icons using fileicon
  - **utils/** - Utility modules
    - `print_utils.sh` - Printing and UI functions
    - `utils.sh` - General utility functions
    - `sudo_utils.sh` - Sudo access management
    - `dependency-utils.sh` - Dependency management utilities including:
      - Homebrew package installation
      - NPM package installation
      - Homebrew autoupdate configuration
- **config/** - Configuration files
  - **dependencies/** - Dependency configuration
    - `Brewfile` - Package definitions for Homebrew
    - `Brewfile_mas` - Mac App Store package definitions for Homebrew
    - `npm_packages` - Global NPM packages to install
  - `starship.toml` - Starship prompt configuration
  - **folder-icons/** - Custom folder icons
  - **app-icons/** - Configuration for custom application icons
- **docs/** - Documentation
  - `gum.md` - Documentation for Gum CLI tool
  - `ghostty-config-reference.md` - Reference for Ghostty terminal configuration
  - `ghostty-keybinds.md` - Keyboard shortcuts for Ghostty terminal
  - `cursor-sync.md` - Notes on Cursor IDE synchronization
- **macos-defaults/** - macOS-specific dotfiles
- **dotfiles/** - Configuration files for various tools
  - **ghostty/** - Ghostty terminal emulator configuration files
  - **cursor/** - Cursor IDE configuration files
  - **browser-extensions/** - Configuration for browser extensions
  - `.zshrc` - ZSH shell configuration
  - `.gitconfig` - Git configuration
  - `.gitignore_global` - Global Git ignore rules

## Quick Usage

Run the main script:

```bash
./setup.sh [global|personal|work]
```

The script will:

1. Set up the environment (Xcode CLI, Homebrew, Gum)
2. Check internet connectivity
3. Request and maintain sudo access
4. Select setup type (based on argument or interactive prompt)
5. Execute the selected setup configuration

## Requirements

- macOS
- Internet connection

## Module Details

### Core Utility Functions (`scripts/utils/`)

- **Print Utils (`print_utils.sh`)**: Colored output, formatted headers, Gum integration, fallbacks, and interactive prompts
- **General Utils (`utils.sh`)**: Command checking, file operations, version comparison, string manipulation, and system info gathering
- **Sudo Utils (`sudo_utils.sh`)**: Secure sudo initialization, session maintenance, cleanup processes, and error handling
- **Dependency Utils (`dependency-utils.sh`)**: Package installation, Homebrew management, and version validation

#### Common Function Reference

```bash
# Print functions
print_info "Message"     # Display info message
print_success "Message"  # Display success message
print_error "Message"    # Display error message
print_warning "Message"  # Display warning message
print_header "Title"     # Display section header

# Utility functions
command_exists "command" # Check if command exists
is_dir "path"            # Check if directory exists
is_file "path"           # Check if file exists

# Sudo functions
ask_for_sudo            # Request sudo access
maintain_sudo           # Keep sudo session alive
cleanup_sudo            # Clean up sudo processes
```

### Script Modules

#### Core Scripts

- **Environment**: Handles Xcode CLI tools, Homebrew, Gum, environment verification, and dependency checking
- **Internet**: Manages connectivity with multiple endpoints, retry logic, and user feedback
- **Setup Types**: Handles setup type selection, validation, and execution orchestration

#### Setup Types

- **Global Setup**: Base system setup, Homebrew installation, and system-wide configurations
- **Account Setup**: Consolidated module for both personal and work configurations, determining the appropriate settings based on the account type

#### Shared Modules

- **Node Setup**: Installs n, Node.js LTS, and global NPM packages
- **ZSH Setup**: Configures Oh My Zsh with plugins and custom settings
- **Dotfiles**: Version-controlled configuration files with backup and linking
- **Dock**: Custom dock items, ordering, and appearance for both personal and work accounts
- **Folder Icons**: Custom icons for improved visual navigation
- **App Icons**: Custom application icons using fileicon
- **macOS Preferences**: System-wide settings for UI, performance, and security

#### Utility Modules

- **Print Utils**: Terminal output formatting, colored text, and user interface elements
- **General Utils**: File system operations, command validation, and general helpers
- **Sudo Utils**: Secure sudo access management and session maintenance
- **Dependency Utils**: Package management for Homebrew and NPM packages

### Configurations (`config/`)

- **Brewfile**: Core CLI tools, desktop applications, development tools, and system utilities
- **Brewfile_mas**: Mac App Store applications installed via Homebrew
- **npm_packages**: Global Node.js packages with optional versions
- **starship.toml**: Custom prompt configuration
- **folder-icons**: SVG icons for high-resolution displays
- **app-icons**: Configuration for custom application icons

### Dotfiles

The dotfiles are managed by `dotfiles_setup.sh` which:

1. Backs up existing dotfiles
2. Creates symbolic links to the repository versions
3. Sources appropriate files in shell config
4. Handles platform-specific configurations

Notable dotfiles include:

- `.zshrc` - ZSH configuration with plugins and settings
- `.gitconfig` - Git user configuration and aliases
- `.gitignore_global` - Global Git ignore patterns
- **ghostty/** - Ghostty terminal emulator configuration
- **cursor/** - Cursor IDE settings synchronization configuration
- **browser-extensions/** - Vimium configuration for browsers

## Using Gum for UI

[Gum](https://github.com/charmbracelet/gum) enhances the shell script with:

- Interactive menus and selection interfaces
- Stylized text output with colors and formatting
- Input prompts with validation
- Progress spinners and indicators
- Confirmation dialogs

## Key Features

- **Modular Design**: Easily extend or customize specific parts of my setup
- **Multiple Configurations**: Support for personal and work setups
- **Homebrew Management**: Package installation and automatic updates
- **Terminal Customization**: ZSH, Starship prompt, and Ghostty configuration
- **Dotfiles Management**: Version-controlled configuration files
- **macOS Preferences**: System and application settings
- **User Experience**: Enhanced UI with Gum CLI tool
- **Folder Icon Customization**: Custom icons for system folders
- **App Icon Customization**: Custom icons for applications
- **Dock Configuration**: Custom dock layout and behavior

## Personal Notes

- For a completely fresh Mac setup, always run global setup first, then personal/work
- Remember to manually sign in to iCloud and App Store before running the setup
- Update Brewfile regularly to keep track of installed packages
- Update the account type parameter in `account_setup.sh` when adding new setups
- Modify `dotfiles_setup.sh` when adding new configuration files
- The `shared` modules are reused between personal and work setups
