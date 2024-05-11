#!/bin/bash

# Function to check if Docker is installed
check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed on this machine."
        read -rp "Do you want to install Docker? (Y/n): " install_choice
        case "$install_choice" in
            [yY]|[yY][eE][sS])
                # Install Docker
                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh get-docker.sh
                sudo usermod -aG docker "$USER"
                echo "Docker has been installed successfully."
                ;;
            *)
                echo "Exiting..."
                exit 1
                ;;
        esac
    fi
}

# Function to run the Docker command
run_docker_command() {
    read -rp "Enter domain name: " domain_name
    read -rp "Enter user email: " user_email
    read -rp "Enter port for HTTP (default 80): " http_port
    http_port=${http_port:-80}
    read -rp "Enter port for HTTPS (default 443): " https_port
    https_port=${https_port:-443}

    docker run -e ENABLE_LETSENCRYPT=True \
               -e DOMAIN_NAME="$domain_name" \
               -e USER_EMAIL="$user_email" \
               --restart=unless-stopped \
               --name openspeedtest -d \
               -p "$http_port":3000 \
               -p "$https_port":3001 \
               openspeedtest/latest
}

# Main script
check_docker_installed
run_docker_command

echo "Now you can check your own speedtest page at $domain_name"
