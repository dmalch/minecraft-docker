#!/bin/bash
set -e

if [ ! -z "$S3_BUCKET" ]; then
    aws s3 sync --exclude "*" --include "world/*" --include "logs/*" s3://$S3_BUCKET /opt/minecraft

    # Cron job to sync data to S3 every five mins
    cat <<CRON >/etc/cron.d/minecraft
*/5 * * * * root aws s3 sync --exclude "*" --include "world/*" --include "logs/*" /opt/minecraft s3://$S3_BUCKET
CRON
    service cron start
fi

java -jar ${JAVA_MEMORY_OPTIONS} ${JAVA_OPTIONS} /opt/minecraft/minecraft_server.jar

exit 0
