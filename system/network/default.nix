{inputs, ...}: {
  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
