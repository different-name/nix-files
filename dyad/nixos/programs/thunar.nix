{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.dyad.programs.thunar.enable = lib.mkEnableOption "thunar config";

  config = lib.mkIf config.dyad.programs.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
      ];
    };

    # mount, trash, and other functionalities
    services.gvfs.enable = true;

    # thumbnail support for images
    services.tumbler.enable = true;

    # archive support
    programs.file-roller.enable = true;

    home-manager.sharedModules = lib.singleton {
      xdg.mimeApps.defaultApplications = {
        "inode/directory" = lib.mkDefault "thunar.desktop";
      };

      home.perpetual.default = {
        dirs = [
          # keep-sorted start
          "$configHome/Thunar"
          "$dataHome/gvfs-metadata" # gnome virtual file system data / cache
          # keep-sorted end
        ];
        files = [
          "$configHome/xfce4/xfconf/xfce-perchannel-xml/thunar.xml"
        ];
      };
    };
  };
}
