# Apps

Daily-use software on Windows 11.

## Terminals

| App | Role |
|---|---|
| [Windows Terminal](https://aka.ms/terminal) | Primary — WSL2 + PowerShell profiles |

## Editors

| App | Role |
|---|---|
| [Zed](https://zed.dev) | Primary editor — fast, native feel |
| [VS Code](https://code.visualstudio.com) | WSL remote extension for heavier work |
| [Notepad++](https://notepad-plus-plus.org) | Quick Windows-side file edits |

## Browser

| App | Notes |
|---|---|
| [Zen](https://zen-browser.app) | Firefox-based, vertical tabs, clean profile per workspace |

**Favorite site:** [fmhy.net](https://fmhy.net) — used almost daily, mainly the streaming tab.

## Security

| App | Role |
|---|---|
| [Bitwarden](https://bitwarden.com) | All passwords, API keys, PATs, secrets, and secure notes |

Bitwarden is the single vault for everything: service passwords, GitHub PATs, Cloudflare API tokens, OpenAI keys, env var secrets, SSH fingerprint notes, and recovery codes. Used via browser extension, desktop app, and `bw` CLI.

## Networking

| App | Role |
|---|---|
| [Tailscale](https://tailscale.com) | Private mesh connecting Windows, WSL2, and VPS |

No open ports needed. Tailscale handles cross-device SSH and private service access.

## VPS Management

| App | Role |
|---|---|
| [Coolify](https://coolify.io) | Self-hosted PaaS — manages all containers on the Hostinger VPS |

Coolify runs on the VPS (Hostinger KVM). All services — bots, gateways, dashboards — are deployed from the Coolify UI with no manual SSH.

## Productivity & Utilities

| App | Role |
|---|---|
| [Obsidian](https://obsidian.md) | Second brain — PARA vault at `~/brain` |
| [Microsoft PowerToys](https://github.com/microsoft/PowerToys) | Awake, Color Picker, Always on Top, Command Palette |
| [MemReduce](https://memreduct.org) | RAM trimmer — trims working set memory on demand from the tray |

### PowerToys utilities in use

- **Awake** — keeps the machine awake without touching power settings
- **Color Picker** — picks any on-screen color and copies hex/rgb
- **Always on Top** — pins any window above all others with `Win + Ctrl + T`
- **Command Palette** — quick app launch and command runner

## Capture

| App | Role |
|---|---|
| [ShareX](https://getsharex.com) | Screenshots, region capture, GIF recording |

## Windows Mods

| App | Role |
|---|---|
| [Windhawk](https://windhawk.net) | System mod loader — see `windhawk.md` |

## Cursor

Custom cursor — files at [`../assets/cursor/`](../assets/cursor/).

Apply: Control Panel → Mouse → Pointers → Browse to cursor files.
