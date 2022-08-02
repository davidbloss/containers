ARG NVIM_CONFIG="~/.config/nvim"

FROM alpine:3.15.5 as neovim_build

ARG NVIM_HOME="/home/nvim"

RUN apk add --no-cache \
    autoconf \
    automake \
    build-base \
    cmake \
    coreutils \
    curl \
    gettext-tiny-dev \
    git \
    libtool \
    pkgconf \
    unzip

# Build deps
RUN git clone --depth 1 --branch stable \
    https://github.com/neovim/neovim.git ${NVIM_HOME}
RUN cd ${NVIM_HOME} && \
    make CMAKE_BUILD_TYPE=Release && \
    make install

# Base config - no plugins yet...
FROM alpine:3.15.5 AS neovim_config

ARG NVIM_CONFIG

RUN apk add --no-cache git
RUN mkdir -p ${NVIM_CONFIG} && \
    git clone --depth 1 --branch base-no-plugins \
    https://github.com/davidbloss/nvim-basic-ide.git ${NVIM_CONFIG}

# Final product - all build, config, etc. brought in from prior image
FROM alpine:3.15.5 AS neovim_runtime

ARG NVIM_BIN="/usr/local/bin/nvim"
ARG NVIM_CONFIG
ARG NVIM_RUNTIME="/usr/local/share/nvim/runtime"

WORKDIR /home

RUN apk add --no-cache gcc
COPY --from=neovim_build ${NVIM_BIN} ${NVIM_BIN}
COPY --from=neovim_build ${NVIM_RUNTIME} ${NVIM_RUNTIME}
COPY --link --from=neovim_config ${NVIM_CONFIG} ${NVIM_CONFIG}

ENTRYPOINT ["nvim"]

