{...}: {
  catppuccin = {
    enable = true;
    accent = "red";
    flavor = "mocha";
  };
  programs.fish.catppuccin.enable = true;
  programs.kitty.catppuccin.enable = true;
  programs.waybar.catppuccin.enable = true;
  services.mako.catppuccin.enable = true;
  wayland.windowManager.hyprland.catppuccin.enable = true;
}
