{ pkgs, inputs, ... }:

let
  nvim-surround = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-surround";
    src = inputs.nvim-surround-src;
  };
  nvim-tundra = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-tundra";
    src = inputs.nvim-tundra-src;
  };
  nvim-which-key = pkgs.vimUtils.buildVimPlugin {
    name = "which-key.nvim";
    src = inputs.nvim-which-key-src;
  };
  nvim-tokyonight = pkgs.vimUtils.buildVimPlugin {
    name = "tokyonight.nvim";
    src = inputs.nvim-tokyonight-src;
  };
  nvim-lspsaga = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-lspsaga";
    src = inputs.nvim-lspsaga-src;
    buildInputs = [ pkgs.lua53Packages.busted ];
  };
  nvim-auto-save = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-auto-save";
    src = inputs.nvim-auto-save-src;
  };
  nvim-local-history = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-local-history";
    src = inputs.nvim-local-history-src;
  };
  nvim-ts-context-commentstring = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-ts-context-commentstring";
    src = inputs.nvim-ts-context-commentstring-src;
  };
  nvim-tree-climber = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-tree-climber";
    src = inputs.nvim-tree-climber-src;
  };
  nvim-telescope-fzf-native = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-telescope-fzf-native";
    src = inputs.nvim-telescope-fzf-native-src;
  };
  nvim-noice = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-noice";
    src = inputs.nvim-noice-src;
  };
  nvim-dirbuf = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-dirbuf";
    src = inputs.nvim-dirbuf-src;
  };
in
{
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
      nvim-autopairs
      targets-vim
      leap-nvim
      vim-repeat

      nvim-which-key

      # Themes
      nvim-tundra
      nvim-tokyonight
      catppuccin-nvim

      # File Tree
      nvim-tree-lua

      nvim-dirbuf

      # Fuzzy Finder
      nvim-telescope-fzf-native
      telescope-nvim
      cheatsheet-nvim

      # General Deps
      plenary-nvim

      # LSP
      null-ls-nvim
      nvim-lspconfig
      nvim-lspsaga
      rust-tools-nvim
      # progress
      fidget-nvim
      trouble-nvim
      lsp_lines-nvim
      lsp_signature-nvim
      nvim-jdtls
      symbols-outline-nvim

      # Completions
      nvim-cmp
      cmp-buffer
      cmp-git
      cmp-cmdline
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-treesitter
      luasnip
      friendly-snippets
      lspkind-nvim

      # Git
      gitsigns-nvim
      diffview-nvim

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
      nvim-tree-climber
      nvim-treesitter-context

      nvim-auto-save
      nvim-local-history

      comment-nvim
      nvim-ts-context-commentstring

      editorconfig-nvim

      toggleterm-nvim

      project-nvim

      nvim-noice
      nui-nvim
      nvim-notify
    ];

    extraPackages = with pkgs; [
      ripgrep

      # Bash
      nodePackages.bash-language-server
      shellcheck

      # Docker
      nodePackages.dockerfile-language-server-nodejs
      hadolint

      # grammar
      vale

      # Git
      gitlint

      # Go
      gopls

      # HTML/CSS/JS
      nodePackages.vscode-langservers-extracted

      # JavaScript/Typescript
      nodePackages.typescript-language-server

      # lua
      luaformatter
      sumneko-lua-language-server

      # Make
      cmake-language-server

      # Markdown
      nodePackages.markdownlint-cli
      # This is a cli utility as we can't display all this in cli
      pandoc

      # Nix
      rnix-lsp
      deadnix
      statix

      # Rust
      rust-analyzer
      rustfmt
      clippy

      # terraform
      terraform-ls

      # TOML
      taplo-cli

      # YAML
      nodePackages.yaml-language-server
      yamllint

      nodePackages.prettier
    ];

    #      luafile ${builtins.toString ./init.lua}
    extraConfig = ''
      set guifont=Fira\ Code\ Nerd\ Font:h14
      let g:neovide_cursor_animation_length=0
      lua require("init")
    '';
  };
  home.packages = [ pkgs.neovide ];
  xdg.configFile = {
    "nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
  };
}
