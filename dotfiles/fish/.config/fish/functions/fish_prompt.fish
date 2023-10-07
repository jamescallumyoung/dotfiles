function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)

    set_color -o
    if test "$USER" = 'root'
        echo -n (set_color red)' #'
    end

    echo -n (set_color magenta)" "(git branch --no-color --show-current 2>&1 | egrep "(ADM-[0-9][0-9][0-9]|develop|master|main|dev)" -o)

    set FLAGS (string split -m 1 -r "|" (fish_git_prompt))[2]

    echo -n (set_color normal)(string replace ")" "" $FLAGS)" "
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    set_color normal
end
