{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.self.nixosModules.ephemeral-tools
  ];

  options.nix-files.parts.programs.ephemeral-tools.enable =
    lib.mkEnableOption "ephemeral-tools config";

  config = lib.mkIf config.nix-files.parts.programs.ephemeral-tools.enable {
    programs.ephemeral-tools = {
      enable = true;

      exclude-paths =
        [
          "/btrfs" # default btrfs subvolume
          "/boot" # non ephemeral
          "/run" # runtime files
          "/tmp" # temporary files
          "/var/tmp" # temporary files
          "/etc/shadow"
          "/etc/group"
          "/etc/sudoers"
          "/etc/NIXOS"
          "/etc/subuid"
          "/etc/passwd"
          "/etc/resolv.conf" # dns config
          "/etc/.clean"
          "/etc/.updated"
          "/etc/subgid"
          "/etc/ssh/authorized_keys.d" # openssh.authorizedKeys
          "/etc/fwupd/fwupd.conf" # services.fwupd
          "/etc/printcap"
          "/var/.updated"
          "/var/lib/systemd/catalog"
          "/var/lib/systemd/timers"
          "/var/lib/NetworkManager/NetworkManager-intern.conf"
          "/var/lib/NetworkManager/timestamps" # cannot be persisted as file
          "/var/lib/NetworkManager/secret_key" # cannot be persisted as file
        ]
        ++ (map (path: "/home/different/${path}") [
          # https://wiki.archlinux.org/title/XDG_Base_Directory
          ".vscode-oss" # seems to be data written by the vscode home-manager module
          ".config/VSCodium" # some subfolders are persisted, but I should have everything I need now
          ".config/fish" # can configure declaratively
          ".local/share/applications/mimeapps.list" # can configure declaratively
          ".pki" # seems to be from chromium, see above link. I haven't noticed anything wrong having this ephemeral
          ".local/share/Paradox Interactive" # across the obelisk launcher
          ".paradoxlauncher" # across the obelisk launcher
          ".local/share/mimeapps.list" # xdg mimeapps, managed in config
          ".local/share/recently-used.xbel" # recent files list used by some applications
          ".config/dconf/user" # gnome settings database
          ".local/state/lesshst" # less history file
          ".config/gtk-2.0"
          ".config/gtk-3.0"
          ".config/pulse/cookie" # pulseaudio cookie, had no issues with this being unpersisted
          ".local/state/btop.log" # just btop logs
          ".cache/Microsoft/DeveloperTools/deviceid" # probably vsc, haven't had issues being eph
        ]);
    };
  };
}
