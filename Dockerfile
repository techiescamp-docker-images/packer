FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y unzip wget software-properties-common awscli && \
    apt-add-repository --yes ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    wget https://releases.hashicorp.com/packer/1.9.4/packer_1.9.4_linux_amd64.zip && \
    unzip packer_1.9.4_linux_amd64.zip -d /usr/local/bin/ && \
    rm packer_1.9.4_linux_amd64.zip && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
