# mise (tool version manager) — https://mise.jdx.dev
# Shadows Homebrew's vendor_conf.d/mise-activate.fish so activation happens once
# here on every machine, not twice on macOS.
type -q mise && mise activate fish | source
