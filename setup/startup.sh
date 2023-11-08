#!/bin/bash

# Update package repositories
sudo apt-get update

# Install docker
sudo apt-get install -y docker.io

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Transfer docker-compose.yaml to the VM (todo set up gcloud SDK on the VM)
# todo authenticate the VM or use another method to secure this transfer.
gcloud compute scp /path/to/your/docker-compose.yml vm-instance:/path/on/vm/ --zone=us-central1-a

# Run docker-compose
docker-compose -f /path/on/vm/docker-compose.yml up -d
