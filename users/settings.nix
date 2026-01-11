{ config, lib, pkgs, ... }:

with lib;

let cfg = config.custom;
in {
  options = {
    custom = {
      system = mkOption {
        default = "";
        type = types.str;
        description = "home manager configuration to use";
      };

      user = mkOption {
        default = "jo";
        type = types.str;
        description = "user name";
      };

      shell = mkPackageOption pkgs "fish" { };

      ghostty = mkPackageOption pkgs "ghostty" {};

      terminal = mkOption {
        default = lib.getExe pkgs.wezterm;
        type = types.str;
        description = "default terminal to use";
      };

      git = {
        userEmail = mkOption {
          default = "muellerjohannes23@gmail.com";
          type = types.str;
          description = "git email to use";
        };
      };

      shellAliases = mkOption {
        default = { };
        example = literalExpression ''
          {
            ll = "ls -l";
            ".." = "cd ..";
          }
        '';
        description = ''
          An attribute set that maps aliases (the top level attribute names in
          this option) to command strings or directly to build outputs.
        '';
        type = types.attrsOf types.str;
      };

      enableAlacritty = mkOption {
        default = true;
        description = ''
          Whether to enable alacritty.
        '';
      };

      enableWezterm = mkOption {
        default = true;
        description = ''
          Whether to enable wezterm.
        '';
      };
    };
  };
}
