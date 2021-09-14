FROM adoptopenjdk:16-jre-hotspot

ENV SSH_USER="ubuntu"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -yq install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" wget awscli jq

RUN mkdir /opt/minecraft

# version_manifest.json lists available MC versions
RUN wget -O /opt/minecraft/version_manifest.json https://launchermeta.mojang.com/mc/game/version_manifest.json; \
    # Find latest version number if user wants that version (the default)
    MC_VERS=$(jq -r '.["latest"]["'"release"'"]' /opt/minecraft/version_manifest.json); \
    # Index version_manifest.json by the version number and extract URL for the specific version manifest
    VERSIONS_URL=$(jq -r '.["versions"][] | select(.id == "'"$MC_VERS"'") | .url' /opt/minecraft/version_manifest.json); \
    echo $VERSIONS_URL; \
    # From specific version manifest extract the server JAR URL
    SERVER_URL=$(curl -s $VERSIONS_URL | jq -r '.downloads | .server | .url'); \
    # And finally download it to our local MC dir
    wget -O /opt/minecraft/minecraft_server.jar $SERVER_URL

ADD opt/minecraft/eula.txt /opt/minecraft/eula.txt

WORKDIR /opt/minecraft/

CMD ["java", "-jar", "-Xms2G", "-Xmx2G", "/opt/minecraft/minecraft_server.jar"]
