{ pkgs, inputs, ... }: {
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

environment.systemPackages = with pkgs; [
kitty
];
}
