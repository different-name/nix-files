# dotfiles

> [!WARNING]
> This configuration is a work in progress, and is intended for personal use only

## todo

- switch to plasma 6, as much as i have enjoyed playing with hyprland and setting up everything how i like it, explicit sync has not been added due to the vaxry drama, and i don't think the tiling style works for my day to day usage

#### features

- format commit hook
- secrets management
- color picker
- workspaces overview
- an alias for fd that searches home or root, ignoring persisted files / folders
- per host display scale (for xwayland apps)
- persistent configs inside relevant config files
- create warning for directories in /persist that aren't being used
- mouse buttons for workspace switching
- more intuitive keybinds and workspace management

#### styling

- waybar
- locker

#### organisation

- refactor modules
    - use options instead of imports for enabling modules
    - seperate optional and global modules
- document structure on readme

#### issues
- terminal icons missing
- autologin on other ttys means that locker is ineffective
- formatter builds too often
- steam folder permissions aren't set properly on install
- vscode can't find keyring - is keyring working?
- random audio spikes - i've noticed this in spin rhythm, once human and occasionally on the desktop
- proton games set to fullscreen in the game options will freeze / black screen when switching focus
- steam and vrchat seem to freeze when gta is running (only graphically)
- monospace fonts are not monospace on github
- trashing via thunar only works on persisted directories (low priority, i don't see why i'd need to move anything else to the trash)
- make steam games fullscreen by default
- cannot login to unity hub because xdg-open cannot recognise unity hub as the default application to open unity hub links

#### general

- look into tearing https://wiki.hyprland.org/Configuring/Tearing/
- look into why steam games seem to float by default

#### wishlist

- slime vr server
- vrcx
- proton drive
- ente photos

## acknowledgements

[Misterio77](https://github.com/Misterio77/nix-starter-configs)
[fufexan](https://github.com/fufexan/dotfiles)