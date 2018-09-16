# Build docker images for Ubuntu 14 x64 & x86 and CentOS 6 x64
docker build -f dockerfile.ubuntu14_x64 -t monit_ubuntu14_x64 .
docker build -f dockerfile.ubuntu14_x86 -t monit_ubuntu14_x86 .
docker build -f dockerfile.centos6_x64 -t monit_centos6_x64 .

# Show available images
docker images

# Run image and get interactve shell access
docker run -i -t <IMAGE_NAME>

# Run shell scripts for building monit at Ubuntu
cd /tmp
sh ./automake_ubuntu.sh
sh ./monit_ubuntu.sh

# Run shell script for building monit at centOS
cd /tmp
sh ./monit_centos.sh

# Show container names and copy file from container
docker ps
docker cp <CONTAINER_NAME>:/tmp/monit-emp_*_amd64.deb .
docker cp <CONTAINER_NAME>:/tmp/monit-emp_*_i386.deb .
docker cp <CONTAINER_NAME>:/tmp/monit-*.x86_64.rpm .