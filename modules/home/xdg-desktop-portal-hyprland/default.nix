{ lib, config, ... }:
let
  inherit (lib) types;

  cfg = config.wayland.windowManager.hyprland.xdgDesktopPortalHyprland;

  valueToString = value: if builtins.isBool value then lib.boolToString value else toString value;

  generateBlock = name: attrs: ''
    ${name} {
      ${attrs |> lib.mapAttrsToList (k: v: "${k} = ${valueToString v}") |> lib.concatStringsSep "\n  "}
    }
  '';

  generateConfig =
    settings: settings |> lib.mapAttrsToList generateBlock |> lib.concatStringsSep "\n\n";
in
{
  options.wayland.windowManager.hyprland.xdgDesktopPortalHyprland = {
    settings = lib.mkOption {
      type = types.attrsOf (
        types.attrsOf (
          types.oneOf [
            # keep-sorted start
            types.bool
            types.int
            types.str
            # keep-sorted end
          ]
        )
      );
      default = { };
      description = "Configuration for xdg-desktop-portal-hyprland https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/#configuration";
      example = {
        screencopy = {
          allow_token_by_default = true;
        };
        input = {
          kb_layout = "us";
        };
      };
    };
  };

  config = lib.mkIf (config.wayland.windowManager.hyprland.enable && cfg.settings != { }) {
    xdg.configFile."hypr/xdph.conf".text = generateConfig cfg.settings;
  };
}
