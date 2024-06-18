{
  inputs,
  config,
  pkgs,
  ...
}: {
  boot = {
    zfs = {
      package = pkgs.zfs_unstable;
      devNodes = "/dev/"; # Compatability for disks with no serial numbers
      forceImportAll = true; # Force import zpools at boot
    };

    # Newest kernels might not be supported by ZFS
    # Use the latest compatible kernel:
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    initrd = {
      # Roll back the root and home datasets to empty! impermanence :o
      systemd.services.rollback = {
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        unitConfig.DefaultDependencies = "no";
        wantedBy = ["initrd.target"];
        after = ["zfs-import.target"]; # Run after zfs import complete
        before = ["sysroot.mount"]; # Run before the datasets are mounted
        path = [config.boot.zfs.package];
        script = ''
          zfs rollback -r rpool/root@empty
          zfs rollback -r rpool/home@empty
        '';
      };
    };
  };
}
