{ config, pkgs, lib, inputs, ... }:
{
  programs.helix = {
    enable = true;
    package = inputs.helix.packages."${builtins.currentSystem}".default;
    languages = [
      { name = "rust"; auto-format = true; }
    ];
    settings = {
      theme = "catppuccin";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    # go
    gopls
    delve

    # rust
    rust-analyzer
  ];
}