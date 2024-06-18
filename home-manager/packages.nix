{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    libnotify
    swww
    networkmanagerapplet
    imagemagick
    ani-cli
    webcord-vencord
  ];
}
