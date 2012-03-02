#!/bin/bash

cd "${HOME}/.dotfiles"

# Pull down the latest changes
# git pull origin master

# Check out submodules
git submodule --quiet update --init

cd "${OLDPWD}"

function mirrorfiles() {
    # Copy .gitconfig
    # Any global git commands in ~/.extra will be written to .gitconfig
    # This prevents them being committed to the repository
    rsync -avz --quiet ${HOME}/.dotfiles/git/gitconfig  ${HOME}/.gitconfig

    # Symlink everything else
    # bash_profile sources other files from the repository
    # Force remove the vim directory if it is already there
    if [ -e "${HOME}/.vim" ]; then
        rm -rf "${HOME}/.vim"
    fi
    ln -fs ".dotfiles/osx"                "${HOME}/.osx"
    ln -fs ".dotfiles/bash/bashrc"        "${HOME}/.bashrc"
    ln -fs ".dotfiles/bash/bash_profile"  "${HOME}/.bash_profile"
    ln -fs ".dotfiles/bash/inputrc"       "${HOME}/.inputrc"
    ln -fs ".dotfiles/git/gitattributes"  "${HOME}/.gitattributes"
    ln -fs ".dotfiles/git/gitignore"      "${HOME}/.gitignore"
    ln -fs ".dotfiles/vim"                "${HOME}/.vim"
    ln -fs ".dotfiles/vim/gvimrc"         "${HOME}/.gvimrc"
    ln -fs ".dotfiles/vim/vimrc"          "${HOME}/.vimrc"

    echo "Dotfiles update complete"
}

read -p "This will overwrite some existing files in your home directory. Are you sure? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mirrorfiles
    source ~/.bash_profile
fi
