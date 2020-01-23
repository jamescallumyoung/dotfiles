# jamesyoung's dotfiles

These are my dotfiles. They assume the environment is set up correctly - although I'm decoupling from that slowly - and 

Currently, these dotfiles mostly handle config for:
- zsh
- npm


## Chezmoi

These dotfiles are managed with a CLI tool called `chezmoi`.

`chezmoi` provides loads of features to manage dotfiles but I'm currently just using it in the most basic way; add and remove files, then apply changes.

### Features

`chezmoi` provides a mechanism to create template files, and then only add the result of these files to our system. This helps keep the resulting files clean (helping readability and reducing bugs) and speeds up \*sh load times due to the lower amount of conditional logic needed.

The `private_` prefix to some files sets the correct permissions automatically too; something a plain git repo can strugle with.

The `dot_` prefix will rename the file to be prefixed with a dot. e.g. `dot_foo` becomes `.foo`.

The .chezmoiignore file is a .gitignore-like file to specify which files `chezmoi` should ignore. Ignored files will not be copied. Files beginnign with a dot are ignored by default.

### Install

You can install chezmoi from `brew`, `apt`, and lot's of other package managers, or install it manually. See https://chezmoi.io/ for more info.

Additionally, my system\_setup scripts will add `chezmoi` to the system with the system's usual package manager.


## Version control & git

I use git to version control my dotfiles. The `chezmoi` directory (accessed by calling `chezmoi cd`) is a git repo.

