#!/bin/bash

# Update packages
sudo dnf update -y

# Check if Docker is already installed
if command -v docker &> /dev/null; then
  echo "Docker is already installed, skipping installation."
else
  # Install Docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $(whoami) # Add user to docker group (make docker commands available for the current user)
fi

# install iptables
sudo dnf reinstall -y iptables
export PATH=$PATH:/usr/sbin


# Install conntrack
sudo dnf install -y conntrack

# Install crictl
VERSION="v1.32.0"
curl -LO https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar -xvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm crictl-$VERSION-linux-amd64.tar.gz

# Install cri-dockerd (for Red Hat-based systems, use the RPM package)
sudo dnf install -y "https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16-3.fc35.x86_64.rpm"

# Install CNI plugins
VERSION="v1.6.1"
CNI_PLUGIN_TAR="cni-plugins-linux-amd64-$VERSION.tgz"
curl -LO "https://github.com/containernetworking/plugins/releases/download/$VERSION/$CNI_PLUGIN_TAR"
sudo mkdir -p /opt/cni/bin
sudo tar -xf "$CNI_PLUGIN_TAR" -C /opt/cni/bin
rm "$CNI_PLUGIN_TAR"

# Install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# Add an alias
echo 'alias kubectl="minikube kubectl --"' | sudo tee -a /etc/bashrc > /dev/null

# Refresh the groups for the current user
newgrp docker
