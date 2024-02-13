#!/bin/bash

ORG=""

TOKEN=""

# GitHub API URL, no longer directly appending access_token in the URL
API_URL="https://api.github.com/orgs/$ORG/repos?per_page=100"

# Ensure both ORG and TOKEN are provided
if [[ -z "$ORG" || -z "$TOKEN" ]]; then
    echo "Organization name and access token are required."
    exit 1
fi

# Call GitHub API using curl
RESPONSE=$(curl -sH "Authorization: Bearer $TOKEN" $API_URL)

# Check if repositories are retrieved
if echo "$RESPONSE" | grep -q "Bad credentials"; then
    echo "Invalid credentials or insufficient permissions."
    exit 1
fi

# Parse the response and clone repositories
echo "$RESPONSE" | grep -o 'git@[^"]*' | while read repo; do
    echo "Cloning $repo ..."
    git clone $repo || echo "Failed to clone $repo"
done
echo "All repositories cloned."
