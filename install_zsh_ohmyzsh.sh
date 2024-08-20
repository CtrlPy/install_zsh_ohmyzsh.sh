#!/bin/bash

# Install Zsh without user interaction
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh

# Set Zsh as the default shell
chsh -s $(which zsh) $USER

# Initialize Zsh for the first time to create the necessary configuration files
if [ ! -f ~/.zshrc ]; then
    echo "Initializing Zsh for the first time..."
    touch ~/.zshrc
    /usr/bin/zsh -c "source ~/.zshrc"
fi

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Apply the theme to .zshrc
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Install essential plugins
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
fi

# Add plugins to .zshrc
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
    sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/' ~/.zshrc
fi

# Source the .zshrc to apply changes
source ~/.zshrc

# Restart Zsh to apply changes
exec zsh
