#!/bin/bash

# Create log directory
LOG_DIR="$HOME/.first_install"
mkdir -p "$LOG_DIR"

# Function to log and display output
log_and_display() {
    tee -a "$1"
}

# Function to check command success
check_success() {
    if [ $? -eq 0 ]; then
        echo -e "\e[32m$1 installation succeeded.\e[0m" | log_and_display "$LOG_DIR/$1.log"
    else
        echo -e "\e[31m$1 installation failed.\e[0m" | log_and_display "$LOG_DIR/$1.log"
    fi
}

# Update and upgrade system
update_system() {
    echo "Updating system..." | log_and_display "$LOG_DIR/update_system.log"
    sudo apt update && sudo apt upgrade -y | log_and_display "$LOG_DIR/update_system.log"
    check_success "System Update"
}

# Install build-essential
install_build_essential() {
    echo "Installing build-essential..." | log_and_display "$LOG_DIR/build_essential.log"
    sudo apt install -y build-essential | log_and_display "$LOG_DIR/build_essential.log"
    check_success "build-essential"
}

# Install Java (OpenJDK)
install_java() {
    echo "Installing Java..." | log_and_display "$LOG_DIR/java.log"
    sudo apt install -y openjdk-17-jdk | log_and_display "$LOG_DIR/java.log"
    check_success "Java"
}

# Install npm and Node.js
install_node_npm() {
    echo "Installing Node.js and npm..." | log_and_display "$LOG_DIR/node_npm.log"
    sudo apt install -y nodejs npm | log_and_display "$LOG_DIR/node_npm.log"
    check_success "Node.js and npm"
}

# Install Vim
install_vim() {
    echo "Installing Vim..." | log_and_display "$LOG_DIR/vim.log"
    sudo apt install -y vim | log_and_display "$LOG_DIR/vim.log"
    check_success "Vim"
}

# Install tmux
install_tmux() {
    echo "Installing tmux..." | log_and_display "$LOG_DIR/tmux.log"
    sudo apt install -y tmux | log_and_display "$LOG_DIR/tmux.log"
    check_success "tmux"
}

# Install FFmpeg
install_ffmpeg() {
    echo "Installing FFmpeg..." | log_and_display "$LOG_DIR/ffmpeg.log"
    sudo apt install -y ffmpeg | log_and_display "$LOG_DIR/ffmpeg.log"
    check_success "FFmpeg"
}

# Install Python 3.12 and pip
install_python_pip() {
    echo "Installing Python 3.12 and pip..." | log_and_display "$LOG_DIR/python_pip.log"
    sudo add-apt-repository -y ppa:deadsnakes/ppa | log_and_display "$LOG_DIR/python_pip.log"
    sudo apt update | log_and_display "$LOG_DIR/python_pip.log"
    sudo apt install -y python3.12 python3.12-venv python3.12-dev | log_and_display "$LOG_DIR/python_pip.log"
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12 | log_and_display "$LOG_DIR/python_pip.log"
    check_success "Python 3.12 and pip"
}

# Install Docker and Docker Compose
install_docker() {
    echo "Installing Docker and Docker Compose..." | log_and_display "$LOG_DIR/docker.log"
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common | log_and_display "$LOG_DIR/docker.log"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - | log_and_display "$LOG_DIR/docker.log"
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" | log_and_display "$LOG_DIR/docker.log"
    sudo apt update | log_and_display "$LOG_DIR/docker.log"
    sudo apt install -y docker-ce docker-ce-cli containerd.io | log_and_display "$LOG_DIR/docker.log"
    sudo usermod -aG docker $USER | log_and_display "$LOG_DIR/docker.log"
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose | log_and_display "$LOG_DIR/docker.log"
    sudo chmod +x /usr/local/bin/docker-compose | log_and_display "$LOG_DIR/docker.log"
    check_success "Docker and Docker Compose"
}

# Install Git
install_git() {
    echo "Installing Git..." | log_and_display "$LOG_DIR/git.log"
    sudo apt install -y git | log_and_display "$LOG_DIR/git.log"
    check_success "Git"
}

# Install VLC
install_vlc() {
    echo "Installing VLC..." | log_and_display "$LOG_DIR/vlc.log"
    sudo apt install -y vlc | log_and_display "$LOG_DIR/vlc.log"
    check_success "VLC"
}

# Install VS Code
install_vscode() {
    echo "Installing VS Code..." | log_and_display "$LOG_DIR/vscode.log"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg | log_and_display "$LOG_DIR/vscode.log"
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ | log_and_display "$LOG_DIR/vscode.log"
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' | log_and_display "$LOG_DIR/vscode.log"
    sudo apt update | log_and_display "$LOG_DIR/vscode.log"
    sudo apt install -y code | log_and_display "$LOG_DIR/vscode.log"
    check_success "VS Code"
}

# Install Spotify
install_spotify() {
    echo "Installing Spotify..." | log_and_display "$LOG_DIR/spotify.log"
    snap install spotify
    check_success "Spotify"
}

# Install LibreOffice
install_libreoffice() {
    echo "Installing LibreOffice..." | log_and_display "$LOG_DIR/libreoffice.log"
    sudo apt install -y libreoffice | log_and_display "$LOG_DIR/libreoffice.log"
    check_success "LibreOffice"
}

# Install Windsurf (Assuming it's an AppImage)
install_windsurf() {
    curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null

    sudo apt-get update

    sudo apt-get upgrade -y windsurf
}



# Install qBittorrent
install_qbittorrent() {
    echo "Installing qBittorrent..." | log_and_display "$LOG_DIR/qbittorrent.log"
    sudo apt install -y qbittorrent | log_and_display "$LOG_DIR/qbittorrent.log"
    check_success "qBittorrent"
}

# Install and configure Jellyfin with NVIDIA HW acceleration
install_jellyfin() {
    curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
    sudo apt update && sudo apt install -y jellyfin-ffmpeg7
    sudo apt update && sudo apt install -y  libnvidia-decode-570 libnvidia-encode-570
}

install_warp_cli() {
    echo "Installing Cloudflare WARP CLI..."
    LOG_DIR="$HOME/.first_install"
    LOG_FILE="$LOG_DIR/warp_cli_install.log"
    mkdir -p "$LOG_DIR"
    {
        curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bookworm main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
        sudo apt-get update && sudo apt-get install -y cloudflare-warp
        warp-cli registration new
        warp-cli connect
        warp-cli status
    } | tee "$LOG_FILE"
    check_success "warp-cli"
}


main() {
    update_system
    install_build_essential
    install_java
    install_node_npm
    install_vim
    install_tmux
    install_ffmpeg
    install_python_pip
    install_docker
    install_git
    install_vlc
    install_vscode
    install_spotify
    install_libreoffice
    install_windsurf

    install_qbittorrent
    install_jellyfin
    install_warp_cli
}

main

