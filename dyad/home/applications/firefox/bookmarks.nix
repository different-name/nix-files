{ lib, config, ... }:
{
  config = lib.mkIf config.dyad.applications.firefox.enable {
    programs.firefox.profiles.default = {
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
            name = "Photos";
            url = "https://web.ente.io/gallery";
          }
          {
            name = "nix-files";
            url = "https://github.com/different-name/nix-files";
          }
          {
            # ;-; microsoft slave
            name = "ChatGPT";
            url = "https://chatgpt.com/";
          }
        ];
      };
    };
  };
}
