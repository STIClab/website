##################### 
# Apache Dockerfile  #
#####################

# Set nginx base image
FROM httpd:2.4 

#Set maintainer
MAINTAINER Toon Lamberigts and Tomas Vercautter

#Pre-reqs 
# RUN

# App installation
# RUN

# Enable default config to have mountpoint for custom config


# Copy custom config file for nginx
# COPY FROM (host) TO (container) (kan path instellen, moet niet huidige dir zijn)
COPY src/panoramaViewer/ /usr/local/apache2/htdocs/

# Expose necessary ports
# Allow access to this container on port 80
EXPOSE 80

