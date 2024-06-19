{
  imports = [
    ./core
    ./nix
    ./network
    
    ./hardware/opengl.nix
    ./hardware/fwupd.nix
    ./hardware/fstrim.nix

    ./programs
    ./programs/fonts.nix
    ./programs/home-manager.nix
    ./programs/xdg.nix
    ./programs/fish.nix
    ./programs/catppuccin.nix
    ./programs/gamemode.nix
    ./programs/hyprland.nix
    ./programs/steam.nix
    ./programs/thunar.nix

    ./services
    ./services/pipewire.nix
  ];
}