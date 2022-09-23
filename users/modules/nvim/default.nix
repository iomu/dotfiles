{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # appearance
      nvim-web-devicons
      indent-blankline-nvim
      lualine-nvim

      # text objects
      nvim-surround

      nvim-which-key

      # Themes
      nvim-tundra
      nvim-tokyonight

      # File Tree
      nvim-tree-lua

      # Fuzzy Finder
      telescope-fzf-native-nvim
      telescope-nvim
      cheatsheet-nvim

      # General Deps
      plenary-nvim

      # Progrmming: Treesitter
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-bash
          tree-sitter-c
          tree-sitter-css
          tree-sitter-dockerfile
          tree-sitter-elm
          tree-sitter-go
          tree-sitter-haskell
          tree-sitter-hcl
          tree-sitter-html
          tree-sitter-java
          tree-sitter-javascript
          tree-sitter-json
          tree-sitter-kotlin
          tree-sitter-latex
          tree-sitter-lua
          tree-sitter-markdown
          tree-sitter-markdown-inline
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-regex
          tree-sitter-ruby
          tree-sitter-rust
          tree-sitter-scss
          tree-sitter-toml
          tree-sitter-tsx
          tree-sitter-typescript
          tree-sitter-yaml
        ]))
      nvim-treesitter-refactor
      nvim-treesitter-textobjects


    ];

    extraPackages = with pkgs;
      [
        ripgrep
      ];

    #      luafile ${builtins.toString ./init.lua}
    extraConfig = ''
      lua require("init")
    '';
  };
  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
  };
}
