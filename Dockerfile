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

# Build deps
RUN git clone --depth 1 --branch stable https://github.com/neovim/neovim.git .
RUN make CMAKE_BUILD_TYPE=Release && make install

# Base config - no plugins yet...
FROM git_layer AS neovim_config

RUN git clone --depth 1 --branch base-no-plugins \
    https://github.com/davidbloss/nvim-basic-ide.git ${HOME}/.config/nvim

# Final product - all build, config, etc. brought in from prior image
FROM neovim_config

RUN apk add gcc
COPY --from=neovim_build /usr/local/bin/nvim /usr/local/bin/nvim
COPY --from=neovim_build /usr/local/share/nvim/runtime /usr/local/share/nvim/runtime

ENTRYPOINT ["nvim"]

