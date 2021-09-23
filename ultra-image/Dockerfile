FROM itzg/minecraft-server:latest

RUN apt-get update
RUN apt-get -yq install awscli jq cron

ADD data/eula.txt /data/eula.txt
ADD data/ops.json /data/ops.json
ADD data/server.properties /data/server.properties
ADD data/server-icon.png /data/server-icon.png
ADD start_cron.sh /start_cron.sh
ADD start_customized.sh /start_customized.sh
ADD start-finalExec /start-finalExec

RUN chmod 666 /data/ops.json
RUN chmod 666 /data/server.properties
RUN chmod +x /start_cron.sh
RUN chmod +x /start_customized.sh
RUN chmod +x /start-finalExec

ENV S3_BUCKET=
ENV MEMORY=
ENV MEMORY_PERCENTAGE=75

ENTRYPOINT [ "/start_customized.sh" ]