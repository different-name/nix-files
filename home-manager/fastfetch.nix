{ ... }: {
  # https://home-manager-options.extranix.com/?query=fastfetch&release=master
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
      }
    }
  };
}