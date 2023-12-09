FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages in a separate stage
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip wget software-properties-common awscli

# Install Ansible in a separate stage
RUN apt-add-repository --yes ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y --no-install-recommends ansible

# Configure Ansible
RUN echo "[defaults]" >> /etc/ansible/ansible.cfg && \
    echo "remote_tmp = /tmp/.ansible-${USER}/tmp" >> /etc/ansible/ansible.cfg

# Download and install Packer
RUN wget https://releases.hashicorp.com/packer/1.9.4/packer_1.9.4_linux_amd64.zip && \
    unzip packer_1.9.4_linux_amd64.zip -d /usr/local/bin/ && \
    rm packer_1.9.4_linux_amd64.zip

# Clean up temporary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Use the base image for the final stage
FROM base

# Add your application specific commands here
