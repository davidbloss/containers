# Neovim as a containerized IDE

🚧 Alpha stage project 🚧

For development in more tightly controlled work environments.

System level work managed here. Neovim work pulled in from other repo.

## Containers
Collection of "batteries included" Neovim configurations.

### Base IDE (text editor with git support)
Standalone container that more feature full containers may be built on.
- Base (foundation that all others can build on)
  - FROM alpine (musl libc)
  - Neovim [base-IDE](https://github.com/davidbloss/neovim-ide/tree/base-ide)
    configured with git and generic plugins.
- Base2: glibc based container (not musl libc)
  - Necessary?

### Bash IDE
Features and programs to include:
- [explainshell](https://github.com/idank/explainshell)
- [shellcheck](https://github.com/koalaman/shellcheck)
- [bash-language-server](https://github.com/bash-lsp/bash-language-server)
parser installed via nvim-treesitter

### Python IDE
Features and programs to include:
- Python 3 with linters, formatters, etc.
- [jedi-language-server](https://github.com/pappasam/jedi-language-server)
parser installed via nvim-treesitter
- Neovim [python-IDE](https://github.com/davidbloss/neovim-ide/tree/python-ide)
  configured with Python LSP goodies. **WIP: not functional**

### C/C++ IDE
Features and programs to include:
- LLVM/clang stuff
- [clangd](https://clangd.llvm.org) parser installed via nvim-treesitter
- [cmake](https://github.com/regen100/cmake-language-server)
parser installed via nvim-treesitter

### Misc
- yaml (Gitlab) support?

### Full Featured IDE
Combination of above IDEs.
