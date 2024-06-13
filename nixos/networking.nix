{ inputs, ... }: {
    networking = {
        hostName = "lithium";
        hostId = "3d0eee50";
        networkmanager.enable = true;
        enableIPv6 = false;
    };
}
