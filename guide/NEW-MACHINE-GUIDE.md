# New Linux Machine Setup Guide

## 1. System base

1. **Full system update + reboot** before anything else.
2. **Hardware quirks** — for this Lenovo (MX130): blacklist nouveau
   (modprobe.d + grubby + dracut), or the desktop will freeze. Reboot required.
3. **Repos & media:** RPM Fusion free+nonfree, swap to full ffmpeg, Intel VAAPI driver,
   unfilter Flathub. Check whether **Terra** is available — it carries starship, ghostty
   and similar tools with fewer surprises than COPRs.
4. **Browser reminder:** remind the user to install their actively used browser
   themselves — the agent does not install or configure it.

> **Agent + sudo:** the agent can't type passwords. Collect all root operations of a
> phase into one script and run it yourself in a terminal, then let the agent verify.

## 2. Dotfiles & shell

1. Install GNU `stow`, clone `github.com/berk-karaal/dotfiles` to `~/dotfiles`, follow its README:
   stow `home/` → `~` and `etc/` → `/etc` (dry-run with `-n` first).
   - If tools already created config files (Claude Code's `/terminal-setup`, ghostty),
     move them aside first and merge later.
2. Install and enable **keyd**; the config arrives via the `etc/` stow. Verify it matched
   the internal keyboard in its journal.
3. Install **fish** and set it as login shell. Then the plugin layer:
   - fisher:
     `curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher`
   - `fisher update` — reinstalls every plugin listed in the repo-tracked `fish_plugins`
     (loadenv etc.). Fisher-installed files are gitignored; only the manifest is tracked.
4. Install **starship**, **ghostty**, **tmux**, **vim**.
5. Fonts: **MartianMono Nerd Font** (nerd-fonts release zip → `~/.local/share/fonts`,
   `fc-cache`). Ghostty and the fontconfig alias depend on it.

## 3. Git setup

The stowed `.gitconfig` includes `~/.gitconfig_personal` (name, email, SSH signing key)
— a **machine-local file that is never committed**, so it must be recreated on every
new machine. Until it exists, `git commit` fails (no identity, and commit signing is on)
and `git push` fails too (GitHub https URLs are rewritten to SSH).

Follow <https://berkkaraal.com/notes/git/setup/> — it walks through generating the
ed25519 SSH key, adding it to GitHub as both an **authentication key** and a
**signing key**, and testing the connection. Then create `~/.gitconfig_personal`
with `user.name`, `user.email` and `user.signingkey`.

## 4. Editors & apps

- **VS Code**: native RPM from Microsoft's official dnf repo (`packages.microsoft.com`) —
  not flatpak/snap. Updates arrive with normal `dnf upgrade`.
- **Zed**: official install script from zed.dev — installs user-level to `~/.local`,
  no root, updates itself from inside the app.
- Browsers/apps as needed; don't pre-enable repos you won't install from.

## 5. Additional tools

Frequently needed tools — install after the base is up, and **always the same way on
every machine**. The pattern: dnf when Fedora ships it current, the vendor's official
repo when they run one, the official installer/tarball for fast-moving toolchains.

- **gh** — `dnf install gh` (Fedora repo).
- **git-delta** — `dnf install git-delta` (Fedora repo). Not optional in practice:
  the stowed `.gitconfig` sets `pager = delta`, so git diff/log output is broken
  until it's installed.
- **fresh** — terminal text editor (<https://github.com/sinelaw/fresh>), used as
  `EDITOR`. Use the quick install method given at the GitHub repo
  → binary lands at `~/.local/bin/fresh`.
- **Docker** — Docker **Engine** (NOT Docker Desktop), following
  <https://docs.docker.com/engine/install/fedora/> — official docker-ce dnf repo.
  Mind the DNF5 syntax: `dnf config-manager addrepo --from-repofile=<url>`.
  Post-install: add user to the `docker` group + enable the service (linked from that page).
- **kubectl** — official Kubernetes dnf repo (`pkgs.k8s.io`). Also clone
  kubectl-aliases to `~/kubectl-aliases` (config.fish sources it when present).
- **Go** — official tarball from go.dev, unpacked to `/usr/local/go`
  (config.fish already paths it). Don't mix with dnf's golang package.
- **Rust** — `rustup` via the official installer (`~/.cargo/bin` already on path).
- **bun** — official script: `curl -fsSL https://bun.com/install | bash` → `~/.bun`
  (`BUN_INSTALL` already set in config.fish).
- **uv** — Astral's standalone installer: `curl -LsSf https://astral.sh/uv/install.sh | sh`.
- **node** — **fnm** (<https://github.com/Schniz/fnm>): one shared version store, so
  fish and bash see the same node versions. Install with the official script
  **plus `--skip-shell`** — the shell hooks already live in the dotfiles repo
  (`conf.d/fnm.fish` for fish, `.bashrc` for bash).
  Then `fnm install --lts && fnm default lts-latest`.
- Flatpak apps: Telegram.

## 6. Browser extensions

So they're not forgotten — install from the Chrome Web Store into whichever
Chromium-based browser is in use:

- Bitwarden
- Material Icons for GitHub

## 7. GNOME restore

Source: the `gnome/` folder next to this guide —
`gnome/extensions.md` (the extensions to install — UUIDs, purpose, repo links) and
`gnome/dconf/` (settings dumps; each file name tells you the dconf tree to load it into,
e.g. `interface.dconf` → `/org/gnome/desktop/interface/`). Extension settings are split
per extension under `gnome/dconf/extensions/` — load only the ones actually installed.
These were dumped from the verified-working Fedora 44 / GNOME 50 setup.

1. Install extensions **by UUID** with `gext` (pipx: gnome-extensions-cli).
   Never pin versions — let it fetch builds for the running shell.
   - **Check each installed `metadata.json` declares the running shell version.**
     If e.g.o lags (Media Controls did), either wait, build from source, or patch
     metadata and accept it may be disabled.
   - Leave out extensions that were "enabled but not installed" on the old machine.
2. **Log out and back in** (Wayland can't restart the shell).
3. Enable all extensions, confirm each reports `State: ACTIVE`.
4. `dconf load` the targeted files **in the bundle's documented order** — extensions
   first. Never bulk-load the full dconf dump.
5. **Re-empty** `switch-applications` and `switch-to-application-1..6` — a fresh GNOME
   repopulates them and they steal Super+1..6 from workspaces.
6. **Media-keys trap:** after a raw `dconf load`, custom shortcuts (Super+Return →
   terminal) may not fire — the daemon never re-grabs them. Fix: set
   `custom-keybindings` to `[]` via gsettings, then back to the real value.
7. Fix machine-specific values: Astra Monitor's `storage-main` disk ID in
   `extensions.dconf` (partition IDs change across reinstalls even on the same SSD) —
   re-pick the disk or write the current `/dev/disk/by-id` name.

## 8. Verify

- Super+Return → terminal · Super+1..6 → workspaces · Super+T → gTile · Alt+Tab → windows
- Panel: taskbar, workspace indicator, Astra Monitor with a real disk
- keyd: CapsLock=backspace, AltGr+IJKL navigation, TR layout swaps
- Dark theme, 6 workspaces, touchpad natural scroll
- New fish shell opens without errors, starship prompt renders (Nerd Font glyphs OK)

## Lessons learned (2026)

- Untracked files inside stowed directories feel backed up but aren't. `git status` before every wipe.
- COPRs don't always have builds for the newest Fedora — check first, prefer Terra/official repos.
- Raw `dconf load` of an unchanged value emits no change event; daemons may ignore it.
- Extension settings load silently into nothing if the extension isn't installed yet — order matters.
- Keep a running SETUP-LOG.md during the setup; it becomes the next version of this guide.
