# dotfiles

Dotfiles are the files used to configure macOS, Linux and Windows environments.
They're highly specific to the user. These are [@jamescallumyoung](https://github.com/jamescallumyoung)'s.

This repo provides a `setup.sh` script that can do three things:

- install dotfiles
- install packages from a `.brewfile` or `.pkglist`
- perform miscellaneous actions to complete the setup

---

## Installing Dotfiles

GNU Stow is used to manage the dotfiles in this repo.
It links them into their expected locations in the system, allowing the source files to remain in the Git repo so they can be version controlled.

This repo contains separate directories for each technology group, such as _zsh_ or _node_, to keep things organised.

This repo is structured so that:

- `./dotfiles` is the _stow directory_,
- `./dotfiles/<package_name>` are _package directories_,
- `~` (a.k.a: `$HOME`) is the _target directory_.

You can learn more about what these terms mean in the [the GNU Stow docs](https://www.gnu.org/software/stow/manual/stow.html#Terminology).

Stow is invoked by the `setup.sh` script's "install dotfiles" step.


## Installing Packages

This repo contains a process for installing packages.
Packages are specified in a handful of files, and installed by `setup.sh`.

Which file is used depends on what package manager is selected:

- `.brewfile`s are used by [Homebrew](https://brew.sh/), "macOS's missing package manager".
- `.pkglist`s are used by [pkglist](https://github.com/jamescallumyoung/pkglist-cli-ts), a custom tool to handle installing packages with numerous package managers.

Homebrew and pkglist are invoked by the `setup.sh` script's "install packages" step.

### About pkglist

The pkglist format aims to provide Brewfile-like functionality to the Linux package managers I commonly use:
[APT](https://wiki.debian.org/Apt), [Flatpak](https://flatpak.org/), and [Snap](https://snapcraft.io/about).
You can learn more about the pkglist project by reading [the spec](https://github.com/jamescallumyoung/pkglist-spec).

---

## Installation Guide

The guide below outlines some manual steps that need to be done, followed by a `setup.sh` script that finishes the process.

Note: This guide was created to set up a new macOS device. Linux and Windows are still experimental.

### Prerequisites

Before `setup.sh` can be run, there are some prerequisites that need to be met:

- Package managers need to be available. See: [docs/installing-package-managers.md](./docs/installing-package-managers.md).
- Git must be installed. See: [docs/installing-git.md](./docs/installing-git.md).

If running the "install packages" step with the `-p pkglist` option:

- Node.js must be installed. See: [docs/installing-nodejs.md](./docs/installing-nodejs.md).

If running the "install packages" step with the `-I` option:

- whiptail must be installed. See: [docs/installing-whiptail.md](./docs/installing-whiptail.md).

If running the "install dotfiles" step:

- GNU Stow must be installed. See: [docs/installing-gnu-stow.md](./docs/installing-gnu-stow.md).

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

The rest of the setup process is automatic.
Just run the setup script, and provide the required `-r` option:

```shell
cd $HOME/.dotfilesrepo

chmod +x setup.sh
chmod +x ./scripts/*

./setup.sh -r $(pwd)
````

Running as above will perform a no-op run.
The script expects some options to enable each step, and select the package manager to use:

**Options:**

- `-r` is the location of the dotfiles repo.
- `-d` enables the "install dotfiles" step.
- `-m` enables the "misc tasks" step.
- `-p` enables the "install packages" step. It expects a value which indicates the package manager to use:
  - `-p brew` selects Homebrew,
  - `-p pkglist` selects pkglist, which supports APT, Flatpak, and Snap.

```shell
# e.g.
cd $HOME/.dotfilesrepo
./setup.sh -r $(pwd) -dmp brew
```

Note: Your password may be required at multiple stages. Some packages may need options to be selected (esp. when using Flatpak). This is not a script you can run unattended.

### Additional manual steps

After running `setup.sh`, there are additional manual steps you may want to take.
These are defined in [docs/post-setup-manual-steps.md](./docs/post-setup-manual-steps.md).

