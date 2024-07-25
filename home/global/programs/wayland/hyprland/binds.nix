let
  runOnce = program: "pgrep ${program} || ${program}";
in {
  wayland.windowManager.hyprland.settings = {
    # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
    # r -> release, will trigger on release of a key.
    # e -> repeat, will repeat when held.
    # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
    # m -> mouse.
    # t -> transparent, cannot be shadowed by other binds.
    # i -> ignore mods, will ignore modifiers.
    # s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
    # d -> has description, will allow you to write a description for your bind.

    bindm = [
      # use wev to find mouse button codes
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod SHIFT, mouse:273, resizewindow 1"
      "$mod CTRL, mouse:272, resizewindow"
      "$mod CTRL SHIFT, mouse:272, resizewindow 1"
    ];

    bind =
      [
        # compositor commands
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod SHIFT, F, fakefullscreen"
        "$mod, R, togglesplit,"
        "$mod, G, togglefloating,"
        "$mod, P, pseudo"
        "$mod, T, pin"
        "$mod ALT, ,resizeactive"
        "CTRL ALT, DELETE, exec, hyprctl kill"

        # utility
        ## terminal
        "$mod, Return, exec, kitty"
        ## lock screen
        "$mod, L, exec, ${runOnce "hyprlock"}"
        ## launcher
        "$mod, S, exec, rofi -show drun -show-icons"
        ## browser
        "$mod, W, exec, brave"
        ## file explorer
        "$mod, E, exec, thunar"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # screenshot
        ## area
        ", Print, exec, ${runOnce "grimblast"} --notify --freeze copy area"
        "$mod SHIFT, S, exec, ${runOnce "grimblast"} --notify --freeze copy area"
        ## current screen
        "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copy output"
        "$mod SHIFT CTRL, S, exec, ${runOnce "grimblast"} --notify --cursor copy output"

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
      ", XF86AudioPlay, exec, playerctl play-pause"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
