function fish_prompt
    set -l status_copy $status
    set -l color_error (set_color red)
    set -l color_normal (set_color blue)

    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test $USER = 'root'
    and echo (set_color red)"#"

    # pwd
    echo -n (set_color green)(prompt_pwd)

    if test "$status_copy" -ne 0
        echo -n "$color_error"
    else
        echo -n "$color_normal"
    end
    # Main
    echo -n ' ❯ '
end
