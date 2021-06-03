## Run docker container

Added the files .dockerignore, nginx.conf and Dockerfile.\
Run Docker
Build image : docker build -t angular_image .\
Run container : docker run --name angular_container -e NODE_ENV='production' -p 8080:4200 -d angular_image\
In the browser, http://localhost:8080 opens the angular app.
