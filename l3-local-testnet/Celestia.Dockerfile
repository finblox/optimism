FROM docker-proxy.nexus.finblox.co/debian:12-slim

RUN apt-get update -y \
    && apt-get upgrade -y \
    && bash -c "$(curl -sL https://docs.celestia.org/celestia-node.sh)"

ENTRYPOINT ["celestia"]
