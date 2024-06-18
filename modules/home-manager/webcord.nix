{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.webcord;

  jsonFormat = pkgs.formats.json {};

  configDir = "WebCord";
  userDir = "${config.xdg.configHome}/${configDir}";
  configFilePath = "${userDir}/config.json";

  defaultConfig = {
    settings = {
      general = {
        menuBar.hide = false;
        tray.disable = false;
        taskbar.flash = true;
        window = {
          transparent = false;
          hideOnClose = true;
        };
      };
      privacy = {
        blockApi = {
          science = true;
          typingIndicator = false;
          fingerprinting = true;
        };
        permissions = {
          video = null;
          audio = false;
          fullscreen = true;
          notifications = false;
          display-capture = true;
          background-sync = false;
        };
      };
      advanced = {
        csp.enabled = true;
        cspThirdParty = {
          spotify = true;
          gif = true;
          hcaptcha = true;
          youtube = true;
          twitter = true;
          twitch = true;
          streamable = true;
          vimeo = true;
          soundcloud = true;
          paypal = true;
          audius = true;
          algolia = true;
          reddit = true;
          googleStorageApi = true;
        };
        currentInstance.radio = 0;
        devel.enabled = false;
        redirection.warn = true;
        optimize.gpu = false;
        webApi.webGl = true;
        unix.autoscroll = false;
      };
    };
    update = {
      notification = {
        version = "";
        till = "";
      };
    };
    screenShareStore.audio = false;
  };
in {
  options.programs.webcord = {
    enable = mkEnableOption "WebCord";

    package = mkOption {
      type = types.package;
      default = pkgs.webcord;
      defaultText = literalExpression "pkgs.webcord";
      example = literalExpression "pkgs.webcord-vencord";
      description = ''
        Version of WebCord to install.
      '';
    };

    settings = mkOption {
      type = jsonFormat.type;
      default = defaultConfig.settings;
      example = literalExpression ''
        {
          general = {
            menuBar.hide = false;
            tray.disable = false;
          };
        }
      '';
      description = ''
        Configuration written to WebCord's
        ${file}`config.json`.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    home.file."${configFilePath}".source = jsonFormat.generate "webcord-settings" (
      recursiveUpdate defaultConfig {settings = cfg.settings;}
    );
  };
}
