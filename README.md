# minecraft-docker

A docker image that runs a minecraft server.

## Usage

To build and run the latest version of minecraft

`docker build . -t minecraft-server:latest`

`docker run -it -p 25565:25565 minecraft:latest`

To sync the state of the server in an S3 bucket, an `S3_BUCKET` variable needs to be provided. For example when runs locally:

`docker run -v $HOME/.aws/credentials:/root/.aws/credentials:ro -e S3_BUCKET=s3-minecraft-data -it -p 25565:25565 minecraft:latest`

The server's JVM occupies 75% of containers memory by default. This settings can be changed via `JAVA_MEMORY_OPTIONS` environment variable. For example:

```docker
ENV JAVA_MEMORY_OPTIONS="-XX:InitialRAMPercentage=75 -XX:MaxRAMPercentage=75"

# Fixed settings
ENV JAVA_MEMORY_OPTIONS="-Xmx2G -Xms2G"
```

Additionally JVM settings can be provided via `JAVA_OPTIONS` environment variable.