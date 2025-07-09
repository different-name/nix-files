{
  lib,
  config,
  osConfig,
  self',
  pkgs,
  ...
}:
let
  inherit (lib) types;

  cfg = config.dyad.games.xr;
in
{
  options.dyad.games.xr = {
    enable = lib.mkEnableOption "xr config";

    enterVrHook = lib.mkOption {
      type = types.str;
      default = "";
      description = "Command to run before entering VR";
    };

    exitVrHook = lib.mkOption {
      type = types.str;
      default = "";
      description = "Command to run after exiting VR";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.desktopEntries =
      let
        vr-session-manager = pkgs.writeShellApplication {
          name = "vr-session-manager";
          runtimeInputs = with pkgs; [
            libnotify
            systemd
            config.wayland.windowManager.hyprland.package
          ];
          text =
            builtins.readFile ./vr-session-manager.sh
            |>
              lib.replaceStrings
                [
                  "# __ENTER_VR_HOOK__"
                  "# __EXIT_VR_HOOK__"
                ]
                [
                  cfg.enterVrHook
                  cfg.exitVrHook
                ];
        };

        baseEntry = {
          type = "Application";
          terminal = false;
          categories = [ "Utility" ];
          startupNotify = false;
        };
      in
      {
        start-vr-session = {
          name = "Start VR Session";
          exec = "${lib.getExe vr-session-manager} start";
        } // baseEntry;

        stop-vr-session = {
          name = "Stop VR Session";
          exec = "${lib.getExe vr-session-manager} stop";
        } // baseEntry;
      };

    # https://lvra.gitlab.io/docs/distros/nixos/#recommendations
    xdg.configFile."openvr/openvrpaths.vrpath" = {
      text = ''
        {
          "config" :
          [
            "~/.local/share/Steam/config"
          ],
          "external_drivers" : null,
          "jsonid" : "vrpathreg",
          "log" :
          [
            "~/.local/share/Steam/logs"
          ],
          "runtime" :
          [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version" : 1
        }
      '';
      force = true;
    };

    # https://github.com/galister/wlx-overlay-s/wiki
    xdg.configFile."wlxoverlay" = {
      source = ./wlx-overlay-s;
      recursive = true;
      force = true;
    };

    # https://lvra.gitlab.io/docs/fossvr/opencomposite/#rebinding-controls
    xdg.dataFile =
      let
        steamDir = "Steam/steamapps/common";
      in
      {
        "${steamDir}/VRChat/OpenComposite/oculus_touch.json".source =
          ./opencomposite/vrchat/oculus_touch.json;
      };

    xdg.configFile."VRCX/custom.css".source =
      self'.packages.catppuccin-vrcx-mocha + /share/vrcx-catppuccin.css;

    # TODO temporary workaround until https://www.github.com/hyprwm/xdg-desktop-portal-hyprland/issues/329 is implemented properly
    wayland.windowManager.hyprland.xdgDesktopPortalHyprland.settings = {
      screencopy = {
        custom_picker_binary = lib.getExe (
          pkgs.writeShellApplication {
            name = "hyprland-share-picker-xr";
            runtimeInputs = [ osConfig.programs.hyprland.portalPackage ];
            text = builtins.readFile ./hyprland-share-picker-xr.sh;
          }
        );
      };
    };

    home.perpetual.default = {
      packages = {
        # keep-sorted start block=yes newline_separated=yes
        osc-goes-brrr = {
          package = self'.packages.osc-goes-brrr;
          dirs = [
            "$configHome/OscGoesBrrr"
          ];
        };

        slimevr-cli.package = self'.packages.slimevr-cli;

        slimevr = {
          # https://github.com/tauri-apps/tauri/issues/9394
          package = pkgs.symlinkJoin {
            name = "slimevr";
            paths = [ pkgs.slimevr ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/slimevr \
                --set WEBKIT_DISABLE_DMABUF_RENDERER 1
            '';
          };
          dirs = [
            # keep-sorted start
            "$cacheHome/.slimevr-wrapped_"
            "$configHome/dev.slimevr.SlimeVR"
            "$dataHome/.slimevr-wrapped_"
            "$dataHome/dev.slimevr.SlimeVR"
            # keep-sorted end
          ];
        };

        vrcx.dirs = [
          "$configHome/VRCX"
        ];

        wlx-overlay-s.dirs = [
          "$configHome/wlxoverlay"
        ];
        # keep-sorted end
      };

      dirs = [
        # keep-sorted start
        "$cacheHome/wivrn"
        "$configHome/openvr"
        "$configHome/wivrn"
        "$stateHome/OpenComposite"
        # keep-sorted end
      ];
    };
  };
}
