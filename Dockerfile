FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG VERSION=1.18.1.02
ARG WORDIR=/apps/bedrock-server

ENV LD_LIBRARY_PATH=/apps/bedrock-server

WORKDIR /apps/bedrock-server

EXPOSE 19132/udp
EXPOSE 19133/udp

RUN apt-get update && apt-get install -y \
    curl \
    unzip && \
    mkdir -p /apps/bedrock-server && \
    curl https://minecraft.azureedge.net/bin-linux/bedrock-server-$VERSION.zip --output $WORDIR/bedrock-server.zip && \
    unzip $WORDIR/bedrock-server.zip -d $WORDIR && \
    rm $WORDIR/bedrock-server.zip && \
    apt-get remove -y --purge unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["/apps/bedrock-server/bedrock_server"]
