{ config, pkgs, ... }: {
  programs.aerospace = {
    enable = true;
    userSettings = {
      mode = {
        main = {
          binding = {
            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            # See: https://nikitabobko.github.io/AeroSpace/commands#focus
            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#move
            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#resize
            alt-minus = "resize smart -50";
            alt-equal = "resize smart +50";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
            alt-1 = "workspace 1";
            alt-2 = "workspace 2";
            alt-3 = "workspace 3";
            alt-4 = "workspace 4";
            alt-5 = "workspace 5";
            alt-6 = "workspace 6";
            alt-7 = "workspace 7";
            alt-8 = "workspace 8";
            alt-9 = "workspace 9";

            # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-shift-7 = "move-node-to-workspace 7";
            alt-shift-8 = "move-node-to-workspace 8";
            alt-shift-9 = "move-node-to-workspace 9";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
            alt-tab = "workspace-back-and-forth";
            # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            # See: https://nikitabobko.github.io/AeroSpace/commands#mode
            alt-shift-semicolon = "mode service";
          };
        };
      };
    };
  };
}
