{ inputs, ... }: {
    # Enable sound.
    # hardware.pulseaudio.enable = true;
    # OR
    services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
    };
    sound.enable = true;
    security.rtkit.enable = true;
}
