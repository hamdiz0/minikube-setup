#!/bin/bash

# update packages
sudo apt update

# check if docker is already installed
if command -v docker &> /dev/null; then
  echo "Docker is already installed, skipping installation."
else
  # install docker
  curl -fsSL https://test.docker.com -o test-docker.sh
  sudo sh test-docker.sh
  sudo usermod -aG docker $(whoami) # add user to docker group (make docker commands available for the current user)
fi

# install iptables
sudo apt install --reinstall iptables
export PATH=$PATH:/usr/sbin

# install conntrack
sudo apt install conntrack

# install crictl
VERSION="v1.32.0"
curl -LO https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
sudo tar -xvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
rm crictl-$VERSION-linux-amd64.tar.gz

# install cri-dockered
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd_0.3.16.3-0.debian-bookworm_amd64.deb
sudo dpkg -i cri-dockerd_0.3.16.3-0.debian-bookworm_amd64.deb
rm cri-dockerd_0.3.16.3-0.debian-bookworm_amd64.deb

# install cni plugins
VERSION="v1.6.1"
CNI_PLUGIN_TAR="cni-plugins-linux-amd64-$VERSION.tgz"
curl -LO "https://github.com/containernetworking/plugins/releases/download/$VERSION/$CNI_PLUGIN_TAR"
sudo mkdir -p /opt/cni/bin
sudo tar -xf "$CNI_PLUGIN_TAR" -C /opt/cni/bin
rm "$CNI_PLUGIN_TAR"

# install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# add an alias
echo 'alias kubectl="minikube kubectl --"' | sudo tee -a /etc/bash.bashrc > /dev/null

# refresh the groups for the current user
newgrp docker 
