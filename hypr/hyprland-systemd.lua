-- ============================================================
--  HYPRLAND  |  Catppuccin Mocha  |  systemd  |  monitor único
-- ============================================================


-- ============================================================
--  PROGRAMAS
-- ============================================================

local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi"
local mainMod     = "SUPER"


-- ============================================================
--  MONITOR (universal)
-- ============================================================

-- output vazio = regra curinga: vale para qualquer monitor, em qualquer porta.
-- Usa a resolução/taxa preferida do monitor e posiciona automaticamente.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })


-- ============================================================
--  VARIÁVEIS DE AMBIENTE
-- ============================================================

hl.env("XCURSOR_THEME", "catppuccin-mocha-dark-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-dark-cursors")
hl.env("HYPRCURSOR_SIZE", "24")

-- Sessão (os portais precisam saber que a sessão é Wayland/Hyprland)
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")


-- ============================================================
--  AUTOSTART
-- ============================================================

hl.on("hyprland.start", function()
    -- systemd: exporta o ambiente Wayland para o dbus e para os serviços de usuário.
    -- PipeWire/WirePlumber/pipewire-pulse já sobem sozinhos como serviços de usuário
    -- (se não subirem: systemctl --user enable --now pipewire pipewire-pulse wireplumber).
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP DBUS_SESSION_BUS_ADDRESS")
    hl.exec_cmd("quickshell")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("waybar")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
end)


-- ============================================================
--  APARÊNCIA E COMPORTAMENTO
-- ============================================================

hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,

        col = {
            active_border = {
                colors = { "rgba(cba6f7ee)", "rgba(b4befeee)", "rgba(89b4faee)" },
                angle  = 45,
            },
            inactive_border = "rgba(313244aa)",
        },

        resize_on_border     = true,
        hover_icon_on_border = true,
        layout               = "dwindle",
    },

    decoration = {
        rounding   = 0,
        dim_inactive = false,

        blur = {
            enabled = false,
        },

        shadow = {
            enabled = false,
        },
    },

    group = {
        col = {
            border_active          = "rgba(cba6f7ee)",
            border_inactive        = "rgba(313244aa)",
            border_locked_active   = "rgba(f38ba8ee)",
            border_locked_inactive = "rgba(45475aaa)",
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        smart_split    = false,
        smart_resizing = true,
    },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        background_color         = "rgba(1e1e2eff)",
    },

    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})


-- ============================================================
--  REGRAS DE JANELA
-- ============================================================

-- Ignora pedidos de "maximizar" feitos pelos apps (xdg_toplevel.set_maximized).
-- Sem isso, um app que restaura o estado maximizado (ex.: kitty) nasce com
-- fullscreen: 1 / fullscreenClient: 1 (FSMODE_MAXIMIZED).
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})


-- ============================================================
--  ANIMAÇÕES
-- ============================================================

-- Curvas
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1},   {0.32, 1}     } })
hl.curve("linear",       { type = "bezier", points = { {0, 0},      {1, 1}        } })
hl.curve("quick",        { type = "bezier", points = { {0.15, 0},   {0.1, 1}      } })
hl.curve("overshot",     { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05}   } })
hl.curve("smoothOut",    { type = "bezier", points = { {0.36, 0},   {0.66, -0.56} } })
hl.curve("easy",         { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- Global
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

-- Janelas
hl.animation({ leaf = "windows",     enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 5,    bezier = "overshot",     style = "popin 80%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4,    bezier = "smoothOut",    style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4,    bezier = "easeOutQuint" })

-- Fade
hl.animation({ leaf = "fade",       enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 3,    bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2,    bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4,    bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4,    bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeDim",    enabled = true, speed = 4,    bezier = "easeOutQuint" })

-- Borda (o "loop" mantém renderização contínua; desative se o uso de GPU subir)
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "easeOutQuint" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linear", style = "loop" })

-- Workspaces
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5, bezier = "easeOutQuint", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "easeOutQuint", style = "slidefadevert 20%" })

-- Layers
hl.animation({ leaf = "layers",    enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersIn",  enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "easeOutQuint", style = "fade" })


-- ============================================================
--  ATALHOS
-- ============================================================

-- ---------- Programas ----------
hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("hyprshot -m region"))

-- ---------- Janela: ações ----------
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- ---------- Foco ----------
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- ---------- Workspaces: ALT+N foca | SUPER+SHIFT+N move janela ----------
for i = 1, 10 do
    local key = i % 10
    hl.bind("ALT + " .. key,                 hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- ---------- Mouse: arrastar / redimensionar ----------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ---------- Áudio e brilho (funcionam com a tela bloqueada) ----------
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- ---------- Energia ----------
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("systemctl reboot"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("systemctl suspend"))
