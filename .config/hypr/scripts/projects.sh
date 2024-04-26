#!/bin/bash

CONFIG="$HOME/.config/hypr/wofifull/config"
projects_file="$HOME/.local/share/nvim/telescope-projects.txt"

projects=$(sed 's/=.*//' $projects_file)

selected_project=$(echo "$projects" | wofi -d --conf ${CONFIG} -p "Select a project:")

project_path=$(grep "^$selected_project=" $projects_file | cut -d'=' -f2)

if [ -n "$project_path" ]; then
  footclient -e nvim +"cd $project_path" +'lua require("telescope.builtin").find_files()'
fi
