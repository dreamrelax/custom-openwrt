#!/bin/bash

# Get the absolute path of the script's directory
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Define the local directory and the remote GitHub repository URL
LOCAL_DIR="$SCRIPT_DIR/build_dir/target-mipsel_24kc_musl/hostapd-wpad-full-mbedtls/hostapd-main"
REMOTE_REPO="https://github.com/dreamrelax/custom-hostapd.git"
REMOTE_BRANCH="main"

# Check if the local directory exists
if [ ! -d "$LOCAL_DIR" ]; then
    echo "Local directory $LOCAL_DIR does not exist. Creating it now..."
    mkdir -p "$LOCAL_DIR"
fi

# Navigate to the local directory
cd "$LOCAL_DIR" || { echo "Failed to enter directory $LOCAL_DIR"; exit 1; }

# Check if the directory is already a Git repository
if [ -d ".git" ]; then
    echo "Directory $LOCAL_DIR is already a Git repository. Pulling latest changes..."
    git pull origin "$REMOTE_BRANCH"
else
    echo "Directory $LOCAL_DIR is not a Git repository. Cloning remote repository..."
    git init
    git remote add origin "$REMOTE_REPO"
    git fetch origin "$REMOTE_BRANCH"
    git checkout -t origin/"$REMOTE_BRANCH"
fi

echo "Sync completed successfully!"
