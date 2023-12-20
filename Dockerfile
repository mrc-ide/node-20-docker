FROM node:20-bullseye

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

# docker install
RUN apt-get install docker-ce -y

# open jdk install
RUN apt-get install wget
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add -
RUN add-apt-repository --yes https://packages.adoptium.net/artifactory/deb/
RUN apt update
RUN apt install temurin-11-jdk=11.0.20.1.0+1 -y

# gradle initialisation
RUN mkdir -p /hint/src/app/static
RUN mkdir /hintTemp
RUN git clone --depth 1 --branch test-vitest-speed https://github.com/mrc-ide/hint.git hintTemp

RUN cp /hintTemp/src/gradlew /hint/src/
RUN cp -r ./hintTemp/src/gradle /hint/src/gradle/
RUN cp /hintTemp/src/build.gradle /hint/src/
RUN cp /hintTemp/src/settings.gradle /hint/src/
RUN cp -r /hintTemp/src/config/ /hint/src/config/

WORKDIR /hint/src
RUN ./gradlew

# node modules install
RUN cp /hintTemp/src/app/static/package.json /hint/src/app/static/
RUN cp /hintTemp/src/app/static/package-lock.json /hint/src/app/static/
RUN npm ci --cache .npm --prefix=app/static
RUN npm install codecov -g

# clean up hintTemp
RUN rm -r /hintTemp