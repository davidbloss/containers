# Neovim as a containerized IDE For development in more tightly controlled work
environments.

System level work managed here. Neovim work pulled in from other repo.

## Containers
Collection of "batteries included" Neovim configurations.

#### Base IDE (text editor with git support)
Standalone container that more feature full containers may be built on.
- Base (foundation that all others can build on)
  - FROM alpine (musl libc)
  - configured nvim w/ pure lua plugins
    - sourced from my repo
    - git included
- Base2: glibc based container (not musl libc)
  - Necessary?

#### Bash IDE
Features and programs to include:
- [explainshell](https://github.com/idank/explainshell)
- [shellcheck](https://github.com/koalaman/shellcheck)
- [bash-language-server](https://github.com/bash-lsp/bash-language-server) \
parser installed via nvim-treesitter

#### Python IDE
Features and programs to include:
- Python dev
  - Python 3 with linters, formatters, etc.
  - [jedi-language-server](https://github.com/pappasam/jedi-language-server) \
parser installed via nvim-treesitter

#### C/C++ IDE
Features and programs to include:
- C/C++ dev
  - llvm/clang stuff?
  - nvim-treesitter installed parser

#### Misc
- yaml (Gitlab) support?
