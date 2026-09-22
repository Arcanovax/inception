FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN VERSION="0.25.2" && \
    BASE="https://github.com/jesseduffield/lazydocker/releases/download/v${VERSION}" && \
    curl -sSLO "${BASE}/lazydocker_${VERSION}_Linux_x86_64.tar.gz" && \
    curl -sSLO "${BASE}/checksums.txt" && \
    sha256sum --check --ignore-missing checksums.txt && \
    tar xzf "lazydocker_${VERSION}_Linux_x86_64.tar.gz" lazydocker && \
    install -m 0755 lazydocker /usr/local/bin/lazydocker && \
    rm -rf /tmp/*

ENTRYPOINT ["/usr/local/bin/lazydocker"]
