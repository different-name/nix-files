{
  nixpkgs = {
    config.allowUnfree = true;
    
    overlays = [
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
  };
}