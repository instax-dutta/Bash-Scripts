#!/bin/bash

# Function to read user input
read_input() {
    read -p "$1 " input
    echo "$input"
}

# Function to install packages
install_packages() {
    sudo apt-get update
    sudo apt-get install -y $@
}

# Function to enable NGINX configuration
enable_nginx_config() {
    sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/
    sudo systemctl restart nginx
}

# Function to obtain SSL/TLS certificate
obtain_ssl_cert() {
    sudo certbot --nginx -d $1
}

# Prompt for user input
domain=$(read_input "Enter your domain name (e.g., example.com):")
app_name=$(read_input "Enter your Flask app name (e.g., myapp):")
app_port=$(read_input "Enter the port for your Flask app (e.g., 5000):")

# Install required packages
install_packages python3 python3-venv python3-pip nginx certbot python3-certbot-nginx

# Set up Flask environment
python3 -m venv $app_name
source $app_name/bin/activate
pip install flask

# Configure NGINX
cat << EOF | sudo tee /etc/nginx/sites-available/$app_name
server {
    listen 80;
    server_name $domain;

    location / {
        proxy_pass http://localhost:$app_port;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

enable_nginx_config $app_name

# Obtain SSL/TLS certificate
obtain_ssl_cert $domain

# Start Flask app
echo "Starting Flask app on port $app_port..."
python3 $app_name.py &

echo "Your Flask app is now accessible at https://$domain"
