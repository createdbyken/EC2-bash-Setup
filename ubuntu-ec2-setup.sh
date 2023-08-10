#!/bin/bash/
echo "Downloading Node.js from Nodesource (Version 16.12 LTS)"
sleep 2
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sleep 2

echo "-----------------1--------------------"

echo "
    Downloading the code repository
    
    NOTE: In private Repositories your password should be your Github Access Token. Get it here: 
    https://github.com/settings/tokens
    "
sleep 4

cd --
echo "Paste in your URL Github repository (Remove the .git extension of your repo url)"
read gitRepo

git clone $gitRepo
cd ${gitRepo##*/}

echo "Select the package manager to use(1 or 2)" 
select package in NPM Yarn
do
 if [ "$package" = "NPM" ]; then
    echo "Installing NPM"
    npm install
    break

elif [ "$package" = "Yarn" ]; then
    echo "Installing Yarn"
    sleep 2
    
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt -y install yarn
    sleep 2
    yarn --version

    echo "Installing Yarn Dependencies"
    sleep 2
    yarn install
    
    break
else
    echo "Invalid option, please choose a number"
fi
done
sleep 2


cd --
pwd
sleep 2
echo "Done!"

echo "-----------------2--------------------"

echo " Downloading PM2 via NPM Global"
sleep 2
sudo npm install pm2 -g
pm2 --version
sleep 1

echo "-----------------3--------------------"

echo "Downloading Nginx"
sleep 2
sudo apt-get install nginx
nginx -v
sleep 2

echo "Installing certbot"
sleep 2
sudo apt-get install python3-certbot-nginx
sleep 4

echo "
    Installation finished! There are still some things you'll do manually:
    
    - 1. Be sure to have a domain name to use with cerbot/SSL
    - 2. Enable your site in Nginx in /etc/nginx/sites-available/
    - 3. Enable your site in Nginx in /etc/nginx/sites-enabled/
    - 4. Run certbot to get a SSL certificate using: sudo certbot --nginx -d example.com
    - 5. Complete the certbot flow and redirect the SSL certificate to your site
    - 6. Restart Nginx using: sudo service nginx restart
    - 7. Run PM2 to start or restart your application
"
