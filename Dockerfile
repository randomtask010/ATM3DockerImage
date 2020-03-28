FROM openjdk:alpine
MAINTAINER Stefan Urban <stefan.urban@live.de>

USER root
WORKDIR /minecraft

VOLUME ["/minecraft/world"]
EXPOSE 25565

RUN apk update && apk add curl bash

# Download and unzip minecraft files
RUN mkdir -p /minecraft/world

RUN curl -LO https://media.forgecdn.net/files/2756/981/ATM3-5.12.3_Server-FULL.zip 
RUN unzip ATM3-5.12.3_Server-FULL.zip && mv ATM3/* ./
RUN rmdir ATM3 && rm ATM3-5.12.3_Server-FULL.zip


# Accept EULA
RUN echo "# EULA accepted on $(date)" > /minecraft/eula.txt && \
    echo "eula=TRUE" >> eula.txt

# Startup script
CMD ["/bin/bash", "/minecraft/ServerStart.sh"] 
