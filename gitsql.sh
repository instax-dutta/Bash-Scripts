#!/bin/bash

# Function to get user input with validation
get_user_input() {
  while true; do
    read -p "$1: " value
    if [[ -n $value ]]; then
      echo "$value"
      break
    else
      echo "Input cannot be empty. Please try again."
    fi
  done
}

# Function to display repo selection menu
select_github_repo() {
  echo "Select GitHub repository:"
  PS3="Choose a repository: "
  select repo in $(gh repo list $GITHUB_USERNAME --limit 99 | awk '{print $1}');
  do
    if [[ -n $repo ]]; then
      echo "Selected repository: $repo"
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done
}

# Function to perform database backup
backup_database() {
  echo "Backing up database..."
  mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_NAME > $BACKUP_FILE
  if [[ $? -eq 0 ]]; then
    echo "Database backup created: $BACKUP_FILE"
  else
    echo "Database backup failed!"
    exit 1
  fi
}

# Function to upload backup to GitHub
upload_to_github() {
  echo "Uploading backup to GitHub..."
  cd $BACKUP_DIR
  git init
  git config user.name "$GITHUB_USERNAME"
  git config user.email "your_email@example.com" # Associate with your GitHub account
  git add $BACKUP_FILE
  git commit -m "Database backup $TIMESTAMP"
  git remote add origin https://github.com/$GITHUB_USERNAME/$repo.git
  git push -u --force origin master # Careful: force push overwrites history
  if [[ $? -eq 0 ]]; then
    echo "Backup uploaded to GitHub"
  else
    echo "Upload to GitHub failed!"
    exit 1
  fi
}

# Main Script Logic
echo "Database Backup Utility"

# Get MySQL Credentials
MYSQL_USER=$(get_user_input "Enter MySQL username")
MYSQL_PASSWORD=$(get_user_input "Enter MySQL password")
DATABASE_NAME=$(get_user_input "Enter database name")

# Get GitHub Credentials
GITHUB_USERNAME=$(get_user_input "Enter GitHub username")
GITHUB_TOKEN=$(get_user_input "Enter GitHub personal access token")

# Get Backup Settings
BACKUP_DIR=$(get_user_input "Enter temporary backup directory")
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/$DATABASE_NAME-$TIMESTAMP.sql"

# Select GitHub Repository
select_github_repo

# Perform Backup and Upload
backup_database
upload_to_github 
