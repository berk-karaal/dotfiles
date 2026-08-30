# GNOME Extensions

**Captured 2026-08-29 · Fedora 44 · GNOME Shell 50.4 · Wayland.**
The versions below are what the `dconf/extensions/` settings dumps were taken from. On
the next setup, newer versions will normally be installed — the settings usually carry
over, but if an extension has jumped a major version (or the shell is several releases
ahead), skim its release notes before trusting the old dump; load it, then verify the
extension behaves. Version numbers are e.g.o build counters; upstream names in parentheses.

Each extension's settings live in `dconf/extensions/<subtree>.dconf`, which loads into
`/org/gnome/shell/extensions/<subtree>/`. **Only load the file of an extension you
actually installed** — loading settings for absent extensions plants orphaned keys in
dconf that linger for years.

| Extension | UUID | Version | Settings file | Used for | Repo |
|---|---|---|---|---|---|
| gTile | `gTile@vibou` | 65 | `gtile.dconf` | Grid window tiling, toggled with Super+T | <https://github.com/gTile/gTile> |
| Just Perfection | `just-perfection-desktop@just-perfection` | 37 | `just-perfection.dconf` | Shell tweaks: panel size, animation speed, hiding UI clutter | <https://gitlab.gnome.org/jrahmatzadeh/just-perfection> |
| App Icons Taskbar | `aztaskbar@aztaskbar.gitlab.com` | 39 (31.3) | `aztaskbar.dconf` | Taskbar with running-app icons in the top panel (replaces the dash) | <https://gitlab.com/AndrewZaech/aztaskbar> |
| Astra Monitor | `monitor@astraext.github.io` | 60 (42) | `astra-monitor.dconf` | CPU / memory / storage / sensor stats in the panel | <https://github.com/AstraExt/astra-monitor> |
| AppIndicator Support | `appindicatorsupport@rgcjonas.gmail.com` | 64 | `appindicator.dconf` | Legacy tray icons for apps like Telegram | <https://github.com/ubuntu/gnome-shell-extension-appindicator> |
| Media Controls | `mediacontrols@cliffniff.github.com` | 47 (2.4.4) † | `mediacontrols.dconf` | Now-playing info + player controls in the panel | <https://github.com/sakithb/media-controls> |
| Workspaces indicator by open apps | `workspaces-by-open-apps@favo02.github.com` | 27 | `workspaces-indicator-by-open-apps.dconf` | Workspace indicator on the left of the panel (hides Activities) | <https://github.com/Favo02/workspaces-by-open-apps> |
| Caffeine | `caffeine@patapon.info` | 60 | `caffeine.dconf` | Inhibit sleep/screensaver on demand | <https://github.com/eonpatapon/gnome-shell-extension-caffeine> |
| Steal my focus window | `steal-my-focus-window@steal-my-focus-window` | 7 | — (no settings) | Focus new windows instead of the "is ready" notification | <https://github.com/v-dimitrov/gnome-shell-extension-stealmyfocus> |

† Media Controls v47 officially declares shell ≤49; its `metadata.json` was hand-patched
to load on GNOME 50 and works. If e.g.o has a newer build by the next setup, use that
instead of repeating the patch.

Install each by UUID (e.g. `gext install <uuid>`) and let the tool fetch the build
matching the running shell — never pin these versions.

Machine-specific: `astra-monitor.dconf` contains `storage-main` (a disk/partition ID) —
re-pick it on new hardware or after repartitioning.
