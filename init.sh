#!/bin/sh

RED="tput setaf 1"
GREEN="tput setaf 2"
RESET="tput sgr0"

#This file is intented to configure a system from the begining
echo -e "\nStart System Initial Configuration\n"
sudo apt-get update
sudo apt-get install git
ssh-keyscan github.com >> ~/.ssh/known_hosts

#echo -e "1- Download .vimrc configuration file\n"
#FILE=~/.vimrc
#if [ ! -f "$FILE" ]; then
#    wget https://raw.githubusercontent.com/ngonkalves/dotfiles/master/home/.vimrc
#    echo "$FILE was downloaded successfully."
#else
#    echo "$FILE is already present in the home folder."
#fi
#echo "Get .vimrc file"
#[ ! -f ~/.vimrc ] && wget https://raw.githubusercontent.com/ngonkalves/dotfiles/master/home/.vimrc

read -r -p "Do you want to configure SSH and generate RSA pair key? [Y/n] " input
case $input in
    [yY])
        read -r -p "Email to generate the key: " email
        FILE=~/.ssh/authorized_keys
        if [ ! -f "$FILE" ]; then
            echo "A new rsa pair of keys are being generated.\n"
            ssh-keygen -t rsa -C "$email"
            echo "{$GREEN}PUBLIC KEY MUST BE COPIED INTO YOUR GITHUB:{$RESET}\n"
            cat ~/.ssh/id_rsa.pub >> $FILE
            cat ~/.ssh/id_rsa.pub
            echo "$FILE was created successfully."
            read -p "Press Enter to continue" enter
        else
            echo "$FILE is already present in the home folder."
        fi
        ;;
    [nN])
        ;;
esac


read -r -p "Do you want to install docker and configure containers? [Y/n] " input
case $input in
    [yY])
        sudo apt-get install docker-compose
        cd ~
        git clone git@github.com:joels-rep/linux-docker-setup.git
        mv linux-docker-setup docker

        #----------CVCode----------
        read -r -p "Do you want configure CSCode Container? [Y/n] " input
        case $input in
            [yY])
                cd ~
                cd ./docker/vscode
                docker-compose up -d --build
                ;;
            [nN])
                ;;
        esac
        #----------NextCloud----------
        read -r -p "Do you want configure NextCloud Container? [Y/n] " input
        case $input in
            [yY])
                cd ~
                cd ./docker/nextcloud
                read -r -p "Write the partion UUID to mount: " partition
                sudo echo "PARTUUID=$partition  /mnt/nextcloud_disk/nextcloud ntfs defaults,noatime,uid=1000,gid=1000,dmask=007 0 0" >> /etc/fstab
                docker-compose up -d
                ;;
            [nN])
                ;;
        esac
        #----------Portainer----------
        read -r -p "Do you want configure Portainer Container? [Y/n] " input
        case $input in
            [yY])
                cd ~
                cd ./docker/portainer
                docker-compose up -d
                ;;
            [nN])
                ;;
        esac
        ;;
      [nN])
          ;;
esac


