local home = os.getenv("HOME") or ""
local scriptsDir = home .. "/.config/hypr/scripts"

local mainMod = "SUPER"
local volume = scriptsDir .. "/volume"
local screenshot = scriptsDir .. "/screenshot"
local files = "thunar"
local browser = "firefox"
local term = "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false"
local backlight = scriptsDir .. "/brightness"
local kbacklight = scriptsDir .. "/brightness-kbd"
local lock = "hyprlock"
local waybar_reload = scriptsDir .. "/waybar-reload"
local wallpaper_change = scriptsDir .. "/changeWallpaper"
local wallpaper_switcher = scriptsDir .. "/wallpaper-switcher"
local quit = scriptsDir .. "/quit"
local windows = scriptsDir .. "/windows"
local projects = scriptsDir .. "/projects.sh"
local wofi_beats = scriptsDir .. "/wofi-beats"
local terminal_classes = { ["com.mitchellh.ghostty"] = true, foot = true }

local function directional(mods, dispatcher, directions, opts)
    for key, direction in pairs(directions) do
        hl.bind(mainMod .. " + " .. mods .. key, dispatcher(direction), opts)
    end
end

local function macos_shortcut(key)
    return function()
        local window = hl.get_active_window()
        local mods = window and terminal_classes[window.class] and "CTRL SHIFT" or "CTRL"
        hl.dispatch(hl.dsp.send_shortcut({ mods = mods, key = key }))
    end
end

-- Application / utility shortcuts
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(windows))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("pgrep -x fuzzel >/dev/null && pkill -x fuzzel || fuzzel"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(quit))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 3 }))
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + KP_Enter", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(wofi_beats))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(scriptsDir .. "/yt-search"))
hl.bind(mainMod .. " + ALT + Y", hl.dsp.exec_cmd(scriptsDir .. "/suno"))
hl.bind(mainMod .. " + C", macos_shortcut("C"))
hl.bind(mainMod .. " + V", macos_shortcut("V"))
hl.bind(mainMod .. " + A", macos_shortcut("A"))

-- MPV socket controls
hl.bind(mainMod .. " + SHIFT + code:61", hl.dsp.exec_cmd("echo 'cycle pause' | socat - /tmp/mpvsocket"))
hl.bind("SHIFT + Home", hl.dsp.exec_cmd("echo 'cycle pause' | socat - /tmp/mpvsocket"))
hl.bind(mainMod .. " + SHIFT + code:60", hl.dsp.exec_cmd("echo 'playlist-next' | socat - /tmp/mpvsocket"))
hl.bind(mainMod .. " + SHIFT + code:59", hl.dsp.exec_cmd("echo 'playlist-prev' | socat - /tmp/mpvsocket"))

-- Wallpaper & Bar controls
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(wallpaper_change))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd(waybar_reload))
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(wallpaper_switcher))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("ghostty --gtk-single-instance=true -e btop"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(scriptsDir .. "/emoji"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(scriptsDir .. "/hypr-monitor"))

hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("pgrep -x focusclock >/dev/null && pkill -x -SIGTERM focusclock || " .. scriptsDir .. "/focusclock"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + I", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("hyprctl dispatch splitratio -0.3"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(projects))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(scriptsDir .. "/changeLayout"))
hl.bind(mainMod .. " + T", hl.dsp.layout("swapsplit"))

-- Pin current window
hl.bind(mainMod .. " + O", hl.dsp.window.pin())

-- Special Keys / Hot Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volume .. " --inc"), { repeating = true })
hl.bind("SHIFT + Next", hl.dsp.exec_cmd(volume .. " --inc"), { repeating = true })
hl.bind("ALT + Prior", hl.dsp.exec_cmd(volume .. " --inc"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volume .. " --dec"), { repeating = true })
hl.bind("SHIFT + Prior", hl.dsp.exec_cmd(volume .. " --dec"), { repeating = true })
hl.bind("SHIFT + Insert", hl.dsp.exec_cmd(volume .. " --toggle"))
hl.bind("ALT + Next", hl.dsp.exec_cmd(volume .. " --dec"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(volume .. " --toggle-mic"))
hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volume .. " --toggle"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(kbacklight .. " --dec"))
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd(kbacklight .. " --inc"))
hl.bind("XF86Launch3", hl.dsp.exec_cmd("asusctl led-mode -n"))
hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl profile -n"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(backlight .. " --dec"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(backlight .. " --inc"))
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd(scriptsDir .. "/touchpad.sh"))
hl.bind("XF86RFKill", hl.dsp.exec_cmd(scriptsDir .. "/airplane-mode.sh"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))

-- Window resizing
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

directional("ALT + ", function(offset)
    return hl.dsp.window.move({ x = offset[1], y = offset[2], relative = true })
end, { L = { 25, 0 }, H = { -25, 0 }, K = { 0, -25 }, J = { 0, 25 } }, { repeating = true })

-- Window swapping
directional("SHIFT + ", function(direction)
    return hl.dsp.window.swap({ direction = direction })
end, { H = "l", L = "r", K = "u", J = "d" })
directional("SHIFT + ", function(direction)
    return hl.dsp.window.move({ direction = direction })
end, { Left = "l", Right = "r", Up = "u", Down = "d" })

-- Move focus
local function focus(direction)
    return hl.dsp.focus({ direction = direction })
end

directional("", focus, { L = "r", H = "l", K = "u", J = "d" })
directional("", focus, { Left = "l", Right = "r", Up = "u", Down = "d" })

-- Switch focus between tiling and floating windows
hl.bind(mainMod .. " + space", hl.dsp.window.cycle_next({ tiled = true, floating = true }))

-- Special workspace
hl.bind(mainMod .. " + CTRL + S", hl.dsp.workspace.toggle_special("o7"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminal" }))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("terminal"))

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + CTRL + bracketleft", hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "+1", follow = true }))
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }))

-- Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "move" })
hl.gesture({ fingers = 3, direction = "down", mods = "SUPER", action = "resize" })
hl.gesture({ fingers = 3, direction = "up", scale = 1.5, action = "fullscreen" })

-- Relative workspace navigation
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Pixel window movement
directional("SHIFT + ", function(offset)
    return hl.dsp.window.move({ x = offset[1], y = offset[2], relative = true })
end, { L = { 10, 0 }, H = { -10, 0 }, K = { 0, -10 }, J = { 0, 10 } }, { repeating = true })

-- Group and focus cycling
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ last = true }))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind("ALT + Tab", hl.dsp.group.next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.group.prev())
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ out_of_group = true }))

directional("ALT + ", function(direction)
    return hl.dsp.window.move({ into_group = direction })
end, { H = "l", L = "r", K = "u", J = "d" })

hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(
    mainMod .. " + ALT + B",
    hl.dsp.exec_cmd("systemctl status bluetooth | grep -q 'active (running)' && systemctl stop bluetooth || systemctl start bluetooth")
)

-- Screenshots
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot .. " --now"))
hl.bind("SHIFT + XF86Launch2", hl.dsp.exec_cmd(screenshot .. " --mega"))
hl.bind("SHIFT + Menu", hl.dsp.exec_cmd(screenshot .. " --mega"))
hl.bind(mainMod .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --area"))
hl.bind("CTRL + Menu", hl.dsp.exec_cmd(screenshot .. " --area"))
hl.bind("ALT + Menu", hl.dsp.exec_cmd(screenshot .. " --ocr"))
hl.bind("SHIFT + CTRL + Menu", hl.dsp.exec_cmd(screenshot .. " --winhypr"))
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd(screenshot .. " --in5"))
hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd(screenshot .. " --winhypr"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --ocr"))

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pgrep -x hyprsunset >/dev/null && pkill -x -SIGTERM hyprsunset || hyprsunset -t 4500"))

-- VPN & Remote Connections
hl.bind(
    mainMod .. " + SHIFT + V",
    hl.dsp.exec_cmd(
        "nmcli -t -f NAME,TYPE connection show --active | grep -q '^iiitd_intranet' && nmcli connection down iiitd_intranet || nmcli connection up iiitd_intranet"
    )
)
hl.bind(
    mainMod .. " + ALT + V",
    hl.dsp.exec_cmd("nmcli -t -f NAME,TYPE connection show --active | grep -q '^estee' && nmcli connection down estee || nmcli connection up estee")
)
hl.bind(
    mainMod .. " + ALT + R",
    hl.dsp.exec_cmd(
        "nmcli -t -f NAME,TYPE connection show --active | grep -q '^estee' || nmcli connection up estee; remmina -c "
            .. home
            .. "/.local/share/remmina/group_rdp_main-dev_192-168-200-52.remmina"
    )
)
hl.bind(
    mainMod .. " + ALT + N",
    hl.dsp.exec_cmd(
        "nmcli -t -f NAME,TYPE connection show --active | grep -q '^estee' || nmcli connection up estee; /usr/share/NX/bin/nxplayer --session '/home/origami/Documents/NoMachine/mac dev.nxs'"
    )
)
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("systemctl start tailscaled && tailscale up && notify-send 'Tailscale started'"))
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd(home .. "/.local/bin/xhisper"))

-- Disable menu key
hl.bind("code:135", hl.dsp.no_op())
