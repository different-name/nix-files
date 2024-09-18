{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      editorconfig.editorconfig
    ];

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.startupEditor" = "none";
      "editor.fontFamily" = "'JetBrains Mono', 'monospace', monospace";
      "editor.tabSize" = 2;
      "files.enableTrash" = false;
      "window.titleBarStyle" = "custom";
      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmPasteNative" = false;

      "git.detectSubmodules" = false;
      "git.confirmSync" = false;

      # https://github.com/nix-community/vscode-nix-ide
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.serverSettings.nil.formatting.command" = ["${pkgs.alejandra}/bin/alejandra" "-" "--quiet"];
      "nix.hiddenLanguageServerErrors" = [
        # workaround for textDocument/documentSymbol errors
        # https://github.com/nix-community/vscode-nix-ide/issues/387#issuecomment-2339564317
        # https://github.com/oxalica/nil/issues/16
        "textDocument/documentSymbol"
      ];
    };
  };

  home.packages = with pkgs; [
    alejandra # formatter
    nil # nix language server
  ];

  home.persistence."/persist${config.home.homeDirectory}".directories = [
    ".config/VSCodium/CachedData"
    ".config/VSCodium/Cache"
    ".config/VSCodium/Backups"
    ".config/VSCodium/Code Cache"
    ".config/VSCodium/DawnCache"
    ".config/VSCodium/GPUCache"
    ".config/VSCodium/User/History"
    ".config/VSCodium/User/globalStorage"
    ".config/VSCodium/User/workspaceStorage"
    ".config/VSCodium/logs"
  ];
}
