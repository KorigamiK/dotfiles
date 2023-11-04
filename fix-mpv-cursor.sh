#!/usr/bin/env bash
default_user_icons_folder="$HOME/.icons/default"
mkdir -p "${default_user_icons_folder}" 2>/dev/null
#cursor_theme_name=$(gsettings get org.gnome.desktop.interface cursor-theme | cut -d "'" -f 2)
cursor_theme_name=$(dconf read /org/gnome/desktop/interface/cursor-theme | cut -d "'" -f 2)
cursor_theme_location=$(find / -name "${cursor_theme_name}" 2>/dev/null | head -n 1)
cursor_icons_location="${cursor_theme_location}/cursors"
ln -nfs "${cursor_icons_location}" "${default_user_icons_folder}/"
