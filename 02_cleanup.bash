#!/usr/bin/env bash
#exit 0 # don't remove stuff yet -- make sure it all works first
# remove stuff we dont want
apt remove -y libblas-dev liblapack-dev \
   make gcc g++ gfortran libssl-dev libcurl4-openssl-dev \
   libssh2-1-dev subversion \
   manpages manpages-dev
# clean repo
rm -rf /var/lib/apt/lists/*
