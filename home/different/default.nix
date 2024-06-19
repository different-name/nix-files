{inputs, pkgs, ...}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin

    ../. # home

    ./persistence.nix
    ./terminal/git.nix
    ./programs/hyprland.nix
    ./programs/librewolf.nix
    ./programs/codium.nix
    ./programs/catppuccin.nix
    ./terminal/kitty.nix
    ./programs/waybar.nix
    ./services/mako.nix
    ./terminal/fd.nix
    ./programs/rofi.nix
  ];

  home.packages = with pkgs; [
    steam
    libnotify
    swww
    networkmanagerapplet
    imagemagick
    ani-cli
    webcord-vencord
  ];

  home = {
    username = "different";
    homeDirectory = "/home/different";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}