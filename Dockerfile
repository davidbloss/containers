# Add git once, reuse below.
FROM alpine:latest as git_layer

RUN apk add git
ENV XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-/home/.config}" \
    XDG_DATA_HOME="${XDG_DATA_HOME:-/home/.local/share}"

FROM git_layer as neovim_build

WORKDIR /home/neovim_build

RUN apk add --no-cache \
    autoconf \
    automake \
    build-base \
    cmake \
    coreutils \
    curl \
    gettext-tiny-dev \
    libtool \
    pkgconf \
    unzip

# Build dependencies
RUN git clone --depth 1 --branch stable https://github.com/neovim/neovim.git .
RUN make -j CMAKE_BUILD_TYPE=Release && make -j install

# Base config. Contains neovim plugins for git, code navigation, and style.
FROM git_layer AS neovim_config_base

RUN apk add curl && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ${XDG_DATA_HOME}/nvim/site/pack/packer/start/packer.nvim && \
    git clone --depth 1 --branch base-ide \
    https://github.com/davidbloss/neovim-ide.git ${XDG_CONFIG_HOME}/nvim && \
    apk del curl

# Final product - all build, config, etc. brought in from prior image
FROM neovim_config_base AS neovim_base

WORKDIR /home

RUN apk add g++ ripgrep
COPY --from=neovim_build /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=neovim_build /usr/local/share/nvim/runtime /usr/local/share/nvim/runtime
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

ENTRYPOINT ["nvim"]

