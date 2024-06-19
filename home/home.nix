{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.catppuccin.homeManagerModules.catppuccin
    outputs.homeManagerModules.webcord

    ./packages.nix
    ./persistence.nix
    ./hyprland.nix
    ./git.nix
    ./librewolf.nix
    ./codium.nix
    ./catppuccin.nix
    ./kitty.nix
    ./waybar.nix
    ./mako.nix
    ./fd.nix
    ./rofi.nix
  ];

  services.network-manager-applet.enable = true;
}
