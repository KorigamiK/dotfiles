-- Window Rules for Hyprland (Lua)
-- See https://wiki.hyprland.org/Configuring/Basics/Window-Rules/

local rule = hl.window_rule

-- Authentication and system dialogs
rule({ match = { class = "org.kde.polkit-kde-authentication-agent-1" }, float = true })
rule({ match = { class = "nm-connection-editor|blueman-manager" }, float = true })
rule({ match = { title = "Rename.+$" }, float = true })
rule({ match = { title = "Question$" }, float = true })
rule({ match = { title = "Settings$" }, float = true })
rule({ match = { class = "hu.irl.cameractrls$" }, float = true })
rule({ match = { title = "Picture-in-Picture$" }, float = true, size = { 800, 450 }, pin = true })
rule({ match = { class = "blueman-sendto$" }, float = true })
rule({ match = { class = "Nxplayer.bin$" }, allows_input = true })

-- Media and utility applications
rule({ match = { class = "swayimg|vlc|Viewnior|pavucontrol|Zotero|seahorse" }, float = true })
rule({ match = { class = "nwg-look" }, float = true })
rule({ match = { class = "qt5ct" }, float = true })
rule({ match = { class = "mpv" }, float = true, keep_aspect_ratio = true })
rule({ match = { class = "zoom" }, float = true })
rule({ match = { class = "dev.bragefuglseth.Keypunch" }, float = true, opacity = "0.9 0.7" })
rule({ match = { class = "com.belmoussaoui.Authenticator" }, float = true })
rule({ match = { class = "wofi" }, float = true, animation = "popin" })
rule({ match = { class = "qalculate-gtk" }, float = true })
rule({
    match = { class = "nz.co.mega.megasync" },
    float = true,
    stay_focused = true,
    size = { "monitor_w*0.21", "monitor_h*0.52" },
    move = { "monitor_w*0.65", "monitor_h*0.45" },
})
rule({ match = { class = "org.gnome.Shotwell" }, float = true })
rule({ match = { class = "gst-launch-1.0" }, float = true })
rule({ match = { class = "nm-openconnect-auth-dialog" }, float = true })

-- Specific application rules
rule({ match = { class = "Murl" }, float = true })
rule({ match = { class = "Emulator" }, float = true })
rule({ match = { title = "^(Firefox — Sharing Indicator)$" }, float = true, size = { 55, 26 } })
rule({ match = { class = "^(scrcpy)$" }, float = true, size = { 360, 800 } })
rule({ match = { title = "^(File Operation Progress)$" }, float = true })
rule({ match = { title = "^(Confirm to replace files)$" }, float = true })
rule({ match = { title = "^(Transfer manager)$" }, float = true })
rule({ match = { title = "^(Extract)$" }, float = true })
rule({ match = { class = "^(Steam)$" }, float = true })
rule({ match = { class = "^(PacketTracer)$" }, float = true })
rule({ match = { title = "^(Fonts)$" }, float = true })
rule({ match = { class = "showmethekey-gtk" }, float = true, pin = true, size = { 500, 100 }, move = { "monitor_w*0.735", "monitor_h*0.9" } })

-- Focus clock rules
rule({
    match = { class = "focusclock" },
    no_blur = true,
    no_anim = true,
    move = { "monitor_w*0.9", "monitor_h*0.85" },
    border_size = 0,
    pin = true,
    no_shadow = true,
    suppress_event = "activatefocus",
})

-- Application-specific movement rules
rule({ match = { title = "^(MuseScore4)$" }, move = "onscreen cursor" })

-- Loupe Image Viewer
rule({ match = { class = "^(org.gnome.Loupe)$" }, float = true, center = true })

-- Workspace assignments
rule({ match = { class = "^(com.obsproject.Studio)$" }, workspace = "4" })
rule({ match = { class = "^(Steam)$", title = "^(Steam)$" }, workspace = "5 silent" })
rule({ match = { class = "^(lutris)$" }, workspace = "5 silent" })
rule({ match = { class = "^(virt-manager)$" }, workspace = "6" })
rule({ match = { class = "^(vesktop)$" }, workspace = "5 silent" })
rule({ match = { class = "^(audacious)$" }, workspace = "9 silent" })

hl.workspace_rule({ workspace = "3", layout = "scrolling" })

-- Opacity settings
rule({ match = { class = "^(thunar)$" }, opacity = "0.8 0.7" })
rule({ match = { class = "^(code)$" }, opacity = "0.95 0.9" })
rule({ match = { class = "^(firefox)$" }, opacity = "0.95 0.90" })
rule({ match = { class = "^(org.gnome.Geary)$" }, opacity = "0.95 0.90" })
rule({ match = { class = "^(sioyek)$" }, opacity = "0.95 0.90" })

-- XWayland video bridge special handling
rule({
    match = { class = "^(xwaylandvideobridge)$" },
    opacity = "0.0 override",
    no_anim = true,
    no_initial_focus = true,
    max_size = { 1, 1 },
    no_blur = true,
    no_focus = true,
})
