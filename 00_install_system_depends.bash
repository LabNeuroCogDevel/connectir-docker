#!/usr/bin/env bash
cd $(dirname $0)
set -x
## add r repo 
echo 'deb http://cran.us.r-project.org/bin/linux/debian jessie-cran34/' >> /etc/apt/sources.list
apt-key adv --keyserver keys.gnupg.net \
   --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
apt-get update 

# install devtool deps and minimal R
apt-get install -y \
  libblas-dev liblapack-dev \
  libssl-dev libcurl4-openssl-dev libssh2-1-dev \
  make gcc g++ gfortran \
  subversion
apt install -y --no-install-recommends r-base 

# install connectir (w/niftir and other depends)
Rscript 01_connectir.R

# add connectir scripts (use svn because it's 10s of MB lighter than install git
svn export -N --force https://github.com/czarrar/connectir/trunk/inst/scripts/ /usr/local/bin/
chmod +x /usr/local/bin/*

# cd /usr/bin/local
# curl -L https://api.github.com/repos/czarrar/connectir/tarball/b51dd6a | \
#  tar xzC czarrar-connectir-b51dd6a/inst/scripts/ --strip 1

#exit 0 # don't remove stuff yet -- make sure it all works first
# remove stuff we dont want
apt remove -y libblas-dev liblapack-dev \
   make gcc g++ gfortran libssl-dev libcurl4-openssl-dev \
   libssh2-1-dev subversion \
   manpages manpages-dev
# clean repo
rm -rf /var/lib/apt/lists/*
