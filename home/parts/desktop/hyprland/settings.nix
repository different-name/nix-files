{
  lib,
  config,
  osConfig,
  ...
}:
{
  config = lib.mkIf config.nix-files.parts.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        env = [
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "XCURSOR_SIZE,16"
          "GRIMBLAST_NO_CURSOR,0" # TODO https://github.com/fufexan/dotfiles/blob/27b78fa5e824ebcadcdb45509ca1e80aec40d50f/system/programs/hyprland/settings.nix#L11-L12
        ];

        exec-once =
          let
            uwsmCmd = lib.optionalString osConfig.programs.uwsm.enable "uwsm app -- ";
            uwsmSingleApp = cmd: "pgrep ${cmd} || ${uwsmCmd + cmd}";
          in
          map uwsmSingleApp [
            "steam -silent"
          ];

        misc = {
          disable_autoreload = true; # disable auto polling for config file changes
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          anr_missed_pings = 10;
        };

        debug.disable_logs = false;
        render.direct_scanout = false;
        xwayland.force_zero_scaling = true;

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        monitor = [
          "desc:BNQ BenQ EW3270U 5BL00174019, preferred, 0x0, 1.5" # home monitor
          ",preferred,auto,1" # everything else
        ];

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        input = {
          kb_layout = "us";

          accel_profile = "flat";

          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.5;
            disable_while_typing = false;
          };
        };

        cursor = {
          # workaround for grimblast area screenshots showing cursor
          # https://github.com/hyprwm/contrib/issues/60#issuecomment-2351538806
          # allow_dumb_copy = true;
          # removed above in favor of https://github.com/hyprwm/Hyprland/issues/8424#issuecomment-2477328413
          use_cpu_buffer = true;
          # workaround for mouse being invisible in blender
          no_hardware_cursors = true;
        };

        # touchpad gestures
        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = true;
        };
      };

      xdg-desktop-portal-hyprland.settings = {
        screencopy = {
          allow_token_by_default = true;
        };
      };
    };
  };
}
