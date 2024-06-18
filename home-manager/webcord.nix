{pkgs, ...}: {
  programs.webcord = {
    enable = true;
    package = pkgs.webcord-vencord;
    settings = {
      general = {
        menuBar.hide = true;
      };
    };
  };
}
