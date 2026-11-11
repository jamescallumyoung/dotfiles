# lib/select.sh — sourced, not executed directly.
# Provides: select_line (single-select), select_lines (multi-select)
#
# Both functions accept an optional $1 header shown to the user before the
# list, e.g. "Select a package manager". Tool-specific usage instructions
# are appended automatically.

select_line() {
    # $1: optional header/context shown to the user
    # Single-select. Reads candidate lines on stdin, writes the chosen line
    # to stdout. Prefers fzf; falls back to a numbered menu.
    header="${1:-Select one:}"

    if command -v fzf >/dev/null 2>&1; then
        # Buffer fzf's output before writing to stdout. Pipeline stages run
        # concurrently, so without this the next stage could write to the
        # terminal while fzf's UI is still open.
        result=$(fzf --header "$header
[enter] select  [esc] cancel" || :)
        [ -n "$result" ] || return 0
        printf '%s\n' "$result"
        return
    fi

    candidates=$(mktemp)
    trap 'rm -f "$candidates"' EXIT

    cat > "$candidates"
    select_line_numbered "$header" "$candidates"

    rm -f "$candidates"
    trap - EXIT
}

select_line_numbered() {
    # $1: header  $2: path to file with one candidate line per line
    header="$1"
    tmp_file="$2"

    printf '\n%s\n' "$header" >&2
    i=0
    while IFS= read -r line; do
        i=$((i + 1))
        printf '%3d) %s\n' "$i" "$line" >&2
    done < "$tmp_file"

    printf 'Enter a number: ' >&2
    read -r reply < /dev/tty

    sed -n "${reply}p" "$tmp_file"
}
