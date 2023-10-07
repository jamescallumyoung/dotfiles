# dotfiles

Dotfiles are the files used to configure linux (and macOS) environments.
They're highly specific to the user. These are @jamescallumyoung's.

This repo also contains brewfiles for use with [Homebrew](https://brew.sh/) ("macOS's missing package manager").
These allow multiple packages and apps to be installed at once.

Follow the installation guide below to copy this setup to a new device.

---

## Installation Guide

The guide below outlines some manual steps that need to be done.

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
