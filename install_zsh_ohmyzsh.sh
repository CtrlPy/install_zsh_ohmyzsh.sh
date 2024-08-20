#!/bin/bash

# Ensure the script is not run as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root"
  exit
fi

# Function to install Zsh based on the detected OS
install_zsh() {
    if [ -f /etc/debian_version ]; then
        # Debian/Ubuntu
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh
    elif [ -f /etc/arch-release ]; then
        # Arch Linux
        sudo pacman -Syu --noconfirm zsh
    elif [ -f /etc/redhat-release ]; then
        # RedHat/CentOS/Fedora
        sudo yum install -y zsh
    elif [ "$(uname)" == "Darwin" ]; then
        # macOS
        brew install zsh
    else
        echo "Unsupported OS. Please install Zsh manually."
        exit 1
    fi
}

# Install Zsh
install_zsh

# Install Oh My Zsh for the current user
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Wait for Oh My Zsh installation to complete
sleep 5

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install plugins: zsh-autosuggestions and zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Ensure the .zshrc file is ready before making changes
if [ -f ~/.zshrc ]; then
    # Enable plugins in .zshrc
    sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc
else
    echo ".zshrc file not found. Please check the installation process."
    exit 1
fi

# Attempt to change default shell to Zsh for the current user
echo "Attempting to change default shell to Zsh..."
if chsh -s $(which zsh); then
    echo "Shell changed successfully!"
else
    echo "Failed to change shell. Please change your shell manually using 'chsh -s $(which zsh)' and entering your password."
fi

# Start a new Zsh session and run Powerlevel10k configuration
echo "Starting Zsh and launching Powerlevel10k configuration..."
exec zsh -i -c 'p10k configure'
