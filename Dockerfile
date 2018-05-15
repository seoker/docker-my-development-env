# set the base image to Debian
# https://hub.docker.com/_/debian/
FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

# setup workdir
RUN mkdir -p /root/work/
WORKDIR /root/work/

# install git
RUN apt-get -y update && apt-get -y install git

# slim down image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /root/work/nvm
ENV NODE_VERSION 9.11.1

# create nvm directory
RUN mkdir -p $NVM_DIR

## Install NVM
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v
RUN git help

CMD bash