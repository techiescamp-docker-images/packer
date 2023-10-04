FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y packer ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
