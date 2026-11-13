# dotfiles

Dotfiles are the files used to configure a user environment.
These are [@jamescallumyoung](https://github.com/jamescallumyoung)'s.

This repo provides my dotfiles and a script to install them using GNU Stow.

### GNU Stow

GNU Stow is used to manage the dotfiles in this repo.
It links them into their expected locations in the system, allowing the source files to remain in the Git repo so they can be version controlled.

This repo contains separate directories for each technology group, such as _zsh_ or _node_, to keep things organised.

This repo is structured so that:

- `./dotfiles` is the _stow directory_,
- `./dotfiles/<package_name>` are _package directories_,
- `~` (a.k.a: `$HOME`) is the _target directory_.

You can learn more about what these terms mean in the [the GNU Stow docs](https://www.gnu.org/software/stow/manual/stow.html#Terminology).

Stow is invoked by the `install-dotfiles.sh` script.

## Usage Guide

### Prerequisites

**Git**

Git must be installed.
Many Linux distros, and macOS, ship a version of Git that is good enough for our purposes.
You may want to install a more modern version later.

To detect if Git is installed, run `which git`.

**GNU Stow**

GNU Stow must be installed to use the `install-dotfiles.sh` script.

To detect if GNU Stow is installed, run `which stow`.

### 1 - Clone this repo

Clone this repo, so we can run the setup script.
The clone location doesn't matter but it's best to put it somewhere where it's clearly infrastructure and not a regular git repo.

```shell
# using SSH (recommended)
git clone git@github.com:jamescallumyoung/dotfiles.git $HOME/.dotfilesrepo

# using HTTPS
git clone https://github.com/jamescallumyoung/dotfiles.git $HOME/.dotfilesrepo
```

### 2 - Run the installer script

```shell
sh $HOME/.dotfilesrepo/scripts/install-dotfiles.sh
```

### 3 - Additional manual steps

There are additional manual steps you may want to take.
These are defined in [docs/post-setup-manual-steps.md](./docs/post-setup-manual-steps.md).

> ## 🖖 Notice
> This repo was forked from my previous dotfiles, with a squashed history.
>
> A previous version of these dotfiles handled package installation and various scripts.
> That functionality has been moved to [my setup repo](https://github.com/jamescallumyoung/setup).
