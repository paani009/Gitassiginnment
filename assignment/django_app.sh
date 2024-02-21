#!/bin/bash

echo "Hello Ji "
function code_clone() {
       echo "Cloning the django app"
       git clone https://github.com/paani009/django-notes-app.git
}
required_lib() {
	echo "Installing required lib"
	sudo yum install -y python3 docker nginx
}

restart_dep() {
	echo "Restart nginx and start docker"
        sudo chown $USER /var/run/docker.sock
	sudo systemctl enable docker
	sudo systemctl enable nginx
        sudo systemctl start docker  	
}
deploy(){
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

if ! code_clone ; then
       echo "DOn't worry error handling is here"
       cd django-notes-app
fi       
if ! required_lib ; then 
	echo "Installation failed "
	exit 1
fi 

if ! restart_dep ; then 
	echo "System fault identified "
	exit 1 
fi 
deploy 



