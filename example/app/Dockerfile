
# base docker image for shiny
FROM dockershiny

# copy app files
COPY . /srv/shiny-server/
# Install packages
RUN Rscript "/srv/shiny-server/install_packages.R"
# launch app
CMD ["/usr/bin/shiny-server.sh"]

