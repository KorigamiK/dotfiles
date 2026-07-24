#!/bin/bash

NOTES_PATH="$HOME/Documents/Syncthing/Obsidian/Origami/journal"

osascript <<APPLESCRIPT
set notesPath to "${NOTES_PATH}"

tell application "System Events"
    set zedProcs to (every process whose bundle identifier is "dev.zed.Zed")
    if (count of zedProcs) is 0 then
        do shell script "open -a /Applications/Zed.app " & quoted form of notesPath
        return
    end if

    tell item 1 of zedProcs
        try
            set w to first window whose name contains "journal"
        on error
            do shell script "open -a /Applications/Zed.app " & quoted form of notesPath
            return
        end try

        set isMin to value of attribute "AXMinimized" of w
        if isMin then
            set value of attribute "AXMinimized" of w to false
            set frontmost to true
            perform action "AXRaise" of w
        else
            set value of attribute "AXMinimized" of w to true
        end if
    end tell
end tell
APPLESCRIPT
