# Add git once, reuse below.
FROM alpine:3.15.5 as git_layer

RUN apk add git

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

# Base config - includes very basic configs and packer for plugin management
FROM git_layer AS neovim_config_base

# TODO: only pull base branch. Move more complex configs to extending image
ARG NVIM_BASIC_IDE_BRANCH=base-no-plugins

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim && \
    git clone --depth 1 --branch ${NVIM_BASIC_IDE_BRANCH} \
    https://github.com/davidbloss/nvim-basic-ide.git ${HOME}/.config/nvim

# Final product - all build, config, etc. brought in from prior image
FROM neovim_config_base AS neovim_base

RUN apk add g++
COPY --from=neovim_build /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=neovim_build /usr/local/share/nvim/runtime /usr/local/share/nvim/runtime
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

ENTRYPOINT ["nvim"]

