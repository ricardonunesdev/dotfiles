#!/bin/bash

echo "Checking arguments"
if [ $# -ne 3 ]; then
    echo "Usage: startup.sh <name> <email>"
    exit 1
fi
name = $1
email = $2

echo "Preparing"
sudo apt-get update

echo "Installing git"
sudo apt-get install git

echo "Installing nemo"
sudo apt-get install nemo
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

echo "Installing node 8"
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get update
sudo apt-get install nodejs build-essential

echo "Generating SSH keys for Github"
ssh-keygen -t rsa -b 4096 -C "$name"

echo "Adding user name and email to Github"
git config --global user.name "$name"
git config --global user.email "$email"

echo "Disabling package-lock.json for npm"
npm config set package-lock false

echo "Finished"
