if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set PATH "/home/berk/.local/bin/" $PATH
    set PATH "/home/berk/.cargo/bin/" $PATH
    set XDG_CONFIG_HOME $HOME/.config
    alias dotfiles_git='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
    starship init fish | source
end
