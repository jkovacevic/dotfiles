# Claude Code ↔ tmux tab colors

Each tmux tab is colored by what Claude is doing in that window, driven by a per-window
`@claude_status` option.

| Color | `@claude_status` | Meaning |
|-------|------------------|---------|
| red | `computing` | thinking |
| yellow | `prompt` | waiting for your input |
| brightcyan | `unread` | finished, not yet seen |
| green | `idle` | finished and seen (or just launched) |
| white/cyan | _(unset)_ | no Claude running |

**Pieces:**
- `status.sh <computing|prompt|complete>` — set by Claude hooks in `../settings.json`.
  `complete` → `idle` if the window is focused, else `unread`.
- `tmux.conf` — maps `@claude_status` → tab color (sourced from `~/dotfiles/tmux/tmux.conf`).
  The color-selection lives in one shared `@claude_fg` option. Also clears `unread`→`idle`
  on focus, and runs `tmux-init.sh` on attach.
- `tmux-init.sh` — on tmux (re)attach, re-greens windows already running Claude.
- `../shell.zsh` — the `claude()` wrapper sets `@claude_status idle` on launch.
