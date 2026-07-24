#!/bin/bash

TITLE="FLOATING_NOTES"
HIDDEN_WS="HIDDEN"

# Find the floating notes window by title
WINDOW_ID=$(aerospace list-windows --all --format '%{window-id}%{tab}%{window-title}' \
    | grep "	${TITLE}$" \
    | cut -f1 \
    | head -1)

# Check if the floating notes window is opened up, if not, open it and exit
if [ -z "$WINDOW_ID" ]; then
    open -n /Applications/Ghostty.app
    exit 0
fi

# Get workspace for the floating notes window
CURRENT_WS=$(aerospace list-windows --all --format '%{window-id}%{tab}%{workspace}' \
    | grep "^${WINDOW_ID}	" \
    | cut -f2)

FOCUSED_WS=$(aerospace list-workspaces --focused)

if [ "$CURRENT_WS" = "$FOCUSED_WS" ]; then
    # It is currently here -> Hide it
    aerospace move-node-to-workspace --window-id "$WINDOW_ID" "$HIDDEN_WS"
else
    # It is NOT here (either hidden or on another screen) -> Summon it
    aerospace move-node-to-workspace --window-id "$WINDOW_ID" "$FOCUSED_WS"
    aerospace focus --window-id "$WINDOW_ID"
fi
