{
  home = {
    persistence."/persist/home/different" = {
      directories = [
        "nix-files"
        "Downloads"
        "Pictures"
        "Documents"
        "Videos"
        ".ssh"
        ".local/share/keyrings"
        ".local/share/direnv"
        ".cache"
        ".config/vesktop"
        ".config/BraveSoftware/Brave-Browser"
        ".config/Slack"
        ".local/share/PrismLauncher"
        ".config/alvr"
        ".config/openvr"
        ".config/goxlr-utility"
        ".local/share/goxlr-utility"
        ".local/state/wireplumber"
        ".local/share/Trash"
        ".config/unityhub"
        ".config/unity3d"
        ".config/Unity"
        ".config/blender"
        ".local/share/unity3d"
        ".local/share/VRChatCreatorCompanion"
        ".config/libreoffice"
        ".config/GIMP"
        ".local/share/vulkan/" # steam shader cache files?
        ".nv" # OpenGL cache
        ".config/ente"
        ".local/share/fish"
        ".config/qalculate"
        ".local/share/qalculate"
        ".local/share/lutris"
        ".android"
      ];
      files = [
        ".bash_history"
      ];
      allowOther = true;
    };
  };
}