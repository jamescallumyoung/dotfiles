# Prerequisite: Installing Git

Before `setup.sh` can be run, we must have [Git](https://git-scm.com/) installed.

## Is Git already installed?

Many Linux distros, and macOS, ship a version of Git.
This is probably good enough for our purposes.

To detect if Git is installed, run `which git`.

## Install Git

If needed, we can install Git. Make sure the package manager(s) are available by following
[docs/installing-package-managers](./installing-package-managers.md) first.

### Install Git with Homebrew

```shell
# install:
brew install git

# verify the version installed by Homebrew is being used:
which git
```

### Install Git with APT

```shell
# install:
sudo apt install git

# verify the version installed by APT is being used:
which git
```
