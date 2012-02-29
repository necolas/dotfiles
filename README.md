# Dotfiles

My OS X dotfiles.

## Getting started

### Prerequisites

* Git (1.7+)
* Vim (7.3+ - I use MacVim installed with Homebrew)

### Installation

This will create symlinks for most of the files and the `vim` directory.
The `.gitconfig` file is copied to the HOME directory so that any private git 
configuration taking place in `~/.extra` is not accidentally committed.

```
git clone git://github.com/necolas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash boostrap.sh
```

N.B. This will overwrite any existing dotfiles in your HOME and .vim 
directories that have the same names as those found in this repository.

### Updating

This must be done whenever you make a change to `.gitconfig` or pull 
from the remote repo.

```
cd ~/.dotfiles
bash boostrap.sh
```


## Adding custom commands

You can use a `~/.extra` file to add custom commands without the need to fork 
this repository, or to add commands that you don’t want to commit to a public 
repository. If `~/.extra` exists, it will be sourced for inclusion in 
`bash_profile`.

Here is an example `~/.extra`:

```
# PATH exports
PATH=$PATH:~/.gem/ruby/1.8/bin
export PATH

# Git credentials
# Not under version control to prevent people from accidentally
# committing with your details
GIT_AUTHOR_NAME="Nicolas Gallagher"
GIT_AUTHOR_EMAIL="nicolas@example.com"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
# Set these credentials in ~/.gitconfig
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```


## Custom OS X defaults

When setting up a new Mac, you may want to customise your OS X defaults after 
installing the dotfiles.

```
bash .osx
```


## Adding new git submodules

If you want to add more git submodules, e.g. vim plugins to be managed by 
pathogen, then follow these steps while in the root of the superproject.

```
# Add the new submodule
git submodule add git://example.com/remote/path/to/repo.git vim/bundle/one-submodule
# Initialize the submodule
git submodule init
# Clone the submodule
git submodule update
# Stage the changes
git add vim/bundle/one-submodule
# Commit the changes
git commit -m "Add a new submodule: one-submodule"
```


## Updating git submodules

Updating individual submodules within the superproject:

```
# Change to the submodule directory
cd vim/bundle/one-submodule
# Checkout the desired branch (of the submodule)
git checkout master
# Pull from the tip of master (of the submodule - could be any sha or pointer)
git pull origin master
# Go back to main dotfiles repo root
cd ../../..
# Stage the submodule changes
git add vim/bundle/one-submodule
# Commit the submodule changes
git commit -m "Update submodule 'one-submodule' to the latest version"
# Push to a remote repository
git push origin master
```

Now, if anyone updates their local repository from the remote repository, then 
using `git submodule update` will update the submodules (that have been 
initialized) in their local repository. N.B This will wipe away any local 
changes made to those submodules.


### Acknowledgements

Inspiration and code was taken from many sources, including:

[@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens) [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
[@tejr](https://github.com/tejr) (Tom Ryder) [https://github.com/tejr/dotfiles](https://github.com/tejr/dotfiles)
[@gf3](https://github.com/gf3) (Gianni Chiappetta) [https://github.com/gf3/dotfiles](https://github.com/gf3/dotfiles)
[@cowboy](https://github.com/cowboy) (Ben Alman) [https://github.com/cowboy/dotfiles](https://github.com/cowboy/dotfiles)
