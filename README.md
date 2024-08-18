# dotfiles

## Softwares I currently use
- [Alacritty](https://github.com/alacritty/alacritty)
- [Tmux](https://github.com/tmux/tmux)
- [fish shell](https://github.com/fish-shell/fish-shell)
- [Starship](https://github.com/starship/starship)
- ~~[xbanish](https://github.com/jcs/xbanish) (`xbanish -i all &` on startup)~~ (I moved to Wayland, doesn't work on it :disappointed:)
- [keyd](https://github.com/rvaiya/keyd)

---

## Docs

I'm using GNU Stow for managing my dotfiles and configs. Docs below is just some notes for future
me. If you want to learn how to use GNU Stow for dotfile managment you can checkout these links:
- [Blog post by Bastian Venthur](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)
- [Youtube video from Dreams of Autonomy](https://youtu.be/y6XCebnB9gs)
- [Youtube video from DevInsideYou](https://youtu.be/CFzEuBGPPPg)

### Install

**Hint:** Use `-n` option with stow to prevent making changes if you are not sure.

```
$ sudo dnf install stow

$ git clone https://github.com/berk-karaal/dotfiles.git
$ cd dotfiles
$ pwd 
/home/berk/dotfiles

# install configs under home path
$ stow -v . --dir=/home/berk/dotfiles/home/ --target=/home/berk/

# install configs under /etc
$ sudo stow -v . --dir=/home/berk/dotfiles/etc/ --target=/etc/
```

### Add existing config file to this project folder

Create an empty file in this project folder with the same name and path as the file you wanted to
use with stow. Then run stow command with `--adopt` option. It will first overwrite the empty file
you created with the current config file, then it will replace original config file with a symlink
to the file in this project folder.

#### Example:

**Aim:** I want to move my `/home/berk/.config/myProgram/myConfig.conf` file to this repo and use it
with stow.

> In this example, project folder is at this path: `/home/berk/dotfiles`

1. Create an empty `myConfig.conf` file inside the project folder.
   
   ```
   $ mkdir /home/berk/dotfiles/home/.config/myProgram
   $ touch /home/berk/dotfiles/home/.config/myProgram/myConfig.conf
   ```

2. Run stow command with `--adopt` option.
   > You may want to run this command with `-n` option first to see what will happen.
   ```
   $ stow --adopt -v . --dir=/home/berk/dotfiles/home/ --target=/home/berk
   ```
   This command will recognize myConfig.conf file and it will notice it's not symlinked to our
   project folder (dir option). So it will first overwrite the file in the project folder, then it
   will convert original file to a symlink which is linked to the overwritten file.

