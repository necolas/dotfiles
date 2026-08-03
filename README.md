# Dotfiles (Nicolas Gallagher)

My macOS zsh-based dotfiles.

## How to install

The installation step requires the [XCode Command Line
Tools](https://developer.apple.com/downloads) and may overwrite existing
dotfiles in your HOME and `.vim` directories.

```bash
$ zsh -c "$(curl -fsSL https://raw.githubusercontent.com/necolas/dotfiles/main/bin/dotfiles)"
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
   - `~/.curlrc` → `<dotfiles>/shell/curlrc`
   - `~/.gitattributes` → `<dotfiles>/git/gitattributes`
   - `~/.gitignore` → `<dotfiles>/git/gitignore`
   - `~/.gvimrc` → `<dotfiles>/vim/gvimrc`
   - `~/.vim` → `<dotfiles>/vim`
   - `~/.vimrc` → `<dotfiles>/vim/vimrc`
   - `~/.zprofile` → `<dotfiles>/shell/zprofile`
   - `~/.zshenv` → `<dotfiles>/shell/zshenv`
10. **Adds a hook to the top of `~/.zshrc`** (see [Hooked
    files](#hooked-files))
11. **Asks for your git author identity** and writes it to `~/.gitconfig`, with an
    `[include]` of `<dotfiles>/git/gitconfig` (see [Git identity](#git-identity))
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

* You want to pull changes from the remote repository.
* You want to update Homebrew formulae.

You do **not** need to run it after editing a file in the repository. Every file
is either symlinked or included, so an edit takes effect in the next shell.

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
        <td><code>-l</code>, <code>--link</code></td>
        <td>Quick update: symlinks only (skips sync, packages, macOS)</td>
    </tr>
    <tr>
        <td><code>--macos</code></td>
        <td>Apply macOS system settings only</td>
    </tr>
</table>

### Quick updates during local development

When making local changes to your dotfiles, use the quick update mode to apply
changes without syncing or updating packages:

```bash
$ dotfiles --link
```

This refreshes the symlinks and the hooks. It never removes a line that this
repository did not write.

## How to use

### Hooked files

`~/.zshrc` and `~/.gitconfig` are real files, not symlinks. Each holds a hook at
the top that reads the dotfiles config:

| File | Hook |
|------|------|
| `~/.zshrc` | sources `shell/zshrc` |
| `~/.gitconfig` | includes `git/gitconfig` |

Other tools write to both files, and an append follows a symlink. A symlink would
send those writes into this repository.

The hook goes at the top. zsh and git both take the last value they read, so a
setting below the hook overrides a dotfiles default. Put your machine-local
settings there.

### Git identity

Your name and email live in `~/.gitconfig`. That file is not tracked, and this
repository stores no identity. The installer asks once:

```
Git author identity
  Every commit you make carries this name and email.

  Name:  
  Email: 
```

To change the identity later:

```bash
$ git config --global user.email "you@example.com"
```

`git/gitconfig` sets `user.useConfigOnly = true`. git then refuses to commit until
an identity exists, and never guesses one from the OS. So a forgotten identity
stops the commit. It cannot mislabel one.

### Local Vim configuration

Any special-case Vim directives local to a machine should be stored in a
`~/.vimrc.local` file on that machine. The directives will then be automatically
imported into your master `.vimrc`.

## Features

### Automatic software installation

Homebrew formulae:

* GNU core utilities
* [git](http://git-scm.com/)
* [node](http://nodejs.org/)
* [bun](https://bun.sh/)

### Custom macOS settings

Custom macOS settings can be applied during the `dotfiles` process. They can
also be applied independently by running:

```bash
$ dotfiles --macos
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

### Custom zsh prompt

When your current working directory is a Git repository, the prompt displays the
checked-out branch's name. During a rebase, a merge, or a bisect it also shows
the action, as `main|rebase-i`. The state of the working tree is reflected in the
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

The prompt is built on zsh's own `vcs_info`, with one `git status` call per
prompt. Further details are in the `shell/prompt` file.

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
