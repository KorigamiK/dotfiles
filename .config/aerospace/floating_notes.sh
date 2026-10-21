#!/bin/bash
set -euo pipefail

# AeroSpace must own focus changes; AXRaise alone can leave its focus stale.
journal_window_id() {
    aerospace list-windows --monitor all --app-bundle-id dev.zed.Zed \
        --format '%{window-id}|%{window-title}' |
        awk -F '|' '$2 == "journal" || $2 ~ /^journal —/ { print $1; exit }'
}

if [[ "${1:-}" == "aerospace" ]]; then
    journal_id=$(journal_window_id)
    if [[ -n "$journal_id" ]]; then
        if [[ "$(aerospace list-windows --focused --format '%{window-id}')" == "$journal_id" ]]; then
            # Hand focus back before minimizing, while focus history is intact.
            if ! aerospace focus-back-and-forth; then
                fallback_id=$(aerospace list-windows --workspace focused --format '%{window-id}' |
                    awk -v journal="$journal_id" '$0 != journal { print; exit }')
                if [[ -n "$fallback_id" ]]; then
                    aerospace focus --window-id "$fallback_id"
                fi
            fi
            aerospace macos-native-minimize --window-id "$journal_id"
        else
            aerospace layout --window-id "$journal_id" floating
            aerospace focus --window-id "$journal_id"
        fi
        exit
    fi
fi

# Restore minimized windows through macOS; also retain the standalone Rift toggle.
action=$(/usr/bin/osascript <<'APPLESCRIPT'
tell application "System Events"
    set zedProcesses to every process whose bundle identifier is "dev.zed.Zed"
    if zedProcesses is {} then return "open"

    tell item 1 of zedProcesses
        set notesWindows to every window whose name is "journal" or name starts with "journal —"
        if notesWindows is {} then return "open"

        set notesWindow to item 1 of notesWindows
        if frontmost and (value of attribute "AXMain" of notesWindow) and not (value of attribute "AXMinimized" of notesWindow) then
            set value of attribute "AXMinimized" of notesWindow to true
        else
            set value of attribute "AXMinimized" of notesWindow to false
            set frontmost to true
            perform action "AXRaise" of notesWindow
        end if
    end tell
end tell
APPLESCRIPT
)

# Explicitly create a dedicated window, regardless of Zed's CLI defaults.
if [[ "$action" == "open" ]]; then
    /Applications/Zed.app/Contents/MacOS/cli --new "$HOME/Documents/Syncthing/Obsidian/Origami/journal"
fi

if [[ "${1:-}" == "aerospace" ]]; then
    # Allow the newly opened/restored window to become managed before focusing it.
    for ((attempt = 0; attempt < 40; attempt++)); do
        journal_id=$(journal_window_id)
        if [[ -n "$journal_id" ]]; then
            # Reapply on every restore; the detection rule only handles new windows.
            aerospace layout --window-id "$journal_id" floating
            exec aerospace focus --window-id "$journal_id"
        fi
        sleep 0.05
    done
    echo 'Journal window did not become available to AeroSpace' >&2
    exit 1
fi
