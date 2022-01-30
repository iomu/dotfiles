{ config, pkgs, lib, ... }: {
  systemd.user.sessionVariables = { "_JAVA_AWT_WM_NONREPARENTING" = "1"; };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      menu = ''"rofi -modi 'window,drun,run' -show drun -display-drun 'open'"'';
      keybindings =
        let modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Shift+l" = "exec i3lock -i $HOME/Pictures/desktop.png";
          "${modifier}+Shift+r" = "exec autorandr -c";
          "${modifier}+Shift+b" = "restart";
          "${modifier}+g" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "${modifier}+Ctrl+Left" = "move workspace to output left";
          "${modifier}+Ctrl+Right" = "move workspace to output right";
        };
      gaps = {
        inner = 10;
        outer = 0;
        smartGaps = true;
      };
      workspaceAutoBackAndForth = true;

      fonts = {
        names = [ "DejaVu Sans Mono" "Font Awesome 5 Free" ];
        size = 10.0;
      };

      colors = {
        background = "#ffffff";
        focused = {
          background = "#4C566A";
          border = "#88C0D0";
          childBorder = "#88C0D0";
          indicator = "#88C0D0";
          text = "#ffffff";
        };
        focusedInactive = {
          background = "#5f676a";
          border = "#2E3440";
          childBorder = "#5f676a";
          indicator = "#484e50";
          text = "#ffffff";
        };
        placeholder = {
          background = "#0c0c0c";
          border = "#000000";
          childBorder = "#0c0c0c";
          indicator = "#000000";
          text = "#ffffff";
        };
        unfocused = {
          background = "#222222";
          border = "#2E3440";
          childBorder = "#222222";
          indicator = "#292d2e";
          text = "#888888";
        };
        urgent = {
          background = "#900000";
          border = "#2f343a";
          childBorder = "#900000";
          indicator = "#900000";
          text = "#ffffff";
        };
      };

      bars = [{
        mode = "dock";
        hiddenState = "hide";
        position = "top";
        workspaceButtons = true;
        workspaceNumbers = true;
        statusCommand =
          "${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/i3status-rust/config-default.toml";
        fonts = {
          names = [ "DejaVu Sans Mono" "Fira Code" "Font Awesome 5 Free" ];
          size = 12.0;
        };
        trayOutput = "primary";
        colors = {
          background = "#2E3440";
          statusline = "#88C0D0";
          separator = "#666666";
          focusedWorkspace = {
            text = "#4C566A";
            background = "#88C0D0";
            border = "#2E3440";
          };
          activeWorkspace = {
            text = "#4C566A";
            background = "#88C0D0";
            border = "#2E3440";
          };
          inactiveWorkspace = {
            text = "#88C0D0";
            background = "#4C566A";
            border = "#2E3440";
          };
          urgentWorkspace = {
            text = "#4C566A";
            background = "#900000";
            border = "#2E3440";
          };
        };
      }];

      startup = [
        {
          command = "${pkgs.autorandr}/bin/autorandr -c";
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale $HOME/Pictures/desktop.jpg";
          notification = false;
        }
      ];
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        theme = "nord-dark";
        icons = "awesome5";
        blocks = [
          {
            block = "focused_window";
            max_width = 50;
            show_marks = "visible";
          }
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
            format = "{icon} {used}/{total}";
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used}/{mem_total}({mem_used_percents})";
          }
          {
            block = "cpu";
            interval = 1;
            format = "{barchart} {utilization}";
          }
          {
            block = "load";
            interval = 1;
            format = "{1m}";
          }
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
            format = "%a %d/%m %R";
          }
        ];
      };
    };
  };
}
