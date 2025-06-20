{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  options.nix-files.parts.desktop.anyrun.enable = lib.mkEnableOption "anyrun config";

  config = lib.mkIf config.nix-files.parts.desktop.anyrun.enable {
    programs.anyrun = {
      enable = true;
      package = inputs.anyrun.packages.${pkgs.system}.default;

      config = {
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          uwsm_app
          rink
          shell
          translate
        ];

        width.fraction = 0.25;
        y.fraction = 0.45;
        hidePluginInfo = true;
        closeOnClick = true;
      };

      extraConfigFiles = {
        "uwsm_app.ron".text = ''
          Config(
            desktop_actions: false,
            max_entries: 5,
          )
        '';

        "shell.ron".text = ''
          Config(
            prefix: ">"
          )
        '';

        "translate.ron".text = ''
          Config(
            prefix: ":",
            language_delimiter: ">",
            max_entries: 3,
          )
        '';
      };

      extraCss = ''
        #window {
          background: transparent;
        }
      '';
    };
  };
}
