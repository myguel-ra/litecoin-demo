FROM ubuntu:20.04
ARG VERSION=0.18.1

LABEL maintainer="Miguel Almeida" \
      description="x86_64 Image for demonstration purposes only"

RUN apt-get -qq update && apt-get -qq install -y wget gnupg && rm /var/lib/apt/lists/*.lz4

RUN set -eux; cd /tmp; \
    # Download litecoin package and signature with SHA256SUMS
    wget -nv https://download.litecoin.org/litecoin-$VERSION/linux/litecoin-$VERSION-x86_64-linux-gnu.tar.gz; \
    wget -nv -O signatures.asc https://download.litecoin.org/litecoin-$VERSION/linux/litecoin-$VERSION-linux-signatures.asc; \
    # Imports thrasher's PGP public key and confirms if the package is legit
    gpg --keyserver pgp.mit.edu --recv-keys FE3348877809386C; \
    gpg --verify signatures.asc; \
    sha256sum -c signatures.asc --ignore-missing; \
    # Install litecoin without GUI and clean up downloaded files
    tar -xzf *.tar.gz -C /usr/local --strip=1 --exclude=*/bin/*-qt; \
    rm *; \
    # Setup system user to run litecoin
    adduser -system litecoin 

EXPOSE 9332 9333

USER litecoin
WORKDIR /home/litecoin
ENTRYPOINT ["litecoind"] 
