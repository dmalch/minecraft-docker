#!/bin/bash
set -e

aws s3 sync s3://dmalch-minecraft-data /opt/minecraft

java -jar -Xms2G -Xmx2G /opt/minecraft/minecraft_server.jar

exit 0
