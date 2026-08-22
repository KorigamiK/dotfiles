-- Hyprland Lua configuration
-- https://wiki.hyprland.org/Configuring/Start/

-- Sourcing modular configuration files
require("configs.exec")
require("configs.keybinds")
require("configs.monitors")
require("configs.window_rules")

hl.config({
    general = {
        layout = "dwindle",
        gaps_in = 3,
        gaps_out = 6,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgb(7287fd)", "rgb(c6a0f6)", "rgb(ca9ee6)", "rgb(cba6f7)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
    },

    scrolling = {
        column_width = 0.6,
        focus_fit_method = 1,
    },

    cursor = {
        no_hardware_cursors = 1,
        hotspot_padding = 1,
        inactive_timeout = 1,
        no_warps = false,
        enable_hyprcursor = true,
    },

    debug = {
        disable_logs = true,
        enable_stdout_logs = false,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        repeat_rate = 40,
        repeat_delay = 160,

        follow_mouse = 1,
        numlock_by_default = true,

        touchpad = {
            natural_scroll = false,
        },

        sensitivity = 0,
    },

    gestures = {
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = true,
        workspace_swipe_forever = true,
    },

    group = {
        col = {
            border_active = "0xff89b4fa",
            border_inactive = "rgb(6c7086)",
        },
        groupbar = {
            stacked = false,
            font_family = "IBM Plex Sans Condensed",
            gaps_in = 0,
            gaps_out = 0,
            font_size = 13,
            height = 14,
            text_color = "rgb(7e9cd8)",
            col = {
                active = "rgb(6090d1)",
                inactive = "rgb(262a35)",
            },
        },
    },

    decoration = {
        rounding = 6,

        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        dim_inactive = false,
        dim_strength = 0.1,

        blur = {
            xray = false,
            special = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = false,
        smart_split = false,
        force_split = 2,
        special_scale_factor = 0.8,
    },

    master = {
        new_status = "inherit",
        orientation = "right",
        new_on_top = false,
        mfact = 0.5,
        special_scale_factor = 0.8,
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
        movefocus_cycles_fullscreen = false,
        movefocus_cycles_groupfirst = true,
    },

    render = {
        direct_scanout = 0,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        vrr = 2,
        enable_swallow = true,
        focus_on_activate = true,
        animate_mouse_windowdragging = false,
    },
})

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })

for _, leaf in ipairs({ "windowsIn", "windowsOut", "windowsMove" }) do
    hl.animation({ leaf = leaf, enabled = true, speed = 5, bezier = "wind", style = "slide" })
end

hl.animation({ leaf = "border", enabled = false })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "wind" })
hl.animation({ leaf = "workspaces", enabled = false })
hl.animation({ leaf = "fadeSwitch", enabled = false })
