{lib, ...}: {
  imports = [
    ./boot.nix
    ./locale.nix
    ./persistence.nix
    ./security.nix
    ./users.nix
    ./zfs.nix
  ];
}