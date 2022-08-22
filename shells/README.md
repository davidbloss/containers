# Neovim with shell programs

Shell programs include alternative terminals, language servers, and linters
for scripting languages such as bash.

## st

st is a simple terminal implementation for X. \
Motivation for including st is mainly to provide true color in terminals.

## Shellcheck

[Shellcheck](https://www.shellcheck.net/) is a static analysis tools for shell
scripts. \
The "shellcheck layer" can be used as a building block in a more complete
image or called directly.

### Running shellcheck:

Docker running a temporary container interactively that accepts
`my_script_to_eval` as an argument. Note the use of `-<` to pass the script
as a file and not a string.
`docker run -i --rm shellcheck_layer -< my_script_to_eval`

## Explainshell

TBD...
