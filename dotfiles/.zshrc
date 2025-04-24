# ZSH Configuration for macOS
# ========================

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_verify

# Basic zsh options
setopt autocd
setopt extendedglob
setopt nomatch
setopt prompt_subst
unsetopt beep

# Path additions - Set these early before anything else
export PATH="$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

# Node.js configuration - must be set before anything else
export N_PREFIX="$HOME/.n"
export PATH="$N_PREFIX/bin:$PATH"

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set up FPATH before initialization
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Load ZSH functions without errors
# autoload -Uz compinit
# autoload -Uz add-zsh-hook
# ZSH_DISABLE_COMPFIX="true"

# Initialize completion
# compinit -i

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git z fzf)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set default editor
export EDITOR="vim"
export VISUAL="vim"

# Load custom functions
if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# General aliases
alias ls="ls -G"
alias ll="ls -la"
alias la="ls -a"
alias l="ls -l"
alias grep="grep --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# macOS specific aliases
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Tool specific aliases
alias p='pnpm'
alias b='bun'

# Java configuration
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Android SDK configuration
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Bun configuration
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun aliases/functions
bi() { bun install "$@"; }
bu() { bun uninstall "$@"; }

# Initialize Starship prompt
eval "$(starship init zsh)"

# Starship configuration
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# Configure zsh completion system
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' rehash true

# Source Homebrew ZSH plugins directly (proper way for Homebrew-installed plugins)
if type brew &>/dev/null; then
  # Source zsh-syntax-highlighting
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

  # Source zsh-autosuggestions
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

  # Source zsh-history-substring-search
  source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
fi


# Load Angular CLI autocompletion.
source <(ng completion script)
