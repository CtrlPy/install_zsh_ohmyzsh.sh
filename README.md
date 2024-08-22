# Zsh and Oh-My-Zsh Installation Script

This repository contains a shell script that automates the installation of Zsh, the Oh-My-Zsh framework, a popular theme (Powerlevel10k), and essential plugins for enhancing your terminal experience.

## Features

- **Zsh Installation**: Installs Zsh, a powerful and highly customizable shell, and sets it as the default shell.
- **Oh-My-Zsh Framework**: Automatically installs Oh-My-Zsh, a community-driven framework for managing your Zsh configuration.
- **Powerlevel10k Theme**: Installs and configures the Powerlevel10k theme, known for its speed and aesthetic appeal.
- **Essential Plugins**: Installs and configures the following plugins:
  - `zsh-autosuggestions`: Suggests commands as you type based on your history.
  - `zsh-syntax-highlighting`: Highlights commands in the terminal for better readability.
  - `zsh-completions`: Adds additional command completions for various tools and commands.

## Usage

To install everything in one go, execute the following command in your terminal:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/CtrlPy/install_zsh_ohmyzsh.sh/main/install_zsh_ohmyzsh.sh)"

```

## setting theme
```zsh
p10k configure
```

This command will automatically install Zsh, Oh-My-Zsh, the Powerlevel10k theme, and the selected plugins.

Requirements
A Unix-based operating system (e.g., Linux, macOS).
curl installed on your system.
sudo privileges for installing packages and changing the default shell.
License
This project is licensed under the MIT License. See the LICENSE file for more details.