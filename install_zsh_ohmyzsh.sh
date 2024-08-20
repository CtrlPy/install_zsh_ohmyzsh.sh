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

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins: zsh-autosuggestions and zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Modify .zshrc to set Powerlevel10k as the default theme and enable plugins
sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc
sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc

# Source the .zshrc to apply the changes
source ~/.zshrc

# Attempt to change default shell to Zsh for the current user
echo "Attempting to change default shell to Zsh..."
if chsh -s $(which zsh); then
    echo "Shell changed successfully!"
else
    echo "Failed to change shell. Please change your shell manually using 'chsh -s $(which zsh)' and entering your password."
fi

# Prompt the user to start a new Zsh session
echo "Installation complete. Please start a new terminal session to use Zsh."
