{self, inputs, ...}: 
let 
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "different@lithium" = [
      ../. # home/default.nix
      ./lithium
    ];
  }

  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  pkgs = inpust.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "different_lithium" = homeManagerConfiguration {
        modules = homeImports."different@lithium";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}