#! /usr/bin/env zsh

# setup "eval caching" (lazy-loading) for tools that need `eval`ing
# this helps improve shell startup times
# (cached `eval`s can be cleared with `$ _evalcache_clear`)

# nvm
# nothing to do; we use the zsh-nvm plugin to layz-load nvm

# thefuck
_evalcache thefuck --alias
alias f="fuck"

# hub (GitHub cli)
_evalcache hub alias -s

# jenv; java environment manager
# can't use evalcache directly here because it breaks jenv's compatibility with the export plugin
# instead, we make a fn and evalcache it
path+=("$HOME/.jenv/bin")
_jenv_setup_fn () {
    # enabling a plugin in jenv modifies the output of "jenv init", but must be done after "jenv init" has been run
    # this means that "jenv init" must be run twice; once to set up jenv, and again after the plugins have been enabled
    eval "$(jenv init - --no-rehash)"
    jenv enable-plugin export
    echo "$(jenv init - --no-rehash)"
}
_evalcache _jenv_setup_fn
unfunction _jenv_setup_fn
# start a background rehashing process, as we skip it in the setup fn
# this speeds up shell startup by rehashing (which is slow) in the background
(jenv rehash &) 2> /dev/null

