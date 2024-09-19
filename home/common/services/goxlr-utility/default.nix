{
  lib,
  config,
  ...
}: {
  options.nix-files.services.goxlr-utility.enable = lib.mkEnableOption "GoXLR-utility config";

  config = lib.mkIf config.nix-files.services.goxlr-utility.enable {
    home = {
      file.".local/share/goxlr-utility/mic-profiles/procaster.goxlrMicProfile" = {
        source = ./procaster.goxlrMicProfile;
      };

      persistence."/persist${config.home.homeDirectory}".directories = [
        ".config/goxlr-utility"
        ".local/share/goxlr-utility"
      ];
    };
  };
}