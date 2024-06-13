{ inputs, ... }: {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb.layout = "us";

    services.xserver.videoDrivers = [ "amdgpu" ];
    # services.xerver.videoDrivers = [ "nvidia" ];
}
