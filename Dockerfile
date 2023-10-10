# syntax=docker/dockerfile:1
FROM debian:bookworm-slim

RUN apt update && apt-get install -y \
    webhook \
    ca-certificates \
    curl \
    gnupg \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt update && apt-get install -y \
        docker-ce-cli \
        docker-compose-plugin \
	&& apt-get purge -y \
        curl \
		gnupg

WORKDIR /docker
EXPOSE 9000
ENTRYPOINT ["/usr/bin/webhook"]
