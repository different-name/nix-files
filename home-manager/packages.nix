{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    vesktop
    kitty
    waybar
    mako
    libnotify
    swww
    rofi-wayland
    networkmanagerapplet
    imagemagick
    kdePackages.dolphin
    ani-cli
  ];
}
