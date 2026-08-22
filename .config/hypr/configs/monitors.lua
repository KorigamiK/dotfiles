-- Monitor configuration
-- Use `hyprctl monitors` if you ever need to update a connector name or description.

local monitors = {
    { "", "preferred", "auto" },
    { "eDP-1", "1920x1080@144", "1600x0" },
    { "desc:HAS HGM-242A 0x1E3F5939", "1920x1080", "-1920x0" },
    { "desc:LG Electronics LG ULTRAGEAR 508NTUWGP582", "1920x1080@179", "0x0" },
    { "desc:Dell Inc. DELL E2016H 0HXWJ86Q1HEI", "1600x900", "-1600x0" },
    { "desc:Dell Inc. DELL E2016H 0HXWJ86P180U", "1600x900", "-1600x0" },
    { "desc:Dell Inc. DELL E2016H 0HXWJ8B22F3I", "1600x900", "0x0" },
}

for _, monitor in ipairs(monitors) do
    hl.monitor({ output = monitor[1], mode = monitor[2], position = monitor[3], scale = 1 })
end

for workspace = 1, 3 do
    hl.workspace_rule({ workspace = tostring(workspace), monitor = "DP-1" })
end
