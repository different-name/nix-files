{
  lib,
  config,
  inputs,
  self',
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];

  options.dyad.programs.steam.enable = lib.mkEnableOption "steam config";

  config = lib.mkIf config.dyad.programs.steam.enable {
    programs.steam = {
      enable = true;
      protontricks = {
        enable = true;
        package = pkgs.protontricks.override {
          # newer revision with https://github.com/Winetricks/winetricks/pull/2318
          # fixes https://github.com/Matoking/protontricks/issues/286
          # can be removed once there's a new revision of winetricks
          winetricks = pkgs.winetricks.overrideAttrs {
            inherit (self'.sources.winetricks) src version;
          };
        };
      };

      extraCompatPackages = with pkgs; [
        # keep-sorted start
        proton-ge-bin
        proton-ge-rtsp-bin
        # keep-sorted end
      ];
    };

    hardware.steam-hardware.enable = true;
  };
}
