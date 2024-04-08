# Prerequisite: Installing Node.js

Before the "install packages" step of `setup.sh` can be run with the `-p pkglist` option, we must have [Node.js](https://nodejs.org/en) installed.

## Install Node.js

We can install Node.js from either Homebrew or Snap. Make sure the package manager(s) are available by following
[docs/installing-package-managers](./installing-package-managers.md) first.

### Install Node.js with Homebrew

```shell
# install:
brew install node

# verify the version installed by Homebrew is being used:
which node
which npm
which npx
```

### Install Node.js with Snap

```shell
# install:
sudo snap install node

# verify the version installed by Snap is being used:
which node
which npm
which npx
```
