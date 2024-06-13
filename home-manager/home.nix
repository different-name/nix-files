# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    inputs.impermanence.nixosModules.home-manager.impermanence

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
#      outputs.overlays.unstable-packages

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
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "different";
    homeDirectory = "/home/different";
  };

      home.persistence."/persist/home/different" = {
    directories = [
      "nixos-config" 
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      # {
      #   directory = ".local/share/Steam";
      #   method = "symlink";
      # }
    ];
    files = [
      # ".screenrc"
    ];
    allowOther = true;
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    steam
    vesktop
    kitty
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Different";
    userEmail = "github.shrubs231@passmail.net";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      #env = [
      #  "WLR_NO_HARDWARE_CURSORS, 1"
      #  "WLR_RENDERER_ALLOW_SOFTWARE, 1"
      #];
      bind = ["ALT, Q, exec, kitty"];
    };
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting.letterboxing" = true;
    };
  };

#   programs.firefox = {
#     enable = true;
#
#     profiles.different = {
#       search.engines = {
#         "Nix Packages" = {
#           urls = [{
#             template = "https://search.nixos.org/packages";
#             params = [
#               { name = "type"; value = "packages"; }
#               { name = "query"; value = "{searchTerms}"; }
#             ];
#           }];
#
#           icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
#           definedAliases = [ "@np" ];
#         };
#       };
#       search.force = true;
#     };
#   };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
