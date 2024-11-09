{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.nix-files.profiles.global.enable = lib.mkEnableOption "Global profile";

  config = lib.mkIf config.nix-files.profiles.global.enable {
    programs.mosh.enable = true;

    services.fstrim.enable = true;

    nix-files = {
      core = {
        agenix.enable = true;
        boot.enable = true;
        locale.enable = true;
        networking.enable = true;
        persistence.enable = true;
        security.enable = true;
      };

      hardware = {
        fwupd.enable = true;
      };

      nix = {
        nh.enable = true;
        nix.enable = true;
        nixpkgs.enable = true;
        substituters.enable = true;
      };

      programs = {
        catppuccin.enable = true;
        ephemeral-tools.enable = true;
        fish.enable = true;
      };

      services = {
        openssh.enable = true;
        tailscale.enable = true;
      };
    };
  };
}
