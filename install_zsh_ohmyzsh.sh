#!/bin/bash

# Ensure the script is not run as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root"
  exit
fi

# Install Zsh without user interaction
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh

# Install Oh My Zsh for the current user
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins: zsh-autosuggestions and zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Set Powerlevel10k as the default theme and enable plugins in .zshrc
sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc
sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc

# Source the .zshrc to apply the changes
. ~/.zshrc

# Attempt to change default shell to Zsh for the current user
echo "Attempting to change default shell to Zsh..."
if chsh -s $(which zsh); then
    echo "Shell changed successfully!"
else
    echo "Failed to change shell. Please change your shell manually using 'chsh -s $(which zsh)' and entering your password."
fi


# Automatically switch to Zsh
exec zsh
