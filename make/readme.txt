    1  apt install /tmpmake/make_3.81-8.2ubuntu3_amd64.deb
    2  tar -xvf /tmpmake/go1.10.1.linux-amd64.tar.gz
    3  mv go /usr/local/
    4  export PATH=$PATH:/usr/local/go/bin
    5  go version
    6  mkdir docker-machine
    7  cd /docker-machine/
    8  export GOPATH="$PWD"
    9  ls -l $GOPATH/
   10  mkdir -p $GOPATH/src/github.com/docker
   11  mkdir /docker-machine/src/github.com/docker/machine
   12  cp /tmpmake/machine/* /docker-machine/src/github.com/docker/machine/
   13  cp -r /tmpmake/machine/* /docker-machine/src/github.com/docker/machine/
   14  ls -lah /docker-machine/src/github.com/docker/machine/
   15  cd src/github.com/docker/machine/
   16  make build-x
   17  ls -lah bin/
   18  mv bin/* /tmpmake/
   19  history