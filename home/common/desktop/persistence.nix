{config, ...}: {
  home.persistence."/persist${config.home.homeDirectory}" = {
    directories = [
      "Downloads"
      "Pictures"
      "Documents"
      "Videos"

      ".local/share/keyrings"
      ".local/share/direnv"
      ".config/vesktop"
      ".config/BraveSoftware/Brave-Browser"
      ".config/Slack"
      ".local/share/PrismLauncher"
      ".local/state/wireplumber"
      ".config/unityhub"
      ".config/unity3d"
      ".config/Unity"
      ".local/share/unity3d"
      ".config/blender"
      ".local/share/VRChatCreatorCompanion"
      ".config/libreoffice"
      ".config/GIMP"
      ".local/share/vulkan/" # steam shader cache files?
      ".nv" # OpenGL cache
      ".config/ente"
      ".local/share/lutris"
      ".android"
      ".config/xfce4/xfconf/xfce-perchannel-xml"
      ".config/Thunar"
      ".config/qBittorrent"
      ".local/share/qBittorrent"
    ];
    files = [];
  };
}
