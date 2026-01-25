function starship_transient_prompt_func
    starship module character
end

bind alt-backspace backward-kill-word

test -f /home/berk/kubectl-aliases/.kubectl_aliases.fish && source /home/berk/kubectl-aliases/.kubectl_aliases.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set PATH "/home/berk/bin/" $PATH
    set PATH "~/bin" $PATH
    set PATH "/home/berk/.local/bin/" $PATH
    set PATH "/home/berk/.cargo/bin/" $PATH
    set PATH "/home/berk/.local/share/JetBrains/Toolbox/scripts" $PATH
    set PATH "/usr/local/go/bin" $PATH
	set PATH "/home/berk/go/bin" $PATH
    set XDG_CONFIG_HOME $HOME/.config
    starship init fish | source
    enable_transience
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set --export ENABLE_LSP_TOOL 1

