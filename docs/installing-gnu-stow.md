# Prerequisite: Installing Stow

Before the "install dotfiles" step of `setup.sh` can be run, we must have [Stow](https://www.gnu.org/software/stow/) installed.

> Note: If the "install packages" step is enabled, Stow will automatically be installed and you can skip these instructions.

## Install Stow

If needed, we can install Stow. Make sure the package manager(s) are available by following
[docs/installing-package-managers](./installing-package-managers.md) first.

### Install Stow with Homebrew

```shell
# install:
brew install stow

# verify the version installed by Homebrew is being used:
which stow
```

### Install Stow with APT

```shell
# install:
sudo apt install stow

# verify the version installed by APT is being used:
which stow
```
