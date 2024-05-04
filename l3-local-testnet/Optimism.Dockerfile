FROM docker-proxy.nexus.finblox.co/node:20-bookworm

WORKDIR /optimism

USER root

RUN --mount=type=bind,source=.,target=/optimism apt-get update -y \
    && apt-get install -y git jq curl build-essential \
    && case $(uname -m) in aarch64|arm64) ARCH="arm64" ;; amd64|x86_64) ARCH="amd64" ;; esac \
    && curl -sL https://go.dev/dl/go1.21.9.linux-$ARCH.tar.gz | tar xzf - -C /usr/local \
    && echo "export PATH=\"\$PATH:/usr/local/go/bin\"" >> $HOME/.bashrc \
    && npm install -g pnpm@9.1.0 \
    && npm install -g npm@10.7.0 \
    && curl -sfL https://direnv.net/install.sh | bash \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y \
    && . $HOME/.cargo/env \
    && rustup toolchain install nightly \
    && rustup default nightly \
    && RUSTFLAGS="-Z threads=8" pnpm install:foundry

ENTRYPOINT ["bash"]
