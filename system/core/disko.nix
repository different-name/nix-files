{ inputs, ... }: {
  imports = [
    (inputs.disko.nixosModules.default (import ./nixos/hosts/lithium/disk-configuration.nix))
  ];
}