FROM adoptopenjdk:16-jre-hotspot

RUN apt-get update
RUN apt-get -yq install awscli jq cron

RUN mkdir /opt/minecraft

# version_manifest.json lists available MC versions
# Find latest version number if user wants that version (the default)
RUN SERVER_URL=$(curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json | \
    jq -r '.latest.release as $release | .versions[] | select(.id == $release).url' | \
    # From specific version manifest extract the server JAR URL
    xargs curl | jq -r '.downloads.server.url'); \
    # And finally download it to our local MC dir
    curl -o /opt/minecraft/minecraft_server.jar $SERVER_URL

ADD opt/minecraft/eula.txt /opt/minecraft/eula.txt
ADD opt/minecraft/start.sh /opt/minecraft/start.sh
ADD opt/minecraft/ops.json /opt/minecraft/ops.json
ADD opt/minecraft/server.properties /opt/minecraft/server.properties
ADD opt/minecraft/server-icon.png /opt/minecraft/server-icon.png

RUN chmod +x /opt/minecraft/start.sh

WORKDIR /opt/minecraft/

ENV S3_BUCKET=
ENV JAVA_MEMORY_OPTIONS="-XX:InitialRAMPercentage=75 -XX:MaxRAMPercentage=75"
ENV JAVA_OPTIONS=""

CMD ["bash", "-c", "/opt/minecraft/start.sh"]
