{
  lib,
  config,
  osConfig,
  ...
}: let
  runOnce = program: "pgrep ${program} || ${program}";
in {
  config = lib.mkIf config.nix-files.graphical.wayland.hyprland.enable {
    wayland.windowManager.hyprland.settings = let
      uwsm-exec = cmd:
        if osConfig.programs.uwsm.enable
        then "exec, uwsm app -- ${cmd}"
        else "exec, ${cmd}";
    in {
      # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
      # r -> release, will trigger on release of a key.
      # e -> repeat, will repeat when held.
      # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
      # m -> mouse.
      # t -> transparent, cannot be shadowed by other binds.
      # i -> ignore mods, will ignore modifiers.
      # s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
      # d -> has description, will allow you to write a description for your bind.

      "$mod" = "SUPER";

      bindm = [
        # use wev to find mouse button codes
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod CTRL, mouse:272, resizewindow"
      ];

      bind =
        [
          # compositor commands
          "$mod, Q, killactive"
          "$mod, F, fullscreenstate, 2 -1" # fullscreen the window, don't inform the client it was fullscreened
          "$mod SHIFT, F, fullscreenstate, -1 2" # keep current fullscreen state, tell client it is fullscreened
          "$mod, R, togglesplit"
          "$mod, G, togglefloating"
          "$mod, A, togglegroup"
          "$mod SHIFT, A, lockactivegroup, toggle"
          "ALT, TAB, changegroupactive, f"
          "ALT SHIFT, TAB, changegroupactive, b"
          "$mod, P, pseudo"
          "$mod, T, pin"
          "CTRL ALT, DELETE, ${uwsm-exec "hyprctl kill"}"
          "CTRL ALT SHIFT, DELETE, exec, loginctl terminate-user \"\""

          # utility
          ## terminal
          "$mod, Return, ${uwsm-exec "kitty"}"
          ## lock screen
          "$mod, L, ${runOnce "${uwsm-exec "hyprlock"}"}"
          ## launcher
          "$mod, S, ${uwsm-exec "rofi -show drun -show-icons"}"
          ## browser
          "$mod, W, ${uwsm-exec "zen"}"
          ## file explorer
          "$mod, E, ${uwsm-exec "thunar"}"

          # move focus
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # swap windows
          "$mod SHIFT, left, swapwindow, l"
          "$mod SHIFT, right, swapwindow, r"
          "$mod SHIFT, up, swapwindow, u"
          "$mod SHIFT, down, swapwindow, d"

          # screenshot
          ## area
          ", Print, ${runOnce "${uwsm-exec "grimblast"} --notify --freeze copy area"}"
          "$mod SHIFT, S, ${runOnce "${uwsm-exec "grimblast"} --notify --freeze copy area"}"
          ## current screen
          "CTRL, Print, ${runOnce "${uwsm-exec "grimblast"} --notify --cursor copy output"}"
          "$mod SHIFT CTRL, S, ${runOnce "${uwsm-exec "grimblast"} --notify --cursor copy output"}"

          # cycle workspaces
          "$mod, bracketleft, workspace, m-1"
          "$mod, bracketright, workspace, m+1"
          ",mouse:275, workspace, m-1" # two buttons on the side of my mouse
          ",mouse:276, workspace, m+1"

          # cycle monitors
          "$mod SHIFT, bracketleft, focusmonitor, l"
          "$mod SHIFT, bracketright, focusmonitor, r"

          # send focused workspace to left/right monitors
          "$mod SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
          "$mod SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

          # color picker
          "$mod SHIFT, C, ${runOnce "${uwsm-exec "hyprpicker"} --autocopy"}"
        ]
        # workspace keys
        ++ (map (ws: "$mod, ${ws}, workspace, ${ws}") ["1" "2" "3" "4" "5" "6" "7" "8" "9"])
        ++ (map (ws: "$mod SHIFT, ${ws}, movetoworkspace, ${ws}") ["1" "2" "3" "4" "5" "6" "7" "8" "9"]);

      binde = [
        # resize with arrowkeys
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
      ];

      bindl = [
        # media controls
        ", XF86AudioPlay, ${uwsm-exec "playerctl play-pause"}"

        # volume
        ", XF86AudioMute, ${uwsm-exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"}"
        ", XF86AudioMicMute, ${uwsm-exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"}"
      ];

      bindle = [
        # volume
        ", XF86AudioRaiseVolume, ${uwsm-exec "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"}"
        ", XF86AudioLowerVolume, ${uwsm-exec "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"}"

        # backlight
        ", XF86MonBrightnessUp, ${uwsm-exec "brillo -q -u 300000 -A 5"}"
        ", XF86MonBrightnessDown, ${uwsm-exec "brillo -q -u 300000 -U 5"}"
      ];
    };
  };
}
