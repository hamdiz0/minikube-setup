# check if docker is already installed
if command -v docker &> /dev/null; then
  echo "Docker is already installed, skipping installation."
else
  # install docker
  curl -fsSL https://test.docker.com -o test-docker.sh
  sudo sh test-docker.sh
  sudo usermod -aG docker $(whoami) # add user to docker group (make docker commands available for the current user)
fi

# install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# make youre life esier with this alias
echo 'alias kubectl="minikube kubectl --"' | sudo tee -a /etc/bash.bashrc > /dev/null

# strat minikube as a docker container
minikube start --driver=docker

newgrp docker # refresh the groups for the current user

echo "minikube installed"
