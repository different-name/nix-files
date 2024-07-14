{...}: {
  home.persistence."/persist/home/different" = {
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
      ".config/libreoffice"
      ".config/GIMP"
    ];
    files = [];
    allowOther = true;
  };
}