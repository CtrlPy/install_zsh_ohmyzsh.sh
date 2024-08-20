#!/bin/bash

# Install Zsh without user interaction
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins: zsh-autosuggestions and zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Set Powerlevel10k as the default theme and enable plugins in .zshrc
if [ ! -f ~/.zshrc ]; then
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc
else
    sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc
fi

# Add plugins to .zshrc
sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc

# Source the .zshrc to apply the changes
echo 'source ~/.zshrc' >> ~/.zshrc

# Change default shell to Zsh
chsh -s $(which zsh) $USER

# Ensure Zsh is set as the default shell
echo "SHELL is set to $SHELL"
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh"
    chsh -s $(which zsh)
fi

# Prompt user to restart the terminal
echo "Installation complete. Please restart your terminal."
