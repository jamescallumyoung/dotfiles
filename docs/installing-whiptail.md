# Prerequisite: Installing whiptail

Before the "install packages" step of `setup.sh` can be run with the `-I` option, we must have [whiptail](https://linux.die.net/man/1/whiptail) installed.

## Check for installation

whiptail is installed on many Linuxes by default, especially Debian-based ones. Check it's installed with `which whiptail`.

## Install whiptail

We can install whiptail from either Homebrew or APT. Make sure the package manager(s) are available by following
[docs/installing-package-managers](./installing-package-managers.md) first.

### Install whiptail with Homebrew

```shell
# install:
brew install newt
```

### Install whiptail with APT

```shell
# install:
sudo apt install whiptail
```
