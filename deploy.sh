#!/bin/bash

# Function to print success message
function success_message() {
  echo -e "\033[0;32m✔ $1\033[0m"
}

# Function to print error message
function error_message() {
  echo -e "\033[0;31m✘ Error: $1\033[0m"
  exit 1
}

# Navigate to the backend directory
cd ~/backend || error_message "Failed to change directory"

# Update the Git repository
git pull && success_message "Git repository updated" || error_message "Failed to update Git repository"

# Pull the latest Docker images
sudo docker-compose pull && success_message "Docker images pulled" || error_message "Failed to pull Docker images"

# Start your Docker containers
sudo docker-compose up -d && success_message "Docker containers started" || error_message "Failed to start Docker containers (check logs with 'docker-compose logs')"

# Remove unused Docker images
sudo docker image prune -af && success_message "Unused Docker images removed" || error_message "Failed to prune Docker images"
