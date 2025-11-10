FROM ubuntu:24.04
ENV TARGETARCH="linux-x64"
# For ARM: "linux-arm", "linux-arm64"

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        curl \
        git \
        jq \
        libicu74 \
        ca-certificates \
        sudo \
        bash \
        docker.io \
        python3 \
        python3-pip

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR /azp/

COPY ./start.sh ./ 
RUN chmod +x ./start.sh

RUN useradd -m -d /home/agent agent && \
    chown -R agent:agent /azp /home/agent

ENV AGENT_ALLOW_RUNASROOT="true"
USER root

ENTRYPOINT ["./start.sh"]
