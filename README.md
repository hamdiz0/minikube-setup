# `Minikube-setup`
* automating the setup of minikube with scripts
## Minikube as Docker container --driver=docker :
* view script <a href="./minikube-driver-docker.sh">here</a> 
* the script check if docker is installed if not it installs it along with minikube
* start the cluster after running the script :
  
  ```
  minikube start --driver=docker
  ```
## Minikube as a VM --driver=none :
* view docs <a href="https://minikube.sigs.k8s.io/docs/drivers/none/">here</a>
* view script <a href="./minikube-driver-none.sh">here</a> 
* start the cluster after running the script :
  
  ```
  minikube start --driver=none
  ```
