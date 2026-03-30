fish_add_path ~/bin
fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/share/JetBrains/Toolbox/scripts
fish_add_path /usr/local/go/bin
fish_add_path /usr/local/bin
fish_add_path ~/go/bin

set --export BUN_INSTALL ~/.bun
fish_add_path $BUN_INSTALL/bin

set XDG_CONFIG_HOME $HOME/.config

set --export ENABLE_LSP_TOOL 1

set --export EDITOR /usr/local/bin/fresh

loadenv ~/.claude/env-otel

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    # Binding & Aliases
    bind alt-backspace backward-kill-word
    test -f ~/kubectl-aliases/.kubectl_aliases.fish && source ~/kubectl-aliases/.kubectl_aliases.fish

    starship init fish | source
    enable_transience
end
