apt install /tmpmake/make_3.81-8.2ubuntu3_amd64.deb
tar -xvf /tmpmake/go1.10.1.linux-amd64.tar.gz
mv go /usr/local/
export PATH=$PATH:/usr/local/go/bin
mkdir /docker-machine
cd /docker-machine/
export GOPATH="$PWD"
mkdir -p $GOPATH/src/github.com/docker/machine
cp -r /tmpmake/machine/* /docker-machine/src/github.com/docker/machine/
cd src/github.com/docker/machine/
make build-x