{inputs, ...}: {
  boot.loader = {
    # Use systemd boot
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    # Skip boot options after 3 seconds
    timeout = 3;
  };

  boot.initrd = {
    # Enable systemd in initial ramdisk
    systemd.enable = true;
    # Ensure human input devices are functioning
    # We need keyboard input to enter passphrase
    availableKernelModules = ["hid_generic"];
  };
}
