ARG NVIM_CONFIG="~/.config/nvim"
ARG NVIM_HOME="/home/nvim"

FROM debian:bullseye as build_nvim

ARG NVIM_HOME

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
        autoconf \
        automake \
        ca-certificates \
        clang \
        cmake \
        curl \
        gettext \
        g++ \
        git \
        libtool \
        libtool-bin \
        make \
        ninja-build \
        pkg-config \
        doxygen \
        unzip


# Build deps
RUN git clone --depth 1 --branch stable https://github.com/neovim/neovim.git "${NVIM_HOME}"
RUN cd ${NVIM_HOME} && \
    make CMAKE_BUILD_TYPE=Release && \
    make install
RUN cd /home && rm -rf "${NVIM_HOME}"

FROM scratch

ARG NVIM_HOME

COPY --from=build_nvim "${NVIM_HOME}" "/"
RUN mkdir -p "${NVIM_CONFIG}" && touch "${NVIM_CONFIG}/init.lua"

RUN apt-get autoremove && \
    apt-get clean

# ~/.config/nvim/
# /usr/local/share/nvim/runtime/

