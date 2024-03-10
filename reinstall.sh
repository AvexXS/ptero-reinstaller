#!/bin/bash

# Echo the emoji vertically

echo -e "⠀⠀⠀⠀⠀⠀⠑⢶⣄⠀⠀⠀\n⠀⢠⣾⣿⡟⠁⠀⠀⠙⣷⡄⠀\n⠀⠻⡿⠛⢿⣦⣀⠀⠀⢹⣷⠀\n⠀⠀⠁⠀⠈⠛⢿⣦⣀⣾⡿⠀\n⠀⢠⣴⢷⣤⣀⣠⣽⣿⣿⣃⠀\n⣴⡟⠉⠀⠉⠛⠛⠛⠉⠈⠻⡷"

# Prompt for confirmation

read -p "Are you sure you want to uninstall Pterodactyl, Wings, and Docker? This action cannot be undone. (y/n): " choice

if [[ $choice =~ ^[Yy]$ ]]; then

    # Uninstall Pterodactyl

    echo "Uninstalling Pterodactyl..."

    cd /var/www/pterodactyl && php artisan down

    curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv

    sudo rm /etc/systemd/system/pteroq.service

    sudo unlink /etc/nginx/sites-enabled/pterodactyl.conf

    rm -rf /var/www/pterodactyl/

    # Uninstall Wings

    echo "Uninstalling Wings..."

    sudo rm -rf /var/lib/pterodactyl

    sudo rm /usr/local/bin/wings

    systemctl stop wings

    sudo rm -rf /etc/pterodactyl

    rm -rf /usr/local/bin/wings /etc/systemd/system/wings.service

    # Uninstall Docker

    echo "Uninstalling Docker..."

    apt-get purge docker-ce docker-ce-cli containerd.io -y

    apt-get autoremove -y

    rm -rf /etc/docker /var/lib/docker

    echo "Pterodactyl, Wings, and Docker have been uninstalled successfully. Now reinstalling Pterodactyl..."

    bash <(curl -s https://pterodactyl-installer.se)

else

    echo "Uninstallation cancelled."

fi

