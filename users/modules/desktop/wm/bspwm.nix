{ config, pkgs, libs, ... }: {
  services.sxhkd = {
    enable = false;
    keybindings = {
      # terminal emulator
      "super + Return" = "nixGLIntel alacritty";

      # program launcher
      "super + space" =
        ''rofi -modi "window,drun,run" -show drun -display-drun "open"'';

      # make sxhkd reload its configuration files:
      "super + Escape" = "pkill -USR1 -x sxhkd";

      "super + alt + w" = "google-chrome-stable";

      "super + shift + l" = "i3lock -i $HOME/Pictures/desktop.png";

      "super + shift + r" = "autorandr -c";

      #
      # bspwm hotkeys
      #

      # quit bspwm normally
      "super + alt + Escape" = "bspc quit";

      # close and kill
      "super + {_,shift + }w" = "bspc node -{c,k}";

      # alternate between the tiled and monocle layout
      "super + m" = "bspc desktop -l next";

      # if the current node is automatic, send it to the last manual, otherwise pull the last leaf
      "super + y" =
        "bspc query -N -n focused.automatic && bspc node -n last.!automatic || bspc node last.leaf -n focused";

      # swap the current node and the biggest node
      "super + g" = "bspc node -s biggest";

      #
      # state/flags
      #

      # set the window state
      "super + {t,shift + t,s,f}" =
        "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

      # set the node flags
      "super + ctrl + {x,y,z}" = "bspc node -g {locked,sticky,private}";

      #
      # focus/swap
      #

      # focus the node in the given direction
      "super + {_,shift + }{h,j,k,l}" =
        "bspc node -{f,s} {west,south,north,east}";

      "super + {_,shift +}{Left,Down,Up,Right}" =
        "bspc node -{f,s} {west,south,north,east}";

      "super + ctrl + {Left,Right}" = "bspc desktop -f {prev,next}";

      # focus the node for the given path jump
      "super + {p,b,comma,period}" =
        "bspc node -f @{parent,brother,first,second}";

      # focus the next/previous node
      "super + {_,shift + }c" = "bspc node -f {next,prev}";

      # focus the next/previous desktop
      "super + bracket{left,right}" = "bspc desktop -f {prev,next}";

      # focus the last node/desktop
      "super + {grave,Tab}" = "bspc {node,desktop} -f last";

      # focus the older or newer node in the focus history
      "super + {o,i}" =
        "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";

      # focus or send to the given desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

      #
      # preselect
      #

      # preselect the direction
      "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

      "super + ctrl + {Left,Down,Up,Right}" =
        "bspc node -p {west,south,north,east}";

      # preselect the ratio
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

      # cancel the preselection for the focused node
      "super + ctrl + space" = "bspc node -p cancel";

      # cancel the preselection for the focused desktop
      "super + ctrl + shift + space" =
        "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

      #
      # move/resize
      #

      # expand a window by moving one of its side outward
      "super + alt + {h,j,k,l}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

      # contract a window by moving one of its side inward
      "super + alt + shift + {h,j,k,l}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
    };

    extraOptions = [ "-v" ];
  };

  services.polybar = {
    enable = false;
    script = ''
      sleep 3
      for m in $(polybar --list-monitors | cut -d":" -f1); do
          MONITOR=$m polybar --reload main &
          MONITOR=$m polybar --reload bottom &
      done
    '';

    package = pkgs.polybar.override { pulseSupport = true; };

    settings = {
      "colors" = {
        background = "#1AFFFFFF";
        background-alt = "#2aFFFFFF";
        foreground = "#f3f4f5";
        foreground-alt = "#f3f4f5";
        foreground-dim = "#676e7d";
        primary = "#ffb52a";
        secondary = "#fe60053";
        alert = "#ff6600";

        high = "#268bd2";
        high-alt = "#0c2b41";

        red = "#A54242";
        reddark = "#A50000";
        green = "#8C9440";
        greendark = "#869401";
        yellowdark = "#DE5F08";
        yellow = "#DE935F";
        blue = "#5F819D";
        bluedark = "#0B5B9D";
        magenta = "#6c71c3";
        cyan = "#80cbc3";
        white = "#ffffff";
        purple = "#85678F";
        purpledark = "#6F0F8F";
      };
      "global/wm" = {
        margin.top = 0;
        margin.bottom = 0;
      };
      "bar/main" = {
        monitor = "\${env:MONITOR:}";
        bottom = false;
        width = "100%";
        height = 30;
        offset-x = 0;
        offset-y = 0;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        overline.size = 2;
        overline.color = "#f00";
        underline.size = 2;
        underline.color = "\${colors.blue}";

        spacing = 0;
        padding.left = 0;
        padding.right = 0;
        module.margin.left = 0;
        module.margin.right = 0;

        font = [
          "Roboto Mono:pixelsize=10;1"
          "Roboto Mono:fontformat=truetype:size=10:antialias=false;0"
          "Wuncon Siji:pixelsize=10;1"
          "FontAwesome:pixelsize=10;1"
          "Siji:pixelsize=10;1"
          "Material Icons:pixelsize=12;1"
          "Roboto Mono NerdFont:pixelsize=12;1"
        ];

        modules.left = "bspwm";
        modules.center = "xwindow";
        modules.right = "date powermenu";

        tray.detached = true;
        tray.padding = 2;
        tray.background = "\${colors.background}";

        wm.restack = "bspwm";

        scroll.up = "bspwm-desknext";
        scroll.down = "bspwm-deskprev";
      };
      "bar/main_external" = {
        monitor = "eDP-1-1";
        bottom = false;
        width = "100%";
        height = 30;
        offset.x = 0;
        offset.y = 0;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        overline.size = 2;
        overline.color = "#f00";
        underline.size = 2;
        underline.color = "\${colors.blue}";

        spacing = 0;
        padding.left = 0;
        padding.right = 0;
        module.margin.left = 0;
        module.margin.right = 0;

        font = [
          "Roboto Mono:pixelsize=10;1"
          "Roboto Mono:fontformat=truetype:size=10:antialias=false;0"
          "Wuncon Siji:pixelsize=10;1"
          "FontAwesome:pixelsize=10;1"
          "Siji:pixelsize=10;1"
          "Material Icons:pixelsize=12;1"
          "Roboto Mono NerdFont:pixelsize=12;1"
        ];

        modules.left = "bspwm";
        modules.center = "xwindow";

        tray.detached = true;
        tray.padding = 2;
        tray.background = "\${colors.background}";

        wm.restack = "bspwm";

        scroll.up = "bspwm-desknext";
        scroll.down = "bspwm-deskprev";
      };
      "bar/bottom" = {
        monitor = "\${env:MONITOR:}";
        bottom = true;
        width = "100%";
        height = 25;
        offset.x = 0;
        offset.y = 0;

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        overline.size = 2;
        overline.color = "#f00";
        underline.size = 2;
        underline.color = "\${colors.blue}";

        spacing = 0;
        padding.left = 0;
        padding.right = 0;
        module.margin.left = 0;
        module.margin.right = 0;

        font = [
          "Roboto Mono:pixelsize=10;1"
          "Roboto Mono:fontformat=truetype:size=10:antialias=false;0"
          "Wuncon Siji:pixelsize=10;1"
          "FontAwesome:pixelsize=10;1"
          "Siji:pixelsize=10;1"
          "Material Icons:pixelsize=12;1"
          "Roboto Mono NerdFont:pixelsize=12;1"
        ];

        modules.left = "mpd";
        modules.right = "pulseaudio memory cpu filesystem temperature";
        wm.restack = "bspwm";
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label.text = "%title:0:120:...da%";
        label.padding = 2;
        format.underline = "#c0FFFFFF";
      };

      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;

        mount = [ "/" ];

        label.mounted = "DISK %used%/%total% (%percentage_used%%)";
        label.unmounted.text = "%mountpoint% not mounted";
        label.unmounted.foreground = "\${colors.foreground-alt}";
        format.mounted.padding = 2;
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        pin.workspaces = true;

        label.focused.text = "%icon%";
        label.focused.background = "\${colors.background-alt}";
        label.focused.underline = "\${colors.yellow}";
        label.focused.padding = 3;

        label.occupied.text = "%icon%";
        label.occupied.padding = 3;

        label.urgent.text = "%icon%!";
        label.urgent.background = "\${colors.alert}";
        label.urgent.padding = 3;

        label.empty.text = "%icon%";
        label.empty.foreground = "\${colors.foreground-alt}";
        label.empty.padding = 3;

        ws.icon.text = [
          "I;1"
          "II;2"
          "III;3"
          "IV;4"
          "V;5"
          "VI;6"
          "VII;7"
          "VIII;8"
          "IX;9"
          "X;10"
        ];
        ws.icon.default = "";
      };

      "module/mpd" = {
        type = "internal/mpd";
        format.online =
          "<icon-prev> <icon-stop> <toggle> <icon-next> <label-song> <label-time>";

        icon.prev.text = "";
        icon.stop.text = "";
        icon.play.text = "";
        icon.pause.text = "";
        icon.next.text = "";

        icon.prev.padding = 1;
        icon.stop.padding = 1;
        icon.play.padding = 1;
        icon.pause.padding = 1;
        icon.next.padding = 1;

        label.song.maxlen = 100;
        label.song.ellipsis = true;

        label.time = "(%elapsed%/%total%)";
        format.padding = 4;

        bar.progress = {
          width = 30;
          progress = {
            indicator = "|";
            fill = {
              text = "─";
              foreground = "#aaff77";
            };
            empty = {
              text = "─";
              foreground = "#444444";
            };
          };
        };
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format.text = "<label> <ramp-coreload>";
        format.prefix = "CPU ";
        label = "%percentage%%";
        format.padding = 2;
        ramp.coreload = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
      };

      "module/memory" = {
        type = "internal/memory";
        format.text = "<label>";
        format.prefix = "RAM ";
        label = "%gb_used%/%gb_total% (%percentage_used%%)";
        interval = 2;

        bar.used = {
          width = 20;
          foreground = [ "#aaff77" "#aaff77" "#fba922" "#ff5555" ];
          indicator = {
            text = "|";
            font = 6;
            foreground = "#ff";
          };
          fill = {
            indicator = {
              text = "|";
              font = 6;
              foreground = "#ff";
            };
            fill = {
              text = "─";
              font = 6;
            };
            empty = {
              text = "─";
              font = 6;
              foreground = "#444444";
            };
          };
        };

        format.padding = 2;
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;

        date.alt = "%d-%m-%Y";

        time.text = "%H:%M";
        time-alt = "%H:%M";

        label = "%date%%time%";
        format.padding = 2;
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal.zone = 2;
        warn.temperature = 60;

        format.text = "<ramp><label>";
        format.warn = "<ramp><label-warn>";
        format.padding = 2;

        label.text = "%temperature%";
        label.warn.text = "%temperature%";
        label.warn.foreground = "\${colors.secondary}";

        ramp.text = [ "" "" "" ];
        ramp.foreground = "\${colors.foreground-alt}";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format.volume = "<label-volume>";
        click.right = "pavucontrol";
        ramp.volume = [ "🔈" "🔉" "🔊" ];
      };

      "module/powermenu" = {
        type = "custom/menu";

        format-spacing = 1;

        label-open = "x";
        label-open-foreground = "\${colors.secondary}";
        label-close = "cancel";
        label-close-foreground = "\${colors.secondary}";
        label-separator = "|";
        label-separator-foreground = "\${colors.foreground-alt}";

        format-padding = 2;

        menu = [
          [
            {
              text = "reboot";
              exec = "menu-open-1";
            }
            {
              text = "power off";
              exec = "menu-open-2";
            }
          ]
          [
            {
              text = "cancel";
              exec = "menu-open-0";
            }
            {
              text = "reboot";
              exec = "sudo reboot";
            }
          ]
          [
            {
              text = "power off";
              exec = "sudo reboot";
            }
            {
              text = "cancel";
              exec = "menu-open-0";
            }
          ]
        ];
      };

      "settings" = { screenchange.reload = true; };
    };
  };
}
