# Neovim base image

[Alpine image](https://hub.docker.com/_/alpine) with
[latest Neovim stable version](https://github.com/neovim/neovim/tree/stable),
git,
[packer](https://github.com/wbthomason/packer.nvim "Neovim plugin manager"),
and necessary OS packages.

This image works as a starting point for building more feature rich images.

## Considerations

### Neovim notes

This image contains zero added configuration. Key mappings, options, etc, are
deferred to images that build on top of this one.

### OS notes

Alpine's foundation is built on [musl libc](https://musl.libc.org/) whereas
larger distros are are built on [glibc](https://www.gnu.org/software/libc/).

Generally this is not an issue but good to know if things are not working
with Alpine but are working on other distros.
