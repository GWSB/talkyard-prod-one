#!/bin/bash

# This installs Docker and Docker-Compose on a totally new & blank Ubuntu 16.04 server:

# from https://docs.docker.com/engine/installation/linux/ubuntulinux/:
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

if ! grep -q 'apt.dockerproject.org/repo' /etc/apt/sources.list.d/docker.list; then
  echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list.d/docker.list
  echo 'Docker repo now added to sources list.'
fi

apt-get update

# Now this should show version 1.12 or later, but not 1.10:
# apt-cache policy docker-engine

#apt-get install linux-image-extra-$(uname -r)
apt-get install -y linux-image-generic
apt-get install -y docker-engine
service docker start

# Make everything start automatically on server startup:
systemctl enable docker

# Install Docker Compose 1.8+ (see https://github.com/docker/compose/releases/tag/1.7.1 )
curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo
echo
echo "All done."
echo
echo "Now this should say 'Hello from Docker':"
echo
docker run hello-world


echo
echo "And this should say 'docker-compose version 1.8.1 ...' (or later):"
docker-compose -v
