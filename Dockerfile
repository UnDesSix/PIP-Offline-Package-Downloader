FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    wget \
    tar \
    gzip \
    make \
    python3 \
    python3-pip \
    python3-yaml \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
    && chmod +x /usr/local/bin/yq

WORKDIR /app
COPY entrypoint.sh .
COPY config.yml .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
