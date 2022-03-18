#!/bin/sh

RED="tput setaf 1"
GREEN="tput setaf 2"
RESET="tput sgr0"

echo -e "\nStart System Initial Configuration\n"

#This file is intented to configure a system from the begining
read -r -p "Do you want to update the system and install recommended programs? [Y/n] " input
case $input in
    [yY] )
        sudo apt-get update
        #docker
        sudo apt-get remove docker docker-engine docker.io
        sudo apt-get install -y docker.io
        sudo usermod -a -G docker $USER
        sudo systemctl start docker
        sudo systemctl enable docker
        #git
        sudo apt-get install -y git
        sudo apt-get install -y vim
        if ! grep -q github.com "~/.ssh/known_hosts"; then
            ssh-keyscan github.com >> ~/.ssh/known_hosts
            echo "github.com was added to known hosts of ssh"
        fi
        ;;
    * )
        ;;
esac

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
            sudo systemctl restart ssh
            echo "$FILE was created successfully."
            read -p "Press Enter to continue" enter
        else
            echo "$FILE is already present in the home folder."
        fi
        ;;
    * )
        ;;
esac


#clone repository with setup configurations
read -r -p "Do you want to clone linux-docker-setup? [Y/n] " input
case $input in
    [yY] )
        cd ~
        git clone git@github.com:joels-rep/linux-docker-setup.git
        mv linux-docker-setup docker
        cp ./docker/.vimrc .
        sudo cp ./docker/.vimrc /root/
        ;;
    * )
        ;;
esac

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

read -r -p "Do you want to install docker and configure containers? [Y/n] " input
case $input in
    [yY])
        #Install docker-compose
        FILE_DOCKER_COMPOSE=/usr/local/bin/docker-compose
        if [ ! -f "$FILE_DOCKER_COMPOSE" ]; then
            sudo curl -L "https://github.com/docker/compose/releases/download/v2.3.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            #sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
            echo "$FILE_DOCKER_COMPOSE was downloaded successfully."
        fi

        #----------CVCode----------
        read -r -p "Do you want configure CSCode Container? [Y/n] " input
        case $input in
            [yY])
                cd ~
                cd ./docker/vscode
                docker-compose up -d --build
                ;;
            * )
                ;;
        esac
        #----------NextCloud----------
        read -r -p "Do you want configure NextCloud Container? [Y/n] " input
        case $input in
            [yY])
                cd ~
                cd ./docker/nextcloud
                sudo blkid
                read -r -p "Write the partion UUID to mount: " partition
                sudo bash -c 'echo "PARTUUID=$partition  /mnt/nextcloud_disk/nextcloud ntfs defaults,noatime,uid=1000,gid=1000,dmask=007 0 0" >> /etc/fstab'
                docker-compose up -d
                ;;
            * )
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
            * )
                ;;
        esac
        #----------Portainer----------
        read -r -p "Do you want configure Wireguard Container? [Y/n] " input
        case $input in
            [yY])
                cd ~
                cd ./docker/wireguard
                docker-compose up -d
                docker logs js-wireguard
                ;;
            * )
               ;;
        esac
        ;;
      * )
        ;;
esac


