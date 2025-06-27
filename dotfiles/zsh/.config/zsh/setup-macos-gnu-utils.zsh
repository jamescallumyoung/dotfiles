#!/usr/bin/env zsh

# macOS ships it's own version of many GNU utils, but they're often old.
# We prefer to install our own, which we do with Brew.
# However, Brew prefixes them all with 'g' so they don't conflict with macOS' own versions.
# So, we do some magic to find them all and prepend them to the path without the prefix.

if [[ $(uname) == "Darwin" ]]; then
    # on macOS, use the GNU versions provided by brew

    # get the "gnubin" directories.
    # these are created for any gnu package that would shadow a package shipped with macOS
    s_gnubins=$(find $(brew --prefix)/opt -type d -follow -name gnubin -print)

    # cast into a zsh array
    a_gnubins=( ${=s_gnubins} )

    for bindir ("$a_gnubins[@]"); do
        export path=($bindir $path) # add each dir to path. prepend so they take prio
    done

    unset s_gnubins
    unset a_gnubins
fi
