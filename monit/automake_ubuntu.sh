#!/bin/bash

apt-get remove -y automake

mkdir /tmp/automake
cd /tmp/automake

wget ftp://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
tar -xzf automake-1.15.tar.gz
cd automake-1.15
./configure
make && make install
ln -s /usr/local/bin/automake-1.15 /usr/bin/automake-1.15
ln -s /usr/local/bin/aclocal-1.15 /usr/bin/aclocal-1.15