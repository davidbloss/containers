# Neovim with bash development features

Features include
[ShellCheck](https://www.shellcheck.net/) as the static analyzer,
[Beautysh](https://github.com/lovesegfault/beautysh) as the formatter,
integrated into Neovim by the
[bash-language-server](https://github.com/bash-lsp/bash-language-server)
which is installed by
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/), and
Neovim
[configurations](https://github.com/davidbloss/neovim-ide.git "bash-ide branch")
specifically for bash development.

## st

[st](https://st.suckless.org/ ":rice: :rice: :rice:") is a simple terminal
implementation for X. \
Motivation for including st is mainly to provide true color in terminals with
better fonts and icons.

## ShellCheck

[ShellCheck](https://github.com/koalaman/shellcheck) is a static
analysis tools for shell scripts. \
The ShellCheck binary is copied from the maintainer's
[ShellCheck image](docker.io/koalaman/shellcheck:latest) and is primarily
used by Neovim for interactive feedback while working on shell scripts.

### Running shellcheck from outside container:

Docker running a temporary container interactively that accepts
`my_script_to_eval` as an argument. Note the use of `-<` to pass the script
as a file and not a string.
`docker run -i --rm --entrypoint=["/usr/local/bin/shellcheck"] <my_image>
-< my_script_to_eval`

## Explainshell

Not currently included but still a helpful tool to
[gain some insight](https://explainshell.com) into how shell scripts are
parsed.
