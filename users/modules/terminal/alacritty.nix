{ config, pkgs, lib, ... }: {
  programs.alacritty = {
    enable = config.custom.enableAlacritty;
    # default config: https://github.com/jwilm/alacritty/blob/master/alacritty.yml
    settings = {
      font = {
        normal = {
          family = "JetBrainsMonoNL Nerd Font Mono";
          style = "Bold";
        };
        size = 12;
      };
      #      colors = {
      #        primary = {
      #          background = "0x282828";
      #          foreground = "0xebdbb2";
      #        };
      #        normal = {
      #          black = "0x282828";
      #          red = "0xcc241d";
      #          green = "0x98971a";
      #          yellow = "0xd79921";
      #          blue = "0x458588";
      #          magenta = "0xb16286";
      #          cyan = "0x689d6a";
      #          white = "0xa89984";
      #        };
      #        bright = {
      #          black = "0x928374";
      #          red = "0xfb4934";
      #          green = "0xb8bb26";
      #          yellow = "0xfabd2f";
      #          blue = "0x83a598";
      #          magenta = "0xd3869b";
      #          cyan = "0x8ec07c";
      #          white = "0xebdbb2";
      #        };
      #      };

      # tokyonight-night
      colors = {
        primary = {
          background = "0x1a1b26";
          foreground = "0xc0caf5";
        };
        normal = {
          black = "0x15161e";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xbb9af7";
          cyan = "0x7dcfff";
          white = "0xa9b1d6";
        };
        bright = {
          black = "0x414868";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xbb9af7";
          cyan = "0x7dcfff";
          white = "0xc0caf5";
        };
        indexed_colors = [
          {
            index = 16;
            color = "0xff9e64";
          }
          {
            index = 17;
            color = "0xdb4b4b";
          }
        ];
      };
    };
  };
}
