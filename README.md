# dotfiles

Dotfiles are the files used to configure macOS, Linux and Windows environments.
They're highly specific to the user. These are [@jamescallumyoung](https://github.com/jamescallumyoung)'s.

This repo does three things, and each step can be toggled on or off:

- installs dotfiles
- installs packages from a brewfile or pkglist
- performs additional miscellaneous actions to complete the setup

Follow the installation guide below to copy this setup to a new device.

---

## Regarding Packages

This repo contains a process for installing packages.
Packages are specified in a handful of files, and installed by `setup.sh`.

Which file is used depends on what package manager is selected:

- `.brewfile`s are used by [Homebrew](https://brew.sh/), "macOS's missing package manager".
- `.pkglist`s are used by [pkglist-cli][1], a custom tool to handle installing packages with numerous package managers.

---

## Installation Guide

The guide below outlines some manual steps that need to be done, followed by a `setup.sh` script that finishes the process.

Note: This guide was created to set up a new macOS device. Linux and Windows are still experimental.

### Install Package Managers

Which package manager you need is up to you. For macOS, Homebrew is recommended.
For Debian-based Linux, APT, Flatpak, and Snap can all be used together. Homebrew can also be used on Linux.

To proceed, you need to have every package manager you want to use installed.

#### Homebrew

We use Homebrew to install packages on macOS. Install it using the install script:

````shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jamescallumyoung/dotfiles/main/installers/brew.install.sh)"
````

Then check Homebrew is installed correctly with `brew doctor`.
We're especially interested in checking to make sure packages installed by Homebrew take priority over the versions shipped by Apple.

#### APT, Flatpak, Snap

Apt should already be installed.
You should check your distro's guides for installing Flatpak and Snap.

### Install packages needed for setup

#### Git

We need Git installed to complete the setup. Install it with:

```
# for Homebrew:
brew install --formulae git

# for pkglist:
apt install -y git
```

#### pkglist-cli

To use `.pkglist` files, we need a pkglist parser, like the one provided by [pkglist-cli][1].
To use it, we need to first install Node.js:

```shell
sudo apt update && sudo apt install nodejs
```

Now, we can use pkglist-cli via NPX with:

```shell
npx -p pkglist-cli -c "pkglist"
```

Or, install it and call it directly:

```shell
npm i -g pkglist-cli

pkglist
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

The script expects some arguments to enable each step, and select the package manager to use.

**Args:**

- The -r arg is the location of the dotfiles repo
- The -d and -m args enable the dotfiles, and misc steps.
- The -p arg is the package manager to use:
  - brew, or
  - pkglist (APT, Flatpak, and Snap)

```shell
chmod +x "$HOME/.dotfilesrepo/setup.sh"

/bin/bash -c "$HOME/.dotfilesrepo/setup.sh -dmp "A-PKG-MGR" -r \"$HOME/.dotfilesrepo\""
```

Note: Your password may be required at multiple stages. Some packages may need options to be selected (esp. when using Flatpak). This is not a script you can run unattended.

### Additional manual steps

#### On macOS, set Terminal.app's default shell

macOS's default terminal, Terminal.app, may use a different shell. We want to change this even though we don't use Terminal.app.
To change this, open Terminal.app, press SPACE+. and set _General_ -> _Shells open with_ to "Default login shell".

#### SSH Keys

This repo doesn't handle SSH keys at all. You'll need to set them up yourself for every service that uses them, including git.

#### Files with secrets

This repo doesn't handle handle files that include secrets, such as `~/.npmrc`. You'll need to create these yourself.

Suggested files:
- `~/npmrc`
- kube configs

#### Github login

Generate a new SSH key (with `ssh-keygen -t ed25519 -a 100` -C "A_GOOD_KEY_NAME_HERE"`) for use with GitHub, and upload it to GitHub via their website.

Then, add the following to `.ssh/config`:

```
Host github.com
 HostName github.com
 IdentityFile ~/.ssh/NAME_OF_YOUR_NEW_KEY
```

**Updating the dotfiles repo login:**

If you want to be able to commit to the dotfiles repo from this device, you'll need to change the remote from HTTPS to SSH.

#### Virtualbox on ARM macOS

ARM based macOS cannot install virtualbox with brew as the ARM builds are a developer preview.

To install them, download the App from the [virtualbox website](https://www.virtualbox.org/wiki/Download_Old_Builds_7_0).

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

---

## About pkglist

The pkglist format aims to provide Brewfile-like functionality to the Linux package managers I commonly use:
APT, Flatpak, and Snap.

`.pkglist` files can be parsed by a pkglist parser, such as [pkglist-cli][1], and then passed to the package manager.

You can learn more about the pkglist project by reading [the spec][2].

pkglist-cli is invoked by the `setup.sh` script.

[1]: https://github.com/jamescallumyoung/pkglist-cli-ts
[2]: https://github.com/jamescallumyoung/pkglist-spec
