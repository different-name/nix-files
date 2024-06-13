{ inputs, ... }: {
    boot.loader = {
        # Use the systemd-boot EFI boot loader.
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 3;
    };
}
