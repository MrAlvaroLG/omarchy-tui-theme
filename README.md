# omarchy-tui-theme

Personal [Omarchy](https://omarchy.dev) configuration based on the **Aether** colorscheme with full TUI/terminal aesthetic applied across menus, waybar, and the screensaver.

> Built on top of [Omarchy](https://github.com/basecamp/omarchy) by Basecamp.

## Quick Install

```bash
git clone https://github.com/<your-username>/omarchy-tui-theme
cd omarchy-tui-theme
./install.sh
```

> Requires [Omarchy](https://github.com/basecamp/omarchy) to be installed first.

---

## Features

### 🎨 Aether Theme
A dark, desaturated colorscheme with warm undertones.

| Key | Value |
|-----|-------|
| Background | `#141515` |
| Foreground | `#cbc2be` |
| Accent | `#798186` |
| Border | `#4b4e55` |

Includes config files for: Alacritty, Ghostty, Kitty, Foot, Hyprland, Hyprlock, Mako, Btop, Neovim, VSCode, Waybar, Walker, Wofi, Obsidian, and more.

---

### 🪟 TUI Walker Menus
Both application launchers are redesigned with a pure terminal/TUI aesthetic:

- **Box-drawing borders** using Unicode characters (`┌ ─ ┐ │ ├ └ ┘`)
- **Embedded titles** in the top border (`┌─ Apps ─...─┐`, `┌─ Omarchy ─...─┐`)
- **Separator line** between search input and results (`├──...──┤`)
- **Keybind legend** in the bottom border (`└─ ↑ ↓ navigate   ↵ select   esc close ──┘`)
- **Monospaced font**: JetBrainsMono Nerd Font 12px
- **No border-radius** — sharp terminal look
- **Horizontal margins** on the results list so the selection highlight doesn't span edge to edge
- **Padded search input** (`padding-left: 10px`)
- All borders and ASCII chars share the same muted grey color (`alpha(@border, 0.80)`)

#### Shortcuts
| Shortcut | Menu |
|---|---|
| `SUPER + SPACE` | Apps launcher (`omarchy-default` theme) |
| `SUPER + ALT + SPACE` | Omarchy system menu (`omarchy-menu` theme) |

---

### 📊 Waybar
Custom status bar configuration:

- **JetBrainsMono Nerd Font** throughout
- **No border-radius** on any element
- Modules: workspaces, clock, weather, CPU, battery, audio, bluetooth, network, tray, Windscribe VPN indicator, keyboard layout, screen recording & idle indicators
- Vertical bar support with adaptive layout
- Custom Omarchy logo icon button (left-click: Omarchy menu, right-click: terminal)

---

### 🖥️ Screensaver
Uses `hyprlock` with a custom ASCII art splash rendered via `omarchy-branding-screensaver`.

#### 📝 Changing the screensaver ASCII art

The ASCII art is stored in:

```
~/.config/omarchy/branding/screensaver.txt
```

To change it:

**Option A — Edit directly:**
```bash
omarchy branding screensaver text
```
This opens `screensaver.txt` in your editor. Replace or modify the ASCII art, save, and the screensaver updates automatically.

**Option B — Generate from an image (PNG/SVG):**
```bash
omarchy branding screensaver image
```
Opens a file picker from `~/Pictures`. Picks a PNG or SVG and converts it to ASCII automatically.

**Option C — Reset to Omarchy default logo:**
```bash
omarchy branding screensaver reset
```

> The screensaver.txt in this repo contains **my personal name in ASCII art**. Replace it with your own using one of the methods above before using this config.

---

## Installation

> Requires [Omarchy](https://github.com/basecamp/omarchy) to be installed first.

### 1. Aether theme
```bash
cp -r theme/aether ~/.config/omarchy/themes/aether
# Then activate it:
omarchy theme set aether
```

### 2. Walker TUI themes
```bash
cp -r walker/themes/omarchy-default ~/.config/walker/themes/
cp -r walker/themes/omarchy-menu    ~/.config/walker/themes/
```

### 3. Walker override (forces TUI theme on Omarchy menu)
```bash
cp overrides/omarchy-launch-walker ~/.config/omarchy/overrides/
chmod +x ~/.config/omarchy/overrides/omarchy-launch-walker
```

### 4. Screensaver branding
```bash
cp branding/screensaver.txt ~/.config/omarchy/branding/screensaver.txt
# Or use your own (see "Changing the screensaver ASCII art" above)
```

### 5. Waybar
> ⚠️ Only copy if you want to **replace** your existing Waybar config entirely.
```bash
cp waybar/style.css    ~/.config/waybar/
cp waybar/config.jsonc ~/.config/waybar/
```

---

## File Structure

```
omarchy-tui-theme/
├── branding/
│   └── screensaver.txt          # ASCII art splash (replace with yours)
├── overrides/
│   └── omarchy-launch-walker    # Forces omarchy-menu TUI theme in dmenu mode
├── theme/
│   └── aether/                  # Full Aether colorscheme for Omarchy
│       ├── colors.toml
│       ├── walker.css
│       ├── waybar.css
│       ├── hyprland.conf
│       ├── hyprlock.conf
│       └── ...
├── walker/
│   └── themes/
│       ├── omarchy-default/     # Apps launcher (SUPER+SPACE)
│       │   ├── layout.xml
│       │   └── style.css
│       └── omarchy-menu/        # Omarchy menu (SUPER+ALT+SPACE)
│           ├── layout.xml
│           └── style.css
└── waybar/
    ├── config.jsonc
    └── style.css
```

---

## Dependencies

- [Omarchy](https://github.com/basecamp/omarchy)
- [Walker](https://github.com/abenz1267/walker) — application launcher
- [Waybar](https://github.com/Alexays/Waybar)
- [Hyprland](https://hyprland.org) + [Hyprlock](https://github.com/hyprwm/hyprlock)
- JetBrainsMono Nerd Font
