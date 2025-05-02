# Linux Development Environment Setup Script

This script automates the setup of a development environment on Debian-based Linux systems (like Ubuntu) by installing a collection of common developer tools, applications, and system utilities.

## Overview

The script performs the following actions:

1.  Updates and upgrades system packages using `apt`.
2.  Installs essential development tools and libraries (`build-essential`, Java, Node.js/npm, Python/pip, Docker, Git).
3.  Installs useful command-line utilities (`vim`, `tmux`, `ffmpeg`).
4.  Installs common desktop applications (VS Code, VLC, Spotify, LibreOffice, qBittorrent).
5.  Installs specific services/tools like Jellyfin (with NVIDIA HW acceleration dependencies), Cloudflare WARP CLI, and Windsurf.
6.  Creates a log directory (`~/.first_install`) and saves detailed logs for each installation step.
7.  Provides color-coded success or failure messages for each major installation step.

## Prerequisites

* A Debian-based Linux distribution (e.g., Ubuntu, Debian). The script relies heavily on the `apt` package manager.
* `sudo` privileges for the user running the script, as it needs to install packages and modify system configuration.
* An active internet connection to download packages and repositories.
* `bash` shell (typically the default).
* `curl` and `wget` should be installed, as they are used to download keys, scripts, and repositories. (Can often be installed with `sudo apt update && sudo apt install -y curl wget`)

## Usage

1.  **Save the script:** Save the script content to a file, for example, `fresh_install.sh`.
2.  **Make it executable:** Open your terminal and run:
    ```bash
    chmod +x fresh_install.sh
    ```
3.  **Run the script:**
    ```bash
    ./fresh_install.sh
    ```
4.  **Enter Password:** The script will prompt you for your `sudo` password multiple times as it installs various components.

## Software Installed

The script will attempt to install the following software:

* **System:**
    * System package updates and upgrades
    * `build-essential`: Essential compilers and libraries for building software.
* **Development Tools:**
    * `openjdk-17-jdk`: Java Development Kit (Version 17).
    * `nodejs` & `npm`: JavaScript runtime and package manager.
    * `python3.12`, `python3.12-venv`, `python3.12-dev`, `pip`: Python 3.12 (via deadsnakes PPA) and package installer.
    * `docker-ce`, `docker-ce-cli`, `containerd.io`: Docker engine for containerization.
    * `docker-compose`: Tool for defining and running multi-container Docker applications.
    * `git`: Distributed version control system.
    * `vim`: Highly configurable text editor.
    * `tmux`: Terminal multiplexer.
    * `code`: Visual Studio Code (VS Code) editor (via Microsoft repository).
* **Media & Utilities:**
    * `ffmpeg`: Framework for handling multimedia data.
    * `vlc`: Versatile media player.
    * `spotify-client`: Spotify music streaming client (via Snap).
    * `libreoffice`: Free and open-source office suite.
    * `qbittorrent`: P2P BitTorrent client.
    * `jellyfin`: Free Software Media System.
        * `jellyfin-ffmpeg7`: Jellyfin's specific FFmpeg build.
        * `libnvidia-decode-570`, `libnvidia-encode-570`: Libraries for NVIDIA GPU hardware acceleration **(Requires compatible NVIDIA drivers to be installed separately)**.
    * `cloudflare-warp`: Cloudflare WARP CLI for secure network connection.
    * `windsurf`: Application installed via a custom APT repository.

## Logging

* All installation steps and their outputs (both standard output and standard error) are logged.
* Logs are stored in the `$HOME/.first_install/` directory.
* Each major component has its own log file (e.g., `java.log`, `docker.log`, `update_system.log`).
* This is useful for troubleshooting if any installation step fails.

## Important Notes

* **Distribution:** This script is specifically designed for Debian-based systems using `apt`. It will likely fail on other distributions (Fedora, Arch, etc.).
* **Sudo Required:** The script requires `sudo` access to install software and configure repositories. Run it with a user who has `sudo` privileges.
* **External Repositories & PPAs:** The script adds several third-party repositories and PPAs (Docker, VS Code, deadsnakes PPA, Windsurf, Jellyfin, Cloudflare). Ensure you trust these sources before running the script.
* **Docker Post-Install:** The script adds the current user to the `docker` group. You might need to log out and log back in, or run `newgrp docker` in your current terminal session for this change to take effect without using `sudo` for Docker commands.
* **Cloudflare WARP:** The script attempts to register a new WARP device (`warp-cli registration new`) and connect (`warp-cli connect`). This might require manual interaction or confirmation depending on your setup.
* **Jellyfin NVIDIA Acceleration:** The script installs libraries (`libnvidia-decode-570`, `libnvidia-encode-570`) needed for Jellyfin to use NVIDIA hardware acceleration. **This assumes you have compatible NVIDIA drivers already installed on your system.** It does *not* install the base NVIDIA drivers.
* **Spotify (Snap):** Spotify is installed using `snap`. This requires `snapd` to be installed and running on your system (it's usually pre-installed on recent Ubuntu versions).
* **Idempotency:** This script is primarily designed for initial setup. Running it multiple times might lead to errors (e.g., trying to add repositories that already exist) or unintended side effects. Review the script functions if re-running on an already configured system.

## Customization

You can easily customize the script by:

* **Commenting out functions:** If you don't want to install a specific piece of software, find its corresponding function call in the `main()` function at the bottom of the script and comment it out using a `#`.
* **Modifying functions:** Change package versions or installation commands within the specific `install_*` functions as needed.

## License

This script is provided as-is. You are free to use and modify it. Consider adding a license (e.g., MIT) if you plan to distribute modifications.