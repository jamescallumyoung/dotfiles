# Add the multi-function file for git-omz:
# source "$__fish_config_dir"/git-omz-functs.fish

# Set EDITOR & PAGER
# note: fish uses it's own pager for tab completion
set -gx EDITOR (type -p nvim)
set -gx PAGER (type -p most)
set -gx BAT_PAGER (type -p less)

