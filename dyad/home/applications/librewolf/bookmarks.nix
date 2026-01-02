{ lib, config, ... }:
{
  config = lib.mkIf config.dyad.applications.librewolf.enable {
    programs.librewolf.profiles.default = {
      bookmarks = {
        force = true;
        settings = [
          {
            # how'd you end up here?
            name = "Jamie's Page";
            url = "https://jamies.page/";
          }
          {
            name = "YouTube";
            url = "https://www.youtube.com/";
          }
          {
            name = "Mail";
            url = "https://account.proton.me/mail";
          }
          {
            name = "Drive";
            url = "https://account.proton.me/drive";
          }
          {
            name = "Copyparty";
            url = "https://copyparty.different-name.com/";
          }
          {
            name = "Photos";
            url = "https://web.ente.io/gallery";
          }
          {
            name = "nix-files";
            url = "https://github.com/different-name/nix-files";
          }
          {
            name = "Kagi Assistant";
            url = "https://kagi.com/assistant";
          }
          "separator"
          {
            name = "My Raywhite";
            url = "https://my.raywhite.com/dashboard/home";
          }
          {
            name = "RW - One System";
            url = "https://sites.google.com/raywhite.com/raywhite-onesystem/home";
          }
          {
            name = "Monday.com";
            url = "https://raywhite816007.monday.com/";
          }
          {
            name = "Developmenti";
            url = "https://developmenti.sunshinecoast.qld.gov.au";
          }
        ];
      };
    };
  };
}
