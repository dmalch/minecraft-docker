FROM itzg/minecraft-server:latest

RUN apt-get update
RUN apt-get -yq install awscli jq

COPY data/eula.txt /data/eula.txt
COPY data/ops.json /data/ops.json
COPY data/server.properties /data/server.properties
COPY data/server-icon.png /data/server-icon.png
COPY start_customized.sh /start_customized.sh
COPY start-finalExec /start-finalExec

RUN chmod 666 /data/ops.json
RUN chmod 666 /data/server.properties
RUN chmod +x /start_customized.sh
RUN chmod +x /start-finalExec

ENV S3_BUCKET=
ENV MEMORY=
ENV MEMORY_PERCENTAGE=75

ENTRYPOINT [ "/start_customized.sh" ]
