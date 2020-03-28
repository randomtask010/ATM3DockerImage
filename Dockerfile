FROM openjdk:alpine
MAINTAINER Stefan Urban <stefan.urban@live.de>

USER root
WORKDIR /minecraft

VOLUME ["/minecraft/world"]
EXPOSE 25565

RUN apk update && apk add curl bash

# Download and unzip minecraft files
RUN mkdir -p /minecraft/world

RUN curl -LO https://addons-origin.cursecdn.com/files/2510/629/Server%20Files.zip
RUN unzip All+the+Mods+3-v5.12.3.zip && mv ATM3/* ./
RUN rmdir ATM3 && rm All+the+Mods+3-v5.12.3.zip


# Accept EULA
RUN echo "# EULA accepted on $(date)" > /minecraft/eula.txt && \
    echo "eula=TRUE" >> eula.txt

# Startup script
CMD ["/bin/bash", "/minecraft/ServerStart.sh"] 
