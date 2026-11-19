[README.md](https://github.com/user-attachments/files/35113491/README.md)
<div align="center">

# Hyprland-Rice

Minimalist Hyprland dotfiles featuring **Catppuccin Mocha Dark**, modular **Lua** configuration, and support for **Arch Linux**, **OpenRC** and **systemd**.

![Hyprland](https://img.shields.io/badge/WM-Hyprland-89b4fa?style=for-the-badge&logo=hyprland&logoColor=white&labelColor=1e1e2e)
![Theme](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-cba6f7?style=for-the-badge&labelColor=1e1e2e)
![Arch](https://img.shields.io/badge/Distro-Arch%20Linux-94e2d5?style=for-the-badge&logo=archlinux&logoColor=white&labelColor=1e1e2e)
![License](https://img.shields.io/badge/License-MIT-a6e3a1?style=for-the-badge&labelColor=1e1e2e)

<!-- 📸 MAIN SCREENSHOT: replace the path below with your best desktop shot -->
<!-- ![Main screenshot](assets/preview.png) -->

</div>

---

## 📸 Showcase

<img width="1920" height="1080" alt="2026-11-19-200712_hyprshot" src="https://github.com/user-attachments/assets/e79e934f-c32d-4039-b6da-2b5810a2b675" />

### Desktop

<!-- ![Desktop](assets/desktop.png) -->

### Terminal (kitty + fastfetch)

<!-- ![Terminal](assets/terminal.png) -->

### Launcher (wofi)

<!-- ![Launcher](assets/wofi.png) -->

### Status bar (waybar)

<!-- ![Waybar](assets/waybar.png) -->

### Workspaces and animations

<!-- ![Animations](assets/animations.gif) -->

---

## ✨ Features

- 🎨 **Catppuccin Mocha Dark** palette across the whole setup
- 🧩 **Lua configuration** for Hyprland, clean and commented
- 🖥️ **Universal monitor rule**: works on any single monitor, on any port
- 🐧 **Two init system variants**: `systemd` and `OpenRC`
- 🪟 Dwindle layout, gradient borders, spring-based window animations
- ⌨️ Keybindings for volume, brightness, screenshots and power management
- 🧼 No blur, no shadows, no rounding: minimal and light on the GPU

---

## 📁 Repository structure

```
Hyprland-Rice/
├── fastfetch/    # system info on the terminal
├── hypr/         # Hyprland config (systemd and OpenRC variants)
├── kitty/        # terminal emulator
├── waybar/       # status bar
├── wofi/         # application launcher
├── assets/       # screenshots and images used in this README
└── README.md
```

---

## 📦 Dependencies

Package names are for **Arch Linux** (some are in the AUR). Adjust for your distro.

| Purpose | Package |
|---|---|
| Window manager | `hyprland` |
| Terminal | `kitty` |
| File manager | `nautilus` |
| Launcher | `wofi` |
| Status bar | `waybar` |
| Shell widgets | `quickshell` (AUR) |
| Wallpaper | `waypaper` (AUR) + a backend such as `swww` or `hyprpaper` |
| Screenshots | `hyprshot` (AUR) |
| Audio | `pipewire`, `pipewire-pulse`, `wireplumber` |
| Brightness | `brightnessctl` |
| Auth agent | `polkit-gnome` |
| System info | `fastfetch` |
| Cursor theme | `catppuccin-cursors-mocha` |

Install everything at once (using `yay` as an example):

```bash
yay -S hyprland kitty nautilus wofi waybar quickshell waypaper hyprshot \
       pipewire pipewire-pulse wireplumber brightnessctl polkit-gnome \
       fastfetch catppuccin-cursors-mocha
```

> ⚠️ The Lua configuration format requires a **recent Hyprland version** with Lua support.

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/hjmligs011-bit/Hyprland-Rice.git
cd Hyprland-Rice
```

### 2. Back up your current configs

```bash
mkdir -p ~/.config-backup
cp -r ~/.config/{hypr,kitty,waybar,wofi,fastfetch} ~/.config-backup/ 2>/dev/null
```

### 3. Copy the configs

```bash
cp -r kitty waybar wofi fastfetch ~/.config/
mkdir -p ~/.config/hypr
```

### 4. Pick your init system variant

**systemd**

```bash
cp hypr/hyprland-systemd.lua ~/.config/hypr/hyprland.lua
```

**OpenRC**

```bash
cp hypr/hyprland-openrc.lua ~/.config/hypr/hyprland.lua
```

### 5. Log in

Start Hyprland from your display manager or by running `Hyprland` in a TTY.

---

## 🔀 systemd vs OpenRC

| | systemd | OpenRC |
|---|---|---|
| Audio (PipeWire) | Started by user services | Started in the Hyprland autostart |
| D-Bus environment | `dbus-update-activation-environment --systemd` | `dbus-update-activation-environment` |
| Power commands | `systemctl` | `loginctl` (requires elogind) |

If audio does not start on **systemd**, enable the user services:

```bash
systemctl --user enable --now pipewire pipewire-pulse wireplumber
```

---

## ⌨️ Keybindings

`SUPER` is the main modifier.

### Programs

| Keys | Action |
|---|---|
| `SUPER + Q` | Open terminal (kitty) |
| `SUPER + E` | Open file manager (nautilus) |
| `SUPER + D` | Open launcher (wofi) |
| `SUPER + SHIFT + U` | Screenshot of a region (hyprshot) |

### Windows

| Keys | Action |
|---|---|
| `SUPER + C` | Close window |
| `SUPER + V` | Toggle floating |
| `SUPER + F` | Fullscreen |
| `SUPER + P` | Pseudotile |
| `SUPER + J` | Toggle split |
| `SUPER + ← → ↑ ↓` | Move focus |
| `SUPER + Left mouse` | Drag window |
| `SUPER + Right mouse` | Resize window |

### Workspaces

| Keys | Action |
|---|---|
| `ALT + 1…0` | Go to workspace 1 to 10 |
| `SUPER + SHIFT + 1…0` | Move window to workspace 1 to 10 |
| `SUPER + Mouse wheel` | Next / previous workspace |

### Media and power

| Keys | Action |
|---|---|
| `XF86AudioRaiseVolume` / `LowerVolume` / `Mute` | Volume control |
| `XF86MonBrightnessUp` / `Down` | Brightness control |
| `SUPER + SHIFT + P` | Power off |
| `SUPER + SHIFT + R` | Reboot |
| `SUPER + SHIFT + H` | Suspend |

---

## 🎨 Color palette

Catppuccin Mocha colors used in the setup:

| Color | Hex |
|---|---|
| Mauve | `#cba6f7` |
| Lavender | `#b4befe` |
| Blue | `#89b4fa` |
| Red | `#f38ba8` |
| Surface 0 | `#313244` |
| Surface 1 | `#45475a` |
| Base | `#1e1e2e` |

---

## 🖼️ Wallpapers

<!-- Add a link to your wallpaper or a gallery here. -->

---

## 🛠️ Customization

- **Monitor:** edit the `hl.monitor` line in `hyprland.lua`. The default rule (`output = ""`) applies to any monitor. For multiple monitors, add one rule per output name (check them with `hyprctl monitors`).
- **Programs:** change the `terminal`, `fileManager` and `menu` variables at the top of the file.
- **Animations:** if GPU usage is high, disable the `borderangle` loop animation.
- **Keyboard layout:** change `kb_layout` in the `input` section.

---

## 🐛 Troubleshooting

| Problem | Fix |
|---|---|
| No sound | Check that `pipewire`, `wireplumber` and `pipewire-pulse` are running |
| Portals / screen sharing not working | Make sure `xdg-desktop-portal-hyprland` is installed |
| Wallpaper missing after login | Run `waypaper` once and choose a wallpaper so `--restore` has something to restore |
| Polkit prompts not appearing | Check the path of `polkit-gnome-authentication-agent-1` on your distro |

---

## 🙏 Credits

- [Hyprland](https://github.com/hyprwm/Hyprland)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Waybar](https://github.com/Alexays/Waybar)
- [Quickshell](https://quickshell.org)

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
