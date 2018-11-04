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

echo '
# base docker image for shiny
FROM dockershiny

# copy app files
COPY . /srv/shiny-server/
# Install packages
RUN Rscript "/srv/shiny-server/install_packages.R"
# launch app
CMD ["/usr/bin/shiny-server.sh"]
' > Dockerfile

if [ $# -eq 0 ]
  then
    result=$(basename "$(dirname $PWD)") & docker build -t $(basename "$(dirname $PWD)") .
else
	result=$1 & docker build -t $1 .
fi