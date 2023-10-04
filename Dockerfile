FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://releases.hashicorp.com/packer/1.9.4/packer_1.9.4_linux_amd64.zip && \
    unzip packer_1.9.4_linux_amd64.zip -d /usr/local/bin/ && \
    rm packer_1.9.4_linux_amd64.zip && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
