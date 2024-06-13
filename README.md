# dotfiles

My personal configuration files, plus some extras. This is the public repo, I
also keep a private one for things that I can't (or shouldn't) host here, like
font files and paid stuff.

Includes some code not written, but maybe modified by me (especially under
base16, bin directories).

## Usage

1. Install [stow(8)](https://linux.die.net/man/8/stow) with your package manager of choice (apt, dnf, pacman, brew, nix, etc.)
2. Clone this repo into your home folder `git clone git@github.com:kakig/dotfiles.git ~/.dotfiles`
3. At the repo root, run `stow <dir>` to install the configuration files present in `<dir>`
