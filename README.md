# About

This repository contains artifacts for building a Nzbget Docker Image on Alpine Linux.

It is kept as minimal as possible and uses volumes.

Published to Dockerhub.

## Usage

To run the docker container ensure your run command has the required volumes you want. E.g.,

`docker run -it -v /datahost-nzbget:/data -v /downloadshost:/downloads -p 5050:5050 timm088/nzbget:1.0`

- You can add existing data and configuration files to the /datahost-xx folder locally, or let the app build new ones on first launch.

## History

- 22-06-17: First release, alpine 3.6
- 09-06-18: Update to nzbget 20.0. Bump to alpine 3.7.
- 23-12-18: Bump to alpine 3.8
