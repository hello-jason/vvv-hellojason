#!/bin/bash
# Version 0.0.1
# Last Update: June 10, 2016
#
# Description: TODO
#
########################################
# Files to symlink
########################################
files_to_symlink=(
  provision-post.sh
  provision-pre.sh
  Customfile
)

########################################
# Ask for operating system
########################################
ask_operating_system() {
  echo "What is your host operating system?"
  echo -e "1 - *nix\n2 - Windows"
  read operating_system_input

  if [ $operating_system_input == 1 ]; then
    operating_system = "nix"
    echo "You are using: nix"
  elif [ $operating_system_input == 2 ]; then
    operating_system = "windows"
    echo "You are using: Windows"
  else
    echo "Incorrect response."
    exit 1
  fi
}

########################################
# Symlink scripts
########################################
symlink_files_nix() {
  local file_to_symlink

  for file_to_symlink in "${files_to_symlink[@]}"; do
    ln --symbolic TARGET file_to_symlink
  done
}

########################################
# Run program
########################################
ask_operating_system
