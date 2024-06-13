{
    inputs,
    config,
    pkgs,
    ...
}: {
    boot = {
        zfs = {
            package = pkgs.zfs_unstable;
            devNodes = "/dev/";
            forceImportAll = true;
        };
        kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

        initrd = {
            availableKernelModules = ["hid_generic"];
            systemd.enable = true;
            systemd.services.rollback = {
                serviceConfig = {
                    Type = "oneshot";
                    RemainAfterExit = true;
                };
                unitConfig.DefaultDependencies = "no";
                wantedBy = ["initrd.target"];
                after = ["zfs-import.target"];
                before = ["sysroot.mount"];
                path = [config.boot.zfs.package];
                script = ''
                  zfs rollback -r rpool/root@empty
                  zfs rollback -r rpool/home@empty
                '';
            };
        };
    };
}
