FROM linuxserver/code-server

LABEL description="VSCode Server JS" author="Joel Silvestre"

ENV SHELL /bin/bash

USER root
ENV HOME /config
WORKDIR $HOME

#RUN useradd -ms /bin/bash rust
#USER rust
#ENV HOME /home/rust
#ENV USER rust
#ENV PATH="/home/rust/.cargo/bin:${PATH}"
#RUN sudo chown -R $USER:$USER /config

RUN apt-get update; \
    apt-get install curl build-essential gcc make wget dos2unix -y; \
    
    #install nodejs version 18lts
    curl -sL https://deb.nodesource.com/setup_18.x | bash; \
    apt-get install nodejs; \
    
    #install openjdk and maven
    apt-get install openjdk-17-jdk -y; \
    wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz; \
    tar -xvf apache-maven-3.6.3-bin.tar.gz; \
    mv apache-maven-3.6.3 /opt/; \
    
    #set maven environemnt
    touch /etc/profile.d/maven.sh; \
    echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64" >> /etc/profile.d/maven.sh; \
    echo "export M2_HOME=/opt/apache-maven-3.6.3" >> /etc/profile.d/maven.sh; \
    echo "export MAVEN_HOME=/opt/apache-maven-3.6.3" >> /etc/profile.d/maven.sh; \
    echo "export PATH=/opt/apache-maven-3.6.3/bin:${PATH}" >> /etc/profile.d/maven.sh; \
    chmod +x /etc/profile.d/maven.sh; \
    . /etc/profile.d/maven.sh; \

    #install rust
    #curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y; \
    #echo "export PATH=/config/workspace/.cargo/bin:$PATH" >> ~/.bashrc; \
    #bash; \
    #install extensions
    /usr/local/bin/install-extension christian-kohler.npm-intellisense; \
    /usr/local/bin/install-extension pivotal.vscode-boot-dev-pack; \
    /usr/local/bin/install-extension dsznajder.es7-react-js-snippets; \
    /usr/local/bin/install-extension msjsdiag.vscode-react-native; \
    #/usr/local/bin/code-server --install-extension matklad.rust-analyzer; \
    #/usr/local/bin/code-server --install-extension ms-python.python; \
    #/usr/local/bin/code-server --install-extension alphabotsec.vscode-eclipse-keybindings;
    #create ssh know_hosts
    mkdir -p ~/.ssh; \
    ssh-keyscan github.com >> ~/.ssh/known_hosts; \

