{ config, pkgs, lib, inputs, ... }: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages."${builtins.currentSystem}".default;
    languages = {
      language = [{
        name = "rust";
        auto-format = true;
      }];
    };
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        auto-save = true;
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = { render = true; };
        lsp = { display-inlay-hints = true; };
      };
    };
  };

  home.packages = with pkgs; [
    # go
    go
    gopls
    delve

    # rust
    # rust-analyzer

    # bash
    nodePackages.bash-language-server

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Make
    cmake-language-server

    # Nix language server
    nil
  ];
}
