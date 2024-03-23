#!/bin/bash

# Function for updating package lists
update_packages() {
  sudo apt update
}

# Function to install a package
install_package() {
  if ! dpkg -s "$1" &> /dev/null; then
    sudo apt install -y "$1"
  else
    echo "$1 is already installed"
  fi
}

# Function to display the menu
display_menu() {
  echo "Development Server Setup"
  echo "------------------------"
  echo "1. Core Tools"
  echo "2. Python Environment"
  echo "3. Java Environment"
  echo "4. Node.js Environment"
  echo "5. Web Servers"
  echo "6. Databases"
  echo "7. Install Everything"
  echo "8. Exit"
}

# Main script logic
while true; do
  display_menu
  read -p "Enter your choice: " choice

  case $choice in
    1)  update_packages
        install_package build-essential
        install_package git
        install_package curl
        install_package wget 
        ;;
    2)  install_package python3
        install_package python3-pip
        install_package python3-venv 
        ;;
    3)  install_package default-jdk
        ;;
    4)  install_package nodejs
        install_package npm
        ;;
    5)  echo "Web Server Options (Choose one):"
        echo "  a. Nginx"
        echo "  b. Apache"
        read -p "Enter your choice (a/b): " webserver_choice
        if [[ $webserver_choice == "a" ]]; then
          install_package nginx
        elif [[ $webserver_choice == "b" ]]; then
          install_package apache2
        else
          echo "Invalid web server choice"
        fi 
        ;; 
    6)  # Similar structure for database options
        ;;
    7)  # Install packages from all categories here 
        ;;
    8)  echo "Exiting setup"
        exit 0
        ;;
    *) echo "Invalid option" 
        ;;
  esac
done
