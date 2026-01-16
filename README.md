# Dotfiles (Nicolas Gallagher)

My macOS dotfiles.

## How to install

The installation step requires the [XCode Command Line
Tools](https://developer.apple.com/downloads) and may overwrite existing
dotfiles in your HOME and `.vim` directories.

```bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/necolas/dotfiles/master/bin/dotfiles)"
```

N.B. If you wish to fork this project and maintain your own dotfiles, you must
substitute my username for your own in the above command and the 2 variables
found at the top of the `bin/dotfiles` script.

### What the installation does

The installation script performs the following steps in order:

1. **Prompts for install location** (defaults to `~/.dotfiles`, or uses existing config)
2. **Saves config** to `~/.config/dotfiles/config` for future runs
3. **Downloads the repository** to your chosen location (if not already present)
4. **Installs Homebrew** (if not already installed)
5. **Installs Git** via Homebrew (if not already installed)
6. **Initializes a Git repository** and connects it to the remote
7. **Syncs** with the remote repository to get the latest changes
8. **Installs packages** via Homebrew
9. **Creates symlinks** from your home directory to the dotfiles:
   - `~/.bash_profile` → `<dotfiles>/shell/bash_profile`
   - `~/.inputrc` → `<dotfiles>/shell/inputrc`
   - `~/.gitignore` → `<dotfiles>/git/gitignore`
   - `~/.vim` → `<dotfiles>/vim`
10. **Copies** `<dotfiles>/git/gitconfig` to `~/.gitconfig` (not symlinked to allow local git credentials)
11. **Creates** `~/.bash_profile.local` from template (if it doesn't exist)
12. **Applies macOS defaults** (optional, with confirmation prompt)

### Custom install location

On first run, the script will prompt you for an install location:

```
Where would you like to install dotfiles?
Install location [~/.dotfiles]: ~/Code/dotfiles
```

Press Enter to accept the default (`~/.dotfiles`) or enter a custom path.
The chosen location is saved to `~/.config/dotfiles/config` and used for all
future runs.

## How to update

You should run the update when:

* You make a change to `~/.dotfiles/git/gitconfig` (the only file that is
  copied rather than symlinked).
* You want to pull changes from the remote repository.
* You want to update Homebrew formulae and Node packages.

Run the dotfiles command:

```bash
$ dotfiles
```

Options:

<table>
    <tr>
        <td><code>-h</code>, <code>--help</code></td>
        <td>Help</td>
    </tr>
    <tr>
        <td><code>--no-packages</code></td>
        <td>Suppress package updates</td>
    </tr>
    <tr>
        <td><code>--no-sync</code></td>
        <td>Suppress pulling from the remote repository</td>
    </tr>
</table>

## How to use

### Local/private Bash and Vim configuration

Any special-case Vim directives local to a machine should be stored in a
`~/.vimrc.local` file on that machine. The directives will then be automatically
imported into your master `.vimrc`.

Any private and custom Bash commands and configuration should be placed in the
`~/.bash_profile.local` file. This file will not be under version control or
committed to a public repository. If `~/.bash_profile.local` exists, it will be
sourced for inclusion in `bash_profile`.

N.B. Because the `git/gitconfig` file is copied to `~/.gitconfig`, any private
git configuration specified in `~/.bash_profile.local` will not be committed to
your dotfiles repository.

## Features

### Automatic software installation

Homebrew formulae:

* GNU core utilities
* [git](http://git-scm.com/)
* [git-delta](https://github.com/dandavison/delta) (syntax-highlighting pager for git)
* [bash-completion](http://bash-completion.alioth.debian.org/)
* [node](http://nodejs.org/)

### Custom macOS settings

Custom macOS settings can be applied during the `dotfiles` process. They can
also be applied independently by running the following command:

```bash
$ macos
```

### Bootable backup-drive script

These dotfiles include a script that uses `rsync` to incrementally back up your
data to an external, bootable clone of your computer's internal drive. First,
make sure that the value of `DST` in the `bin/backup` script matches the name
of your backup-drive. Then run the following command:

```bash
$ backup
```

For more information on how to setup your backup-drive, please read the
preparatory steps in this post on creating a [bootable macOS backup
drive](http://nicolasgallagher.com/mac-osx-bootable-backup-drive-with-rsync/).

### Custom bash prompt

When your current working directory is a Git repository, the prompt will
display the checked-out branch's name (and failing that, the commit SHA that
HEAD is pointing to). The state of the working tree is reflected in the
following way:

<table>
    <tr>
        <td><code>+</code></td>
        <td>Uncommitted changes in the index</td>
    </tr>
    <tr>
        <td><code>!</code></td>
        <td>Unstaged changes</td>
    </tr>
    <tr>
        <td><code>?</code></td>
        <td>Untracked files</td>
    </tr>
    <tr>
        <td><code>$</code></td>
        <td>Stashed files</td>
    </tr>
</table>

Further details are in the `bash_prompt` file.

## Acknowledgements

Inspiration and code was taken from many sources, including:

* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
  [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [@tejr](https://github.com/tejr) (Tom Ryder)
  [https://github.com/tejr/dotfiles](https://github.com/tejr/dotfiles)
* [@gf3](https://github.com/gf3) (Gianni Chiappetta)
  [https://github.com/gf3/dotfiles](https://github.com/gf3/dotfiles)
* [@cowboy](https://github.com/cowboy) (Ben Alman)
  [https://github.com/cowboy/dotfiles](https://github.com/cowboy/dotfiles)
* [@alrra](https://github.com/alrra) (Cãtãlin Mariş)
  [https://github.com/alrra/dotfiles](https://github.com/alrra/dotfiles)
