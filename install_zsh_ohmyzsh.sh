#!/bin/bash

# Install Zsh
sudo apt update && sudo apt install -y zsh

# Change default shell to Zsh
chsh -s $(which zsh)

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
