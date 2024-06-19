{...}: {
  # nh is a nix cli helper, useful for rebuilding & cleaning
  programs.nh = {
    enable = true;

    # Periodic garbage collection
    clean.enable = true;
    # Keep last 10 and anything from the last 10 days
    clean.extraArgs = "--keep-since 10d --keep 10";

    # Specify flake path here, so it does not need to be passed as arg
    flake = "/home/different/nixos-config";
  };
}
