let
  userKeys = [
    # sodium
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIoe3VveHt2vXoHdkRbLE0Xx5il0T3v8PiWxFvdniSLg different@sodium"
    # potassium
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmh/7dgdq32eSKcp6kwN28UF+PuyKJmvFRZKKUnyvf0 different@potassium"
    # iodine
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDFgR+CwgIILS4vhO1VFCZwpek+MKMlA/rWZbWpPnPwz iodine@iodine"
    # insert new user keys here
  ];

  rootKeys = [
    # sodium
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJcwUucfJukMLcfKPpPnfzrw7lIIJFcwW/IxIIO6w8g7 root@sodium"
    # potassium
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYQZq3ACrl2fg5pMh8YvErhigZgzOTrC/XiCk7li1tP root@potassium"
    # iodine
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkkCK33jVJn/dSsrhc3zZIyzGZ6uaKwjIKCKyu0YVpm root@iodine"
    # insert new root keys here
  ];

  keys = userKeys ++ rootKeys;
in {
  "password.age".publicKeys = keys;
  # insert new passwords here
}
