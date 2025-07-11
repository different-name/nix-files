# create/edit: nix run github:ryantm/agenix -- -e x.age
# rekey:       nix run github:ryantm/agenix -- -r
let
  keys.users = {
    # keep-sorted start block=yes newline_separated=yes
    different.hosts = {
      # keep-sorted start
      potassium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHNtFP6sku6bgMrh8fmmnuikTxObmbiRLFGQOIcm5+KD different@potassium";
      sodium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIoe3VveHt2vXoHdkRbLE0Xx5il0T3v8PiWxFvdniSLg different@sodium";
      # keep-sorted end
    };
    # keep-sorted end
  };

  userKeys = username: builtins.attrValues keys.users.${username}.hosts;
  userHostKey = username: hostName: [ keys.users.${username}.hosts.${hostName} ];
in
{
  # keep-sorted start
  "different/maocraft-discordsrv.age".publicKeys = userKeys "different";
  "different/syncthing/potassium/cert.age".publicKeys = userHostKey "different" "potassium";
  "different/syncthing/potassium/key.age".publicKeys = userHostKey "different" "potassium";
  "different/syncthing/sodium/cert.age".publicKeys = userHostKey "different" "sodium";
  "different/syncthing/sodium/key.age".publicKeys = userHostKey "different" "sodium";
  "different/tokens/cloudflare.age".publicKeys = userKeys "different";
  "different/tokens/github.age".publicKeys = userKeys "different";
  "different/user-password.age".publicKeys = userKeys "different";
  # keep-sorted end
}
