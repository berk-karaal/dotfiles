if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set PATH "/home/berk/.local/bin/" $PATH
    set PATH "/home/berk/.cargo/bin/" $PATH
    set PATH "/home/berk/.local/share/JetBrains/Toolbox/scripts" $PATH
    set PATH "/home/berk/go/bin" $PATH
    set XDG_CONFIG_HOME $HOME/.config
    starship init fish | source
end
