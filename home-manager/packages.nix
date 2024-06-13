{ pkgs, ... }: {
    home.packages = with pkgs; [
        steam
        vesktop
        kitty
    ];
}