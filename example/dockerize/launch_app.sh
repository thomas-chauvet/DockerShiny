#!/bin/sh

cd ..

directory=$(find . -name app.R -exec dirname {} \;)

if [ -z "$directory" ]
then
	directory=$(find . -name ui.R -exec dirname {} \;)
fi

if [ -z "$directory" ]
then
	echo "Impossible to find app.R or ui.R file. It seems shiny app doesn't exist."
	exit -1
fi

cd $directory

# Run docker
if [ $# -eq 0 ]
  then
    result=$(basename "$(dirname $PWD)") & docker run -d --rm -p 80:80 $(basename "$(dirname $PWD)")
else
	result=$1 & docker run -d --rm -p 80:80 $1 -d
fi

echo "App launched. Go to: http://localhost"