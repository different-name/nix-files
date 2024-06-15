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
    ani-cli
    fd
  ];
}
