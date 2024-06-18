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
    # ./webcord.nix
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "different";
    homeDirectory = "/home/different";
  };

  # Programs with no config available
  services.network-manager-applet.enable = true;

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
