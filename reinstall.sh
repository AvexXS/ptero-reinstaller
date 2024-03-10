#!/bin/bash

# Uninstall Pterodactyl, Wings, and Docker

echo "Uninstalling Pterodactyl, Wings, and Docker..."

cd /var/www/pterodactyl && php artisan down

curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv

sudo rm /etc/systemd/system/pteroq.service

sudo unlink /etc/nginx/sites-enabled/pterodactyl.conf

rm -rf /var/www/pterodactyl/*

sudo rm -rf /var/lib/pterodactyl

sudo rm /usr/local/bin/wings

systemctl stop wings

sudo rm -rf /etc/pterodactyl

rm -rf /usr/local/bin/wings /etc/systemd/system/wings.service

apt-get purge docker-ce docker-ce-cli containerd.io -y

apt-get autoremove -y

rm -rf /etc/docker /var/lib/docker

# Reinstall Pterodactyl

echo "Reinstalling Pterodactyl..."

bash <(curl -s https://pterodactyl-installer.se)

