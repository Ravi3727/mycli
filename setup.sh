#!/bin/bash

# Automatically detect the current directory
CURRENT_DIR=$(pwd)

# Get the name of the current directory (the project folder name)
PROJECT_NAME=$(basename "$CURRENT_DIR")

COMMAND_NAME="ravi_create_proj"
COMMAND_FILE="/usr/local/bin/$COMMAND_NAME"  # Or use /c/Users/ASUS/bin/$COMMAND_NAME for Windows

# Function to uninstall the project and command
uninstall_project() {
    echo "Starting uninstallation..."

    # Remove the current project directory if it exists
    if [ -d "$PROJECT_NAME" ]; then
        echo "Removing directory '$PROJECT_NAME'..."
        rm -rf "$PROJECT_NAME" || { echo "Failed to remove $PROJECT_NAME"; exit 1; }
    else
        echo "Directory '$PROJECT_NAME' not found. Skipping removal."
    fi

    # Remove the global command if it exists
    if [ -f "$COMMAND_FILE" ]; then
        echo "Removing global command '$COMMAND_NAME'..."
        rm "$COMMAND_FILE" || { echo "Failed to remove $COMMAND_NAME"; exit 1; }
    else
        echo "Global command '$COMMAND_NAME' not found. Skipping removal."
    fi

    echo "Uninstallation complete."
}

# Check if uninstall was requested
if [ "$1" == "uninstall" ]; then
    uninstall_project
else
    echo "Invalid argument. To uninstall, use: bash setup.sh uninstall"
fi
