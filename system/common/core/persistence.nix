{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.nix-files.core.persistence.enable = lib.mkEnableOption "Persistence config";

  config = lib.mkIf config.nix-files.core.persistence.enable {
    environment.persistence = {
      "/persist/system" = {
        hideMounts = true;

        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/systemd/timesync"
        ];

        files = [
          "/var/lib/logrotate.status"
          "/var/lib/systemd/random-seed"
        ];
      };

      "/persist/system-cache" = {
        hideMounts = true;

        directories = [
          "/var/cache"
          "/root/.cache"
        ];
      };
    };

    # needed for home-manager impermanence to mount it's directories
    programs.fuse.userAllowOther = true;
  };
}
