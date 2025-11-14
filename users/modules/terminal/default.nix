{ config, pkgs, lib, ... }: {
  custom.shellAliases = {
    scrcpy = "ADB=$HOME/Android/Sdk/platform-tools/adb scrcpy";
    gs = "git status";
    cd = "z";
    l = "ls -l";
    la = "ls -a";
    lla = "ls -la";
  };

  home.packages = with pkgs; [
    tree
    fd
    findutils
    bat
    ripgrep
    tealdeer
    yq-go
    jq
    htop
    gawk
    glances
    dust
    bandwhich
    # count code
    tokei
    # like sed
    sd
    # colors
    pastel
    # http requests
    xh
    # ps
    procs
    # kubernetes
    click
    # json
    fx
    # hex viewer
    hexyl

    _1password-cli
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = ''
      layout_hermit() {
        # Allow for alternate install locations of hermit
        local hermit_activate_bin="$(find . -name 'activate-hermit')"
        if [[ ! -z "$hermit_activate_bin" ]];then
          source "$hermit_activate_bin"
        fi
      }
    '';
  };

  programs.fzf = { enable = true; };

  programs.skim = { enable = true; };

  programs.starship = {
    enable = true;
    settings = {
      buf = { disabled = true; };
      dart = { disabled = true; };
      docker_context = { disabled = true; };
      gcloud = { disabled = true; };
      golang = { disabled = true; };
      gradle = { disabled = true; };
      java = { disabled = true; };
      kotlin = { disabled = true; };
      package = { disabled = true; };
      rust = { disabled = true; };
      terraform = { disabled = true; };
      fill = {
        symbol = "─";
        style = "white";
      };

      time = {
        disabled = false;
        use_12hr = false;
      };

      cmd_duration = {
        min_time = 0;
        show_milliseconds = true;
      };

      directory = { fish_style_pwd_dir_length = 1; };

      git_commit = { only_detached = false; };

      format = ''
        $directory$git_branch$git_commit$fill $cmd_duration$time$line_break$jobs$status$character
      '';
    };
  };

  programs.eza = { enable = true; };

  # z
  programs.zoxide = { enable = true; };

  # like htop
  programs.bottom = { enable = true; };

  # directory navigation: br
  programs.broot = { enable = true; };

  programs.navi = { enable = true; };

  programs.atuin = {
    enable = true;
    settings = {
      filter_mode_shell_up_key_binding = "session";
      show_help = false;
      workspaces = true;
    };
  };

  # generic completions
  programs.carapace.enable = true;

  home.sessionVariables = { TERMINAL = config.custom.terminal; };
}
