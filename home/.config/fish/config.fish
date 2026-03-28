function starship_transient_prompt_func
    starship module character
end

bind alt-backspace backward-kill-word

test -f ~/kubectl-aliases/.kubectl_aliases.fish && source ~/kubectl-aliases/.kubectl_aliases.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set PATH "~/bin/" $PATH
    set PATH "~/bin" $PATH
    set PATH "~/.local/bin/" $PATH
    set PATH "~/.cargo/bin/" $PATH
    set PATH "~/.local/share/JetBrains/Toolbox/scripts" $PATH
    set PATH "/usr/local/go/bin" $PATH
	set PATH "~/go/bin" $PATH
    set XDG_CONFIG_HOME $HOME/.config
    starship init fish | source
    enable_transience
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set --export ENABLE_LSP_TOOL 1

