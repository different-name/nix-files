{...}: {
  home.persistence."/persist/home/different" = {
    directories = [
      "nixos-config"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/Steam"
      ".config/vesktop"
      ".cache"
      ".steam"
      ".librewolf/xg1lny11.default/storage"
      # {
      #   directory = ".local/share/Steam";
      #   method = "symlink";
      # }
    ];
    files = [
      # ".screenrc"
    ];
    allowOther = true;
  };
}
