# Neovim image with bash development support
FROM docker.io/koalaman/shellcheck:latest as shellcheck

# Try shellcheck at --> https://www.shellcheck.net/

FROM docker.io/davidbloss/neovim_vanilla as neovim_shell_ide

WORKDIR /home

SHELL /bin/bash

# Neovim configurations with bash support pulled in from this branch
ARG SHELL_BRANCH=bash-ide

# Clone configurations into
RUN apk update && \
    apk add bash g++ mandoc npm python3 py3-pip py3-setuptools ripgrep && \
    pip install beautysh && \
    rm -rf ${XDG_CONFIG_HOME}/nvim/ && \
    git clone --depth 1 --branch ${SHELL_BRANCH} \
    https://github.com/davidbloss/neovim-ide.git ${XDG_CONFIG_HOME}/nvim/ && \
    nvim --headless \
         -c 'autocmd User PackerComplete quitall' \
         -c 'PackerSync' && \
    nvim --headless \
         -c 'TSUpdateSync bash' \
         -c 'LspInstall --sync bashls' \
         -c q && \
    apk del g++ npm py3-pip

COPY --from=shellcheck /bin/shellcheck /usr/local/bin/shellcheck

ENTRYPOINT ["nvim"]

