# Post Setup: Additional Manual Steps

## On macOS, set Terminal.app's default shell

macOS's default terminal, Terminal.app, may use a different shell. We want to change this even though we don't use Terminal.app.
To change this, open Terminal.app, press `SPACE`+`.` and set _General_ -> _Shells open with_ to "Default login shell".

## SSH Keys

This repo doesn't handle SSH keys at all. You'll need to set them up yourself for every service that uses them, including git.

## Files with secrets

This repo doesn't handle files that include secrets, such as `~/.npmrc`. You'll need to create these yourself.

Suggested files:
- `~/npmrc`
- kube configs

## Github login

Generate a new SSH key (with `ssh-keygen -t ed25519 -a 100` -C "A_GOOD_KEY_NAME_HERE"`) for use with GitHub, and upload it to GitHub via their website.

Then, add the following to `.ssh/config`:

```
Host github.com
 HostName github.com
 IdentityFile ~/.ssh/NAME_OF_YOUR_NEW_KEY
```

**Updating the dotfiles repo login:**

If you want to be able to commit to the dotfiles repo from this device, you'll need to change the remote from HTTPS to SSH.

## Virtualbox on ARM macOS

ARM based macOS cannot install virtualbox with brew as the ARM builds are a developer preview.

To install them, download the App from the [virtualbox website](https://www.virtualbox.org/wiki/Download_Old_Builds_7_0).
