{
  config,
  lib,
  ...
}: let
  cfg = config.services.pipewire.wireplumber.macros;
in {
  options.services.pipewire.wireplumber.macros = {
    connectPorts = lib.mkOption {
      default = [];
      description = "list of port auto-connection rules";

      type = lib.types.listOf (lib.types.submodule {
        options = {
          output = {
            subject = lib.mkOption {
              type = lib.types.str;
              description = "A string that specifies the name of a property to match";
              example = "port.alias";
            };

            leftPort = lib.mkOption {
              type = lib.types.str;
              description = "Left port object to match";
              example = "GoXLR:monitor_FL";
            };

            rightPort = lib.mkOption {
              type = lib.types.str;
              description = "Right port object to match";
              example = "GoXLR:monitor_FR";
            };
          };

          input = {
            subject = lib.mkOption {
              type = lib.types.str;
              description = "A string that specifies the name of a property to match";
              example = "port.alias";
            };

            leftPort = lib.mkOption {
              type = lib.types.str;
              description = "Left port object to match";
              example = "WiVRn:playback_1";
            };

            rightPort = lib.mkOption {
              type = lib.types.str;
              description = "Right port object to match";
              example = "WiVRn:playback_2";
            };
          };
        };
      });
    };

    defaultVolume = lib.mkOption {
      default = [];
      description = "list of node volume rules";

      type = lib.types.listOf (lib.types.submodule {
        options = {
          subject = lib.mkOption {
            type = lib.types.str;
            description = "A string that specifies the name of a property to match";
            example = "node.name";
          };

          object = lib.mkOption {
            type = lib.types.str;
            description = "Object to match";
            example = "wivrn.source";
          };

          volume = lib.mkOption {
            type = lib.types.float;
            description = "Default volume";
            example = "0.5";
          };
        };
      });
    };
  };

  config.services.pipewire.wireplumber = lib.mkMerge [
    (lib.mkIf (cfg.connectPorts != []) {
      extraConfig."99-auto-connect-ports" = {
        "wireplumber.components" = [
          {
            name = "test/auto-connect-ports.lua";
            type = "script/lua";
            provides = "custom.auto-connect-ports";
          }
        ];

        "wireplumber.profiles" = {
          main = {
            "custom.auto-connect-ports" = "required";
          };
        };
      };

      extraScripts."test/auto-connect-ports.lua" = let
        autoConnectScript = builtins.readFile ./auto-connect-ports.lua;

        genAutoConnectFunction = ports: let
          generateConstraint = portCfg: ''Constraint { "${portCfg.subject}", "matches", "${portCfg.leftPort}|${portCfg.rightPort}" }'';
        in ''
          auto_connect_ports {
            output = ${generateConstraint ports.output},
            input = ${generateConstraint ports.input},

            output_match = "${ports.output.subject}",
            input_match = "${ports.input.subject}",
            connect = {
              ["${ports.output.leftPort}"] = "${ports.input.leftPort}",
              ["${ports.output.rightPort}"] = "${ports.input.rightPort}"
            }
          }
        '';

        autoConnectFunctions =
          cfg.connectPorts
          |> map genAutoConnectFunction
          |> lib.concatStrings;
      in
        autoConnectScript + autoConnectFunctions;
    })

    (lib.mkIf (cfg.defaultVolume != []) {
      extraConfig."99-set-node-volume" = {
        "wireplumber.components" = [
          {
            name = "test/set-node-volume.lua";
            type = "script/lua";
            provides = "custom.set-node-volume";
          }
        ];

        "wireplumber.profiles" = {
          main = {
            "custom.set-node-volume" = "required";
          };
        };
      };

      # extraScripts."test/set-node-volume.lua" = ''
      #   print("Hello, world!")
      # '';

      extraScripts."test/set-node-volume.lua" = let
        autoConnectScript = builtins.readFile ./set-node-volume.lua;

        genDefaultVolumeFunction = volumeCfg: let
          inherit (volumeCfg) subject object volume;
        in ''
          set_default_volume {
            node = Constraint { "${subject}", "matches", "${object}" },
            volume = ${lib.strings.floatToString volume}
          }
        '';

        autoConnectFunctions =
          cfg.defaultVolume
          |> map genDefaultVolumeFunction
          |> lib.concatStrings;
      in
        autoConnectScript + autoConnectFunctions;
    })
  ];
}
