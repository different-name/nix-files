{
  flake.nixosModules = {
    ephemeral-tools = import ./ephemeral-tools.nix;
    wireplumber-macros = import ./wireplumber-macros;
  };
}
