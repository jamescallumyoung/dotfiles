# dotfiles

Dotfiles are the files used to configure linux (and macOS) environments.
They're highly specific to the user. These are @jamescallumyoung's.

This repo also contains brewfiles for use with [Homebrew](https://brew.sh/) ("macOS's missing package manager").
These allow multiple packages and apps to be installed at once.

Follow the installation guide below to copy this setup to a new device.

---

## Installation Guide

The guide below outlines some manual steps that need to be done, followed by a `setup.sh` script that finishes the process.

The guide is suitable for setting up a new macOS device. Linux and Windows are not supported.

### Install Homebrew

We use Homebrew to install packages on macOS. Install it using the install script:

````shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jamescallumyoung/dotfiles/installers/brew.install.sh)"
````

Then check Homebrew is installed correctly with `brew doctor`.
We're especially interested in checking to make sure packages installed by Homebrew take priority over the versions shipped by Apple.

### Install packages needed for setup

We need some packages to complete the setup. Install them with:

```
curl -fsSL https://raw.githubusercontent.com/jamescallumyoung/dotfiles/brewfiles/initial.brewfile | brew bundle --file=-
```

### Clone this repo

Clone this repo, so we can run the setup script.
The clone location doesn't matter but it's best to put it somewhere where it's clearly infrastructure and not a regular git repo.

```shell
# using SSH (recommended)
git clone git@github.com:jamescallumyoung/dotfiles.git $HOME/.dotfilesrepo

# using HTTPS
git clone https://github.com/jamescallumyoung/dotfiles.git $HOME/.dotfilesrepo
```

### Run the setup script

The rest of the setup process is automatic. Just run the setup script in `~/.dotfilesrepo`.

```shell
chmod +x "$HOME/.dotfilesrepo/setup.sh"

# the -R arg is the location of the dotfiles repo
/bin/bash -c "$HOME/.dotfilesrepo/setup.sh -R \"$HOME/.dotfilesrepo\""
```

### Additional manual steps

#### Set Terminal.app's default shell

macOS's default terminal, Terminal.app, may use a different shell. We want to change this even though we don't use Terminal.app.
To change this, open Terminal.app, press SPACE+. and set _General_ -> _Shells open with_ to "Default login shell".

#### SSH Keys

This repo doesn't handle SSH keys at all. You'll need to set them up yourself for every service that uses them, including git.

#### Files with secrets

This repo doesn't handle handle files that include secrets, such as `~/.npmrc`. You'll need to create these yourself.

Suggested files:
- `~/npmrc`
- kube configs

---

## About Stow

GNU Stow is used to manage the dotfiles in this repo. It symlinks them into their expected locations in the system.
The repo contains separate directories for each technology group, such as _zsh_ or _node_, to keep things organised.

This repo is organized so that:

- `./dotfiles` is the _stow directory_,
- `./dotfiles/<package_name>` are _package directories_,
- `~` (a.k.a: `$HOME`) is the _target directory_.

You can learn more about what these terms mean in the [the docs](https://www.gnu.org/software/stow/manual/stow.html#Terminology).

Stow is invoked by the `setup.sh` script.
