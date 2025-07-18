{ lib, config, ... }:
{
  options.dyad.profiles.minimal.enable = lib.mkEnableOption "minimal profile";

  config = lib.mkIf config.dyad.profiles.minimal.enable {
    dyad = {
      system = {
        # keep-sorted start
        agenix.enable = true;
        perpetual.enable = true;
        # keep-sorted end
      };
    };
  };
}
