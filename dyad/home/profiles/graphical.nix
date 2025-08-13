{ lib, config, ... }:
{
  options.dyad.profiles.graphical.enable = lib.mkEnableOption "graphical profile";

  config = lib.mkIf config.dyad.profiles.graphical.enable {
    dyad = {
      # keep-sorted start block=yes newline_separated=yes
      applications = {
        # keep-sorted start
        firefox.enable = true;
        kitty.enable = true;
        vscodium.enable = true;
        # keep-sorted end
      };

      desktop = {
        # keep-sorted start
        anyrun.enable = true;
        hyprland.enable = true;
        hyprlock.enable = true;
        hyprpaper.enable = true;
        mako.enable = true;
        qt.enable = true;
        xdg.enable = true;
        # keep-sorted end
      };

      media = {
        # keep-sorted start
        imv.enable = true;
        mpv.enable = true;
        # keep-sorted end
      };

      style.catppuccin.enable = true;
      # keep-sorted end
    };

    # keep-sorted start
    gtk.enable = true;
    services.playerctld.enable = true;
    # keep-sorted end

    home.perpetual.default.dirs = [
      # keep-sorted start
      "Code"
      "Documents"
      "Downloads"
      "Media"
      "Pictures"
      "Videos"
      # keep-sorted end
    ];
  };
}
