{ config, pkgs, lib, inputs, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user"
    "${builtins.readFile ../modules/system-management/apply-user-work.sh}";
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [ inputs.nixgl.overlay ];
    config = { allowUnfree = true; };
  };
  terminal =
    "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.wezterm}/bin/wezterm";

  kafkactl = pkgs.buildGoModule rec {
    pname = "kafkactl";
    version = "2.3.0";

    src = inputs.kafkactl.outPath;

    vendorSha256 =
      "sha256-w6sOjfHwBpVgVnqbEzb4d5oMMBwt0j7HGJ//L/44s2A="; # lib.fakeSha256

    subPackages = [ "." ];
  };
in {
  imports = [ ../modules/desktop/wm/i3.nix ];

  nix.settings = {
      experimental-features = "nix-command flakes";
    };

  programs.git.userEmail = "johannes.mueller@freiheit.com";
  home.packages = [
    apply-user
    pkgs.pavucontrol
    pkgs.nixgl.nixGLIntel
    pkgs.nixgl.auto.nixGLNvidia
    pkgs.nixgl.auto.nixGLDefault
    pkgs.postman
    kafkactl
    pkgs.graphviz
  ];

  home.sessionVariables = { TERMINAL = terminal; };

  home.sessionPath = [
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/sbin"
    "/usr/bin"
    "/sbin"
    "/bin"
    "/usr/games"
    "/usr/local/games"
    "/snap/bin"
    "$HOME/Downloads/google-cloud-sdk/bin"
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  services.gnome-keyring.enable = true;

  xsession.windowManager.i3.config.terminal = terminal;

  programs.autorandr = {
    enable = true;
    profiles = {
      "dual" = {
        fingerprint = {
          "eDP-1-1" =
            "00ffffffffffff0009e59207000000002c1b0104a5221378021bb0a658559d260e5054000000010101010101010101010101010101019c3b803671383c403020360058c21000001aa82f803671383c403020360058c21000001a000000fe00424f452043510a202020202020000000fe004e5631353646484d2d4e36310a00ed";
          "HDMI-0" =
            "00ffffffffffff001e6d805b2606050003200103803c2278ea8cb5af4f43ab260e5054254b007140818081c0a9c0b300d1c08100d1cf5aa000a0a0a0465030203a0055502100001a000000fd0030781ee63c000a202020202020000000fc004c4720554c545241474541520a000000ff003230334e54535539503235340a01dc020344f1230907074d100403011f13123f5d5e5f60616d030c001000b83c20006001020367d85dc401788003e30f0018681a00000101307800e305c000e6060501605928d97600a0a0a0345030203a0055502100001a565e00a0a0a029503020350055502100001a000000000000000000000000000000000000000000000027";
        };
        config = {
          "eDP-1-1" = {
            enable = true;
            #            crtc = 0;
            mode = "1920x1080";
            position = "0x0";
            rate = "60.03";
          };

          "HDMI-0" = {
            enable = true;
            primary = true;
            crtc = 0;
            rate = "99.95";
            mode = "2560x1440";

            position = "1920x0";
          };

          "DP-0".enable = false;
          "DP-1".enable = false;
          "DP-2".enable = false;
          "DP-3".enable = false;
        };
      };

      "external" = {
        fingerprint = {
          "HDMI-0" =
            "00ffffffffffff001e6d805b2606050003200103803c2278ea8cb5af4f43ab260e5054254b007140818081c0a9c0b300d1c08100d1cf5aa000a0a0a0465030203a0055502100001a000000fd0030781ee63c000a202020202020000000fc004c4720554c545241474541520a000000ff003230334e54535539503235340a01dc020344f1230907074d100403011f13123f5d5e5f60616d030c001000b83c20006001020367d85dc401788003e30f0018681a00000101307800e305c000e6060501605928d97600a0a0a0345030203a0055502100001a565e00a0a0a029503020350055502100001a000000000000000000000000000000000000000000000027";
        };
        config = {
          "eDP-1-1" = { enable = false; };

          "HDMI-0" = {
            enable = true;
            primary = true;
            crtc = 0;
            rate = "99.95";
            position = "0x0";
            mode = "2560x1440";
          };

          "DP-0".enable = false;
          "DP-1".enable = false;
          "DP-2".enable = false;
          "DP-3".enable = false;
        };
      };
    };
  };
}
