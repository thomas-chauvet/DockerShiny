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

Rscript docker/packages_config.R $directory