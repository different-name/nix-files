{ lib, config, ... }:
let
  catppuccinPalette = lib.importJSON (config.catppuccin.sources.palette + /palette.json);
  themeColors = catppuccinPalette.${config.catppuccin.flavor}.colors;
  getColor = color: lib.removePrefix "#" themeColors.${color}.hex;

  activeColor = "ed507c";
  inactiveColor = getColor "mantle";
  alternateColor = getColor "mauve";
in
{
  config = lib.mkIf config.dyad.desktop.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = 3;
        gaps_out = 6;
        "col.active_border" = "rgb(${activeColor})";
        "col.inactive_border" = "rgba(${inactiveColor}88)";
      };

      decoration = {
        rounding = 5;
        shadow = {
          range = 8;
          render_power = 3;
          ignore_window = true;
          color = "rgba(00000055)";
        };
        dim_inactive = false;
      };

      animations = {
        enabled = true;
        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];
      };

      group = {
        "col.border_active" = "rgb(${alternateColor})";
        "col.border_inactive" = "rgba(${inactiveColor}88)";
        "col.border_locked_active" = "rgb(${activeColor})";
        "col.border_locked_inactive" = "rgba(${inactiveColor}88)";
        groupbar = {
          height = 6;
          render_titles = false;
          "col.active" = "rgb(${alternateColor})";
          "col.inactive" = "rgb(${inactiveColor})";
          "col.locked_active" = "rgb(${activeColor})";
          "col.locked_inactive" = "rgb(${inactiveColor})";
        };
      };
    };
  };
}
