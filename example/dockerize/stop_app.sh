#!/bin/sh

# Stop all docker images
docker stop $(docker ps -aq)