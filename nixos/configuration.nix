{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    imports = [
        # If you want to use modules your own flake exports (from modules/nixos):
        # outputs.nixosModules.example

        # Or modules from other flakes (such as nixos-hardware):
        inputs.hardware.nixosModules.common-cpu-amd
        inputs.hardware.nixosModules.common-gpu-amd
        inputs.hardware.nixosModules.common-pc-ssd

        # You can also split up your configuration and import pieces of it here:
        ./home-manager.nix
        ./hyprland.nix
        ./audio.nix
        ./persistence.nix
        ./locale.nix
        ./networking.nix
        ./bootloader.nix
        ./zfs.nix
        ./nix-helper.nix

        # Import your generated (nixos-generate-config) hardware configuration
        ./hardware-configuration.nix
    ];

    nixpkgs = {
        overlays = [
            # Add overlays your own flake exports (from overlays and pkgs dir):
            outputs.overlays.additions
            outputs.overlays.modifications
            #      outputs.overlays.unstable-packages

            # You can also add overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default

            # Or define it inline, for example:
            # (final: prev: {
            #   hi = final.hello.overrideAttrs (oldAttrs: {
            #     patches = [ ./change-hello-to-hi.patch ];
            #   });
            # })
        ];
        config = {
            allowUnfree = true;
        };
    };

    nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
        settings = {
            # Enable flakes and new 'nix' command
            experimental-features = "nix-command flakes";
            # Opinionated: disable global registry
            flake-registry = "";
            # Workaround for https://github.com/NixOS/nix/issues/9574
            nix-path = config.nix.nixPath;
            connect-timeout = 5;
            log-lines = 25;
            min-free = 128000000;
            max-free = 1000000000;
            fallback = true;
            auto-optimise-store = true;
        };

        # Opinionated: disable channels
        channel.enable = false;

        # Opinionated: make flake registry and nix path match flake inputs
        registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
        };
        enableRedistributableFirmware = true;
    };

    services.printing.enable = true;

    environment.systemPackages = with pkgs; [
        git
    ];

    security.sudo.extraConfig = ''
      Defaults timestamp_timeout=120 # only ask for password every 2h
    '';

    users.users = {
        "different" = {
            initialPassword = "nixos";
            isNormalUser = true;
            openssh.authorizedKeys.keys = [
                # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
            ];
            extraGroups = [
                "wheel"
                "audio"
                "video"
            ];
        };
    };

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05";
}
