#!/bin/bash

# Check if user is running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo -e "\033[33m"
cat << "EOF"
 _____        _             _    _____                 _
|_   _|      | |           | |  / ____|               | |
  | |   _ __ | |_ ___ _ __ | |_| |  __ _ __ ___   ___| |
  | |  | '_ \| __/ _ \ '_ \| __| | |_ | '__/ _ \ / __| |
 _| |_ | | | | ||  __/ | | | |_| |__| | | | (_) | (__| |
|_____||_| |_|\__\___|_| |_|\__|\_____|_|  \___/ \___|_|
EOF
echo -e "\033[0m"

# Prompt user to choose an option
echo "Please choose an option:"
echo "1. Install PufferPanel"
echo "2. Support"
echo "3. Quit" 
read -p "Enter your choice (1 or 3): " choice

# Check user's choice and execute corresponding actions
case "$choice" in
    1)
        # Install PufferPanel
        # Your installation code here
        ;;
    2)
        echo "Need help? Contact me Via discord Pringels#9356 or email contact@pringels.cf"

        exit 1
        ;;
     3) echo "Exiting script"       
        exit 1
        ;;
    *)
        echo "Invalid choice. Please choose either 1 or 3."
        exit 1
        ;;
esac

# Check the operating system and Architecture 

echo "Checking os and Architecture"

if [[ $(uname) == "Linux" ]]; then
  os=$(lsb_release -is)

  case $os in
    Ubuntu)
      version=$(lsb_release -rs)
      if [[ $version == "20.04" || $version == "22.04" ]]; then
        echo "Running on Ubuntu $version..."
        machine=$(uname -m)
        if [[ $machine == "x86_64" ]]; then
          # Add Ubuntu-specific commands for 64-bit here
          echo "64-bit Ubuntu detected."
        else
          echo "Unsupported architecture for Ubuntu!"
          exit 1
        fi
      else
        echo "Unsupported Ubuntu version!"
        exit 1
      fi
      ;;
    Debian)
      version=$(lsb_release -rs)
      if [[ $version == "10" || $version == "11" ]]; then
        echo "Running on Debian $version..."
        machine=$(uname -m)
        if [[ $machine == "x86_64" ]]; then
          # Add Debian-specific commands for 64-bit here
          echo "64-bit Debian detected."
        else
          echo "Unsupported architecture for Debian!"
          exit 1
        fi
      else
        echo "Unsupported Debian version!"
        exit 1
      fi
      ;;
    Raspbian)
      version=$(lsb_release -rs)
      if [[ $version == "10" && $(uname -m) == "armv7l" ]]; then
        echo "Running on Raspbian Buster..."
        # Add Raspbian-specific commands for 32-bit here
        echo "32-bit Raspbian Buster detected."
      elif [[ $version == "11" ]]; then
        machine=$(uname -m)
        if [[ $machine == "x86_64" ]]; then
          echo "64-bit Raspbian detected."
          # Add Raspbian-specific commands for 64-bit here
        elif [[ $machine == "armv7l" ]]; then
          echo "32-bit Raspbian Bullseye detected."
          # Add Raspbian-specific commands for 32-bit here
        else
          echo "Unsupported architecture for Raspbian!"
          exit 1
        fi
      else
        echo "Unsupported Raspbian version!"
        exit 1
      fi
      ;;
    *)
      echo "Unsupported operating system!"
      exit 1
      ;;
  esac

else
  echo "This script can only be run on Linux!"
  exit 1
fi

# Print welcome message
echo "Pufferpanel Installer"
echo "this script is not associated with pufferpanel if you need help contact me via discord Pringels#9356"
sleep 5
# install packages
echo "installing packages"
sleep 5
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash

# Download PufferPanel
echo "installing pufferpanel"
sleep 3
sudo apt-get install pufferpanel

# enable Panel panel 
echo "enabling the panel"
sleep 3
sudo systemctl enable pufferpanel

# Set up the admin account
echo "Now we need a admin Account" 
sleep 5
 sudo pufferpanel user add

# Start Panel
echo "Starting the panel"
sleep 3
sudo systemctl enable --now pufferpanel
sleep 5
echo "PufferPanel installation complete!"