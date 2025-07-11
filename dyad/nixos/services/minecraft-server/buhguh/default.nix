{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.dyad.services.minecraft-server = {
    buhguh.enable = lib.mkEnableOption "buhguh minecraft server";
  };

  config = lib.mkIf config.dyad.services.minecraft-server.buhguh.enable {
    # nix-shell -p tmux --run "sudo tmux -S /run/minecraft/buhguh.sock attach"
    services.minecraft-servers.servers.buhguh = {
      enable = true;
      package = pkgs.paperServers.paper-1_21_4;

      serverProperties = {
        server-port = 25566;
        difficulty = "normal";
        spawn-protection = 0;
        view-distance = 10;
        white-list = true;
        max-players = 20;
        motd = "buhguh";
        pvp = false;
      };

      whitelist = {
        # keep-sorted start
        Di_Angelo1 = "a5268ead-ffbd-4863-9308-4de1e2766250";
        Lazy_Diffy = "be0f57d1-a79c-49d1-a126-4536c476ee51";
        Nerowy = "23b6e97d-d186-4bc2-8312-8a569013426a";
        # keep-sorted end
      };

      symlinks."server-icon.png" = ./server-icon.png;
    };

    services.cloudflare-dyndns.domains = [
      "buhguh.different-name.com"
    ];
  };
}
