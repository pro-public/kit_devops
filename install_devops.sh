# https://github.com/pro-public/
#
# Instalación de homebrew
# Ubuntu - sudo apt-get install build-essential procps curl file git
# Rocky/Redhat - sudo yum groupinstall 'Development Tools'
# Rocky/Redhat - sudo yum install procps-ng curl file git
echo "Instalando Oh my Zsh..."
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

sleep 10
echo "Installing TMUX "
sudo apt-get install tmux
sleep 10
echo "All the installations runs under brew"
echo "Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sleep 10
echo "Installing neovim  - a powered vim editor based"
brew install neovim
echo "Installing a Docker Layer Inspect: DIVE"
echo "https://github.com/wagoodman/dive"
brew install dive
#DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
#curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
#sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
echo "Installing lazygit"
echo "https://github.com/jesseduffield/lazygit.git"
brew install lazygit
echo "Installing Lazydocker"
echo "https://github.com/jesseduffield/lazydocker.git"
brew install jesseduffield/lazydocker/lazydocker
