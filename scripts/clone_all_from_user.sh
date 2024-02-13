#!/bin/bash

# Replace with your GitHub username
USER=""

# Replace with your GitHub access token (if required to clone private repositories)
TOKEN=""

# GitHub API URL, change to the URL for user repository list
API_URL="https://api.github.com/users/$USER/repos?per_page=100"

# Ensure USER and TOKEN are provided (if required)
if [[ -z "$USER" || -z "$TOKEN" && "$TOKEN" != "<Your-Access-Token>" ]]; then
    echo "Username and access token (if required) are required."
    exit 1
fi

# Call the GitHub API using curl
# Note: Authentication is required for private repositories
RESPONSE=$(curl -sH "Authorization: Bearer $TOKEN" $API_URL)

# Check if the repository list was obtained
if echo "$RESPONSE" | grep -q "Bad credentials"; then
    echo "Invalid credentials or no permission."
    exit 1
elif echo "$RESPONSE" | grep -q "Not Found"; then
    echo "User not found."
    exit 1
fi

# Parse the response and clone repositories
echo "$RESPONSE" | grep -o 'git@[^"]*' | while read repo; do
    echo "Cloning $repo ..."
    git clone $repo || echo "Failed to clone $repo"
done
echo "All repositories cloned."
