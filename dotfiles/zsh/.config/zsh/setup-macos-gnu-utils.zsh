#!/usr/bin/env zsh

# macOS ships it's own version of many GNU utils, but they're often old.
# We prefer to install our own, which we do with Brew.
# However, Brew prefixes them all with 'g' so they don't conflict with macOS' own versions.
# So, we do some magic to find them all and prepend them to the path without the prefix.

if [[ $(uname) == "Darwin" ]]; then
    # on macOS, use the GNU versions provided by brew
    
    A_GNUBINS=$(find $(brew --prefix)/opt -type d -follow -name gnubin -print)

    for bindir ("$A_GNUBINS[@]"); do
        export path=($bindir $path) # add each dir to path. prepend so they take prio
    done

    unset A_GNUBINS
fi

