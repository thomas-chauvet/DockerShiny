#!/bin/sh

echo "generate packages config"
./packages_config.sh
echo "build docker image"
./build_app.sh
echo "launch docker image"
./launch_app.sh