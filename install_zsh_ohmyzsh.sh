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
        sudo apt update -y
        sudo apt install -y zsh
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
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install additional plugins and theme
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# Update .zshrc with the new theme and plugins
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
sed -i -e 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions aws asdf)/g' ~/.zshrc

# Disable the Powerlevel10k configuration wizard
grep -qxF 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' ~/.zshrc || echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' >> ~/.zshrc

# Change default shell to Zsh for the current user
sudo chsh -s $(which zsh) $USER

# Automatically switch to Zsh
exec zsh
