{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.nix-files.parts.system.persistence;

  usernames = config.nix-files.users |> lib.filterAttrs (name: value: value.enable) |> lib.attrNames;
  setHomeCfg = config: lib.genAttrs usernames (name: config);
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.nix-files.parts.system.persistence = {
    enable = lib.mkEnableOption "persistence config";

    # we accept a list of anything so that impermanence will handle the typing instead
    # this is less maintenance in the event impermemance changes typing
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.anything;
      default = [ ];
      description = "directories to pass to persistence config";
    };

    files = lib.mkOption {
      type = lib.types.listOf lib.types.anything;
      default = [ ];
      description = "files to pass to persistence config";
    };

    home = {
      directories = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [ ];
        description = "directories to pass to home-manager persistence config";
      };

      files = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [ ];
        description = "files to pass to home-manager persistence config";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.persistence."/persist/system" = {
      inherit (cfg) directories files;
      hideMounts = true;
    };

    home-manager.users = setHomeCfg {
      nix-files.parts.system.persistence = {
        inherit (cfg.home) directories files;
      };
    };

    # required for impermanence to work
    fileSystems."/persist".neededForBoot = true;

    # needed for home-manager impermanence to mount it's directories
    programs.fuse.userAllowOther = true;
  };
}
