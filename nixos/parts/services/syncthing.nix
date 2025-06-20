{
  lib,
  config,
  ...
}:
let
  cfg = config.nix-files.parts.services.syncthing;
in
{
  options.nix-files.parts.services.syncthing = {
    enable = lib.mkEnableOption "syncthing config";

    user = lib.mkOption {
      type = lib.types.str;
      description = "User to run syncthing as";
      example = "different";
    };

    key = lib.mkOption {
      type = lib.types.path;
      description = "Path to key file";
    };

    cert = lib.mkOption {
      type = lib.types.path;
      description = "Path to cert file";
    };
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      inherit (cfg)
        user
        key
        cert
        ;

      enable = true;

      openDefaultPorts = true;
      overrideFolders = false;
      group = "users";
      dataDir = "/home/${cfg.user}";

      settings.devices = {
        "Pico".id = "4EZ7P3H-3G2YWUM-BZDVVN2-7M3OTFZ-IL4KQP5-Z733T66-7CP6J3H-724OCAG";
      };
    };

    # don't create default ~/Sync folder
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  };
}
