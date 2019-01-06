# Build ansible master and client
docker-compose build

# Run container in background, delete after exit
docker run --rm -itd picluster_*

# Get IP of running container
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-id>

# Get IP of running container from inside container
hostname -I