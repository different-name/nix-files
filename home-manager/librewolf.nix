{ pkgs, ... }: {
    programs.librewolf = {
        enable = true;
        settings = {
            "privacy.resistFingerprinting.letterboxing" = true;
        };
    };

#   programs.firefox = {
#     enable = true;
#
#     profiles.different = {
#       search.engines = {
#         "Nix Packages" = {
#           urls = [{
#             template = "https://search.nixos.org/packages";
#             params = [
#               { name = "type"; value = "packages"; }
#               { name = "query"; value = "{searchTerms}"; }
#             ];
#           }];
#
#           icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
#           definedAliases = [ "@np" ];
#         };
#       };
#       search.force = true;
#     };
#   };
}