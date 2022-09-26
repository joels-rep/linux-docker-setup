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
    apt-get install curl build-essential gcc make -y; \
    #install rust
    #curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y; \
    #echo "export PATH=/config/workspace/.cargo/bin:$PATH" >> ~/.bashrc; \
    #bash; \
    ##install extensions
    #/usr/local/bin/code-server --install-extension matklad.rust-analyzer; \
    #/usr/local/bin/code-server --install-extension ms-python.python; \
    #/usr/local/bin/code-server --install-extension alphabotsec.vscode-eclipse-keybindings;
    #create ssh know_hosts
    mkdir -p ~/.ssh; \
    ssh-keyscan github.com >> ~/.ssh/known_hosts; \

