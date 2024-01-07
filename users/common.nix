{ config, pkgs, lib, ... }: {
  imports = [
    ./modules/audio.nix
    ./modules/dev.nix
    ./modules/fonts.nix
    ./modules/helix.nix
    ./modules/git.nix
    ./modules/nix.nix
    ./modules/system-management/index.nix
    ./modules/terminal/default.nix
    ./modules/terminal/alacritty.nix
    ./modules/terminal/kitty.nix
    ./modules/terminal/wezterm.nix
    ./modules/terminal/tmux.nix
    ./modules/terminal/zsh.nix
  ];

  programs.bash = {
    enable = true;
    profileExtra =
      ''export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"'';
  };

  home.sessionVariables = {
    EDITOR = "${config.programs.helix.package}/bin/hx";
  };

  home.sessionPath = let
    gfuzzy = pkgs.fetchFromGitHub {
      owner = "bigH";
      repo = "git-fuzzy";
      rev = "6f1354411ddfa27c1162ebed73ee61dfbd71eb1a";
      sha256 = "094p605db42s9xjzbs8akc0yfhwf9l6alzsfimwmil99i8a52sr3";
    };
  in [
    "$HOME/Downloads/flutter/bin"
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/Downloads/flutter/bin/cache/dart-sdk/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/go/bin"
    "$HOME/Android/Sdk/platform-tools"
    "$HOME/.cargo/bin"
    "${gfuzzy}/bin"
  ];
}
