{self, inputs, homeImports ...}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    # core config
    inherit (import "${self}/system") desktop laptop;

    specialArgs = {inherit inputs self;};
  in {
    lithium = nixosSystem {
      inherit specialArgs;
      modules = desktop ++ [
        ./lithium

        ../system/programs/catppuccin.nix
        ../system/programs/gamemode.nix
        ../system/programs/hyprland.nix
        ../system/programs/steam.nix
        ../system/programs/thunar.nix

        ../system/services/pipewire.nix

        {
          home-manager = {
            users.different.imports = homeImports."different@lithium";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
