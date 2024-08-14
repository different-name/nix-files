{
  self,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../.
  ];

  home = {
    packages = with self.packages.${pkgs.system}; [
      openvr-advanced-settings
      slimevr
    ];

    persistence."/persist${config.home.homeDirectory}".directories = [
      ".config/alvr"
      ".config/openvr"
      ".config/goxlr-utility"
      ".local/share/goxlr-utility"
    ];
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}