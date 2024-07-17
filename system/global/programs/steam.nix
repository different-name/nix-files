{
  pkgs,
  config,
  ...
}: let
  inherit (config.nix-files) user;
in {
  # steam will fail on first install, with the error message
  # "Fatal Error: Failed to load steamui.so" relaunching appears
  # to fix the issue and steam will continue where it left off
  programs.steam = {
    enable = true;

    # add proton GE
    extraCompatPackages = [pkgs.proton-ge-bin];

    # fix gamescope inside of steam
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
        ];
    };
  };

  # mounting the zfs datasets to ~/.steam and ~/.local/share/Steam
  # causes permission issues, so we set the correct permissions here
  systemd.tmpfiles.rules = [
    "d /home/${user}/.steam 0755 ${user} users -"
    "d /home/${user}/.local 0755 ${user} users -"
    "d /home/${user}/.local/share 0755 ${user} users -"
    "d /home/${user}/.local/share/Steam 0755 ${user} users -"
  ];
}
