{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.fuse.userAllowOther = true;

  systemd.tmpfiles.rules = [
    "d /persist/home/ 1777 root root -"
    "d /persist/home/different 0700 different users -" #
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      "different" = import ../home-manager/home.nix;
    };
  };
}
