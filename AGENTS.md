# AGENTS.md

My personal dotfiles. I use them on my machines (macOS and Linux) to configure my tools and apps.

It's a public repo on GitHub, but not intended for general use. The setup is opinionated and assumes a lot about my workflow.

DO NOT LEAK ANY SECRETS OR SENSITIVE INFORMATION TO GIT. The repo is public.

MUST read @README.md first before anything else.

## Layout

- `home/` → stowed into `~` (`stow . --dir=$HOME/dotfiles/home --target=$HOME`)
- `etc/` → stowed into `/etc` with sudo (Linux only: keyd, dnf)
- `guide/NEW-MACHINE-GUIDE.md` → how I set up a new machine; keep it in sync when setup steps change
- `guide/gnome/` → GNOME extension list and dconf dumps (Linux only)

Some configs are platform-specific: `karabiner/` is macOS only; `etc/` and the GNOME files are Linux only. But they can be present on the other platform without harm.

## Things to know before editing

- **Files under `~` are symlinks into this repo.** Editing `~/.config/fish/config.fish` edits the
  repo file. Most `~/.config/<app>` entries are whole-directory symlinks, so files an app writes at
  runtime (logs, sessions, caches) land in the repo. Don't commit those: add a `.gitignore` rule
  instead (pattern: `home/.config/<app>/*` plus `!` for the real config file).
- **Per-machine settings stay out of the repo:**
  - git: `~/.gitconfig.local` (identity, signing key, work `includeIf`), included by `.gitconfig`
  - mise: `~/.config/mise/config.toml` is gitignored; global tools are installed per machine
- **Installers append to shell configs.** Docker, LM Studio, bun etc. add PATH lines, often with
  hardcoded home-directory paths, to `config.fish` and `.bashrc`. Don't commit those unless I ask.
- **fish:** `functions/`, `completions/` and `conf.d/` are gitignored because fisher owns them;
  track my own file there with a `!` line in `.gitignore`. Plugins are listed in `fish_plugins`.
  Shared abbreviations go in `conf.d/myabbrs.fish`; machine-only ones in the untracked
  `conf.d/local-abbrs.fish`.
- **Tool versions:** node and python come from mise (activated in `conf.d/mise-activate.fish` and
  `.bashrc`). Don't add fnm, nvm or pyenv.

## Commits

- One topic per commit, message format: `(<tool>) <lowercase summary>`, e.g. `(fish) add ... abbr`.
- Only stage the files the change is about. The working tree often has unrelated uncommitted edits.
- Don't push unless I ask.
