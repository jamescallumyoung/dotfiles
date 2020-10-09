<h1 align="center">Welcome to james' dotfiles 👋</h1>
<p>
  <a href="./INSTRUCTIONS.md" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="./LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> Dotfiles are the files used to configure a development environment. These are mine.

## Install

Clone this repo to wherever you usually would. The `.git` directory will be created here, but the
working tree will be moved to `$HOME` in a later step.

```shell script
mkdir -p ~/repos && cd ~/repos
git clone git@github.com:jamescallumyoung/dotfiles.git
```

Add an alias/function for `git` so we can work with the detached working tree.
(These are already included in the dotfiles so no need to add them to your profile.) 

```shell script
# bash or zsh
alias dgit='git --git-dir=\$HOME/repos/dotfiles/.git --work-tree=\$HOME'

# or fish
function dgit ; git --git-dir=\$HOME/repos/dotfiles/.git --work-tree=\$HOME $argv ; end
```

Apply the changes to the system. ⚠️⚠️ This will destroy any conflicting dotfiles current on the
system! ⚠️⚠️

```shell script
cd $HOME
dgit reset --hard
```

Restart your shell to see shell-related changes take effect.

```shell script
# bash
exec bash

# zsh
exec zsh

# fish
refresh
```

The dotfiles are now installed! 🎉

## Usage

Make changes to the files as you normally would. When you're ready to commit them to git, simply
use the `dgit` alias/function where you would usually use `git`. (And use the `-f` option when
adding files, as they're all ignored by default.)

Example:

```shell script
dgit add ~/.npmrc
dgit commit -m "Add npmrc"
dgit push
```

## Author

👤 **James Young <hello@jamesyoung.ch>**

* Website: https://jamesyoung.ch
* Github: [@jamescallumyoung](https://github.com/jamescallumyoung)

## 📝 License

Copyright © 2020 [James Young <hello@jamesyoung.ch>](https://github.com/jamescallumyoung).<br />
This project is [MIT](./LICENSE) licensed.
