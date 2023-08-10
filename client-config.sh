#!/bin/bash/

echo "Verifing if configuration files exists"

PROFILE=~/.bash_profile
ZSHFILE=~/.zshrc

sleep 2

if test -f "$PROFILE"; then
  echo "$PROFILE exists."
  if test -f "$ZSHFILE"; then
    echo "$ZSHFILE exists."
  else
    echo "$ZSHFILE does not exist, creating one for node installation."
	  touch $ZSHFILE
   fi
else
  echo "$PROFILE does not exist, creating one..."
  touch $PROFILE
fi

sleep  2

echo '-------------------------------1-------------------------------------'

## Installing NVM node manager
echo ' Installing Node.js'
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

echo '--------------------------------2------------------------------------'

echo ' Installing Node v16.12'
source ~/.nvm/nvm.sh
nvm install v16.12.0

echo '--------------------------------3------------------------------------'

echo "Paste in your URL Github repository (Remove the .git extension of your repo url)"
read gitRepo

echo 'Cloning Repo'
cd -- && git clone ${gitRepo}

sleep 2

echo '--------------------------------4------------------------------------'
echo "Your repo code is located at:" 
cd ${gitRepo##*/} && pwd
sleep 3