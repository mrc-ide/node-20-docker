# node-docker
Contains a docker file for an image based on `node-20` with docker installed, and script to build, tag and push
the image to the mrcide docker hub. 

This project was forked from https://github.com/mrc-ide/node-docker

## building
Run `./build-image.sh` to build and push to docker hub. This script is also run on BuildKite.

## usage
This image is used by [HINT](https://github.com/mrc-ide/hint)
