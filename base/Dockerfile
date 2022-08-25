# Base Neovim image to build on. Contains Neovim with limited capabilities
FROM alpine:latest as neovim_vanilla

WORKDIR /home

# Workaround for when Singularity ignores guest OS "/home" directory contents
ENV XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-/home/.config}" \
    XDG_DATA_HOME="${XDG_DATA_HOME:-/home/.local/share}"

# Install OS dependencies, clone Neovim, and Packer for plugin management
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
    unzip && \
    git clone --depth 1 --branch stable \
    https://github.com/neovim/neovim.git . && \
    make -j CMAKE_BUILD_TYPE=Release && \
    make -j install && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ${XDG_DATA_HOME}/nvim/site/pack/packer/start/packer.nvim

# Kick the tires on a (mostly) vanilla Neovim install
ENTRYPOINT ["nvim"]
