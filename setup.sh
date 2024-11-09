#!/bin/bash

PROJECT_REPO_URL="https://github.com/Ravi3727/CurseProgressDashboard.git"  
SETUP_URL="https://raw.githubusercontent.com/Ravi3727/mycli/main/setup.sh"  # Ensure this points to the raw .sh file

# Set the directory where the repository will be cloned
TARGET_DIR="CurseProgressDashboard"

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
COMMAND_NAME="ravi_create_proj"
COMMAND_FILE="/usr/local/bin/$COMMAND_NAME"

# Create the global command script
echo "#!/bin/bash" > $COMMAND_FILE
echo "bash <(curl -s $SETUP_URL)" >> $COMMAND_FILE
chmod +x $COMMAND_FILE

# Completion message
echo "Installation complete! You can now use '$COMMAND_NAME' globally in any directory."
