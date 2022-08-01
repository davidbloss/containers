FROM debian:bullseye as build_neovim

ARG NVIM_HOME="/home/nvim"

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
        autoconf \
        automake \
        ca-certificates \
        clang \
        cmake \
        curl \
        doxygen \
        gettext \
        g++ \
        git \
        libtool \
        libtool-bin \
        make \
        ninja-build \
        pkg-config \
        unzip


# Build deps
RUN git clone --depth 1 --branch stable https://github.com/neovim/neovim.git ${NVIM_HOME}
RUN cd ${NVIM_HOME} && \
    make CMAKE_BUILD_TYPE=Release && \
    make install

FROM alpine:3.15.5 AS neovim_runtime

ARG NVIM_BIN="/usr/local/bin/nvim"
ARG NVIM_CONFIG="~/.config/nvim"
ARG NVIM_RUNTIME="/usr/local/share/nvim/runtime"

COPY --from=build_neovim ${NVIM_BIN} ${NVIM_BIN}
COPY --from=build_neovim ${NVIM_RUNTIME} ${NVIM_RUNTIME}

RUN mkdir -p ${NVIM_CONFIG} && touch ${NVIM_CONFIG}/init.lua

ENTRYPOINT ["nvim"]

