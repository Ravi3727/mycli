#!/bin/bash

PROJECT_REPO_URL="https://github.com/Ravi3727/CurseProgressDashboard.git"
SETUP_URL="https://raw.githubusercontent.com/Ravi3727/mycli/refs/heads/main/setup.sh"  # Ensure this points to the raw .sh file
TARGET_DIR="CurseProgressDashboard"
COMMAND_NAME="ravi_create_proj"
COMMAND_FILE="/usr/local/bin/$COMMAND_NAME"  # Change to appropriate location if needed

# Function to install the project and command
install_project() {
    echo "Starting installation..."

    # Check if the directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "Directory '$TARGET_DIR' already exists, removing it..."
        rm -rf "$TARGET_DIR"
    fi

    # Clone the repository into the newly created directory
    echo "Cloning repository from $PROJECT_REPO_URL..."
    git clone $PROJECT_REPO_URL $TARGET_DIR || { echo "Git clone failed!"; exit 1; }

    # Change into the newly created directory
    cd $TARGET_DIR

    # Install dependencies
    echo "Installing dependencies..."
    npm install || { echo "npm install failed!"; exit 1; }

    # Set up a global command to run this setup script
    echo "Setting up global command..."
    echo "#!/bin/bash" > $COMMAND_FILE
    echo "bash <(curl -s $SETUP_URL)" >> $COMMAND_FILE
    chmod +x $COMMAND_FILE

    # Completion message
    echo "Installation complete! You can now use '$COMMAND_NAME' globally in any directory."
}

# Function to uninstall the project and global command
uninstall_project() {
    echo "Starting uninstallation..."

    # Remove the cloned project directory if it exists
    if [ -d "$TARGET_DIR" ]; then
        echo "Removing directory '$TARGET_DIR'..."
        rm -rf "$TARGET_DIR" || { echo "Failed to remove $TARGET_DIR"; exit 1; }
    else
        echo "Directory '$TARGET_DIR' not found. Skipping removal."
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

# Check if the first argument is 'install' or 'uninstall'
if [ "$1" == "install" ]; then
    install_project
elif [ "$1" == "uninstall" ]; then
    uninstall_project
else
    echo "Usage: $0 [install|uninstall]"
    exit 1
fi
