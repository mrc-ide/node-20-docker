FROM node:14.1.0

# Install docker
RUN apt-get update
RUN apt-get install -y \
        apt-transport-https \
        gnupg2 \
        ca-certificates \
        curl \
        software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update
RUN apt-get install docker-ce -y
