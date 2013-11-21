#!/bin/bash

# Runs `git pull` on every directory within the current directory

# `find .` search the current directory
# `-type d` find only directories, not files
# `-print` print the directory name
# `-maxdepth 1` limit the depth to one sub-directory
# `-execdir {} \;` run a custom command for every directory found
# `git --git-dir={}/.git --work-tree=$PWD/{} pull` git-pull each directory

find . -type d -print -maxdepth 1 -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;
