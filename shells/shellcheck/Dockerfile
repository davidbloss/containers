ARG PLATFORM

FROM ${PLATFORM}alpine:latest as haskell_layer

WORKDIR /home

RUN apk update && apk add --no-cache \
    binutils-gold \
    curl \
    gcc \
    git \
    gmp-dev \
    libc-dev \
    libffi-dev \
    make \
    musl-dev \
    ncurses-dev \
    perl \
    tar \
    xz \
    zlib-dev

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1

RUN curl --proto '=https' --tlsv1.2 -sSf \
    https://get-ghcup.haskell.org/ | sh && \
    export PATH="$PATH:$HOME/.cabal/bin:$HOME/.ghcup/bin" && \
    cabal install cabal-install && \
    git clone --depth 1 \
    https://github.com/koalaman/shellcheck.git /tmp/shellcheck && \
    cd /tmp/shellcheck && \
    cabal install && \
    mkdir /home/shellcheck/ && \
    mv $HOME/.cabal/store/ghc-*/Shellcheck-*/ /home/shellcheck/

FROM alpine:latest as shellcheck_layer

COPY --from=haskell_layer /home/shellcheck/ /usr/local/lib/shellcheck/

RUN apk update && apk add gmp && \
    ln -s /usr/local/lib/shellcheck/Shellcheck-*/bin/shellcheck /usr/local/bin/

ENTRYPOINT ["shellcheck"]
