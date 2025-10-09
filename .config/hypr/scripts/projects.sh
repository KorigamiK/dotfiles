#!/bin/bash

projects_file="$HOME/.local/share/nvim/telescope-projects.txt"

# Extract project details from
projects=$(while IFS='=' read -r title path workspace activated last_accessed; do
  # Handle different line formats
  if [[ -n "$last_accessed" ]]; then
    echo "$title=$path=$workspace=$activated=$last_accessed"
  elif [[ -n "$activated" ]]; then
    echo "$title=$path=$workspace=$activated"
  else
    echo "$title=$path=w0=1=$last_accessed"
  fi
done <"$projects_file")

# Sort the projects based on the last accessed time (descending order)
sorted_projects=$(echo "$projects" | sort -t'=' -k5 -nr)

# Create a list of project names for dmenu
project_names=$(echo "$sorted_projects" | awk -F'=' '{print $1}' | fuzzel -d -p "Select a project:")

if [ -n "$project_names" ]; then
  project_path=$(echo "$sorted_projects" | grep "^$project_names=" | awk -F'=' '{print $2}')
  # neovide +"cd $project_path" +'lua require("telescope.builtin").find_files()'
  zeditor "$project_path"
fi
