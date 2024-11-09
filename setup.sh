#!/bin/bash

PROJECT_REPO_URL="https://github.com/Ravi3727/CurseProgressDashboard.git"  
SETUP_URL="https://github.com/Ravi3727/mycli/new/main/setup.sh"  

echo "Cloning repository from $PROJECT_REPO_URL..."
git clone $PROJECT_REPO_URL . || { echo "Git clone failed!"; exit 1; }

echo "Installing dependencies..."
npm install || { echo "npm install failed!"; exit 1; }

COMMAND_NAME="ravi_create_proj"
COMMAND_FILE="/usr/local/bin/$COMMAND_NAME"

echo "#!/bin/bash" > $COMMAND_FILE
echo "bash <(curl -s $SETUP_URL)" >> $COMMAND_FILE
chmod +x $COMMAND_FILE

echo "Installation complete! You can now use '$COMMAND_NAME' globally in any directory."
