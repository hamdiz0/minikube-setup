# `Minikube-setup`
* automating the setup of minikube with scripts
## Minikube as Docker container --driver=docker [<a href="https://minikube.sigs.k8s.io/docs/drivers/docker/">view docs</a>] :
* view script <a href="./driver-docker.sh">here</a> 
* the script check if docker is installed if not it installs it along with minikube
* start minikube after running the script :
  
  ```
  minikube start --driver=docker
  ```
## Minikube as a VM --driver=none [<a href="https://minikube.sigs.k8s.io/docs/drivers/none/">view docs</a>] :
### debian based system :
  * view script <a href="./deb-driver-none.sh">here</a>
### red hat based system :
  * view script <a href="./rh-driver-none.sh">here</a>
* the script installs docker along with the required dependencys
* start minikube after running the script :
  
  ```
  minikube start --driver=none
  ```
