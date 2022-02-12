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
    "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.alacritty}/bin/alacritty";
in {
  imports = [ ../modules/desktop/wm/i3.nix ];

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  programs.git.userEmail = "johannes.mueller@freiheit.com";
  home.packages = [
    apply-user
    pkgs.pavucontrol
    pkgs.nixgl.nixGLIntel
    pkgs.nixgl.auto.nixGLNvidia
    pkgs.nixgl.auto.nixGLDefault
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
            "00ffffffffffff001e6d0d77ab6e04000c1b0103803c2278ea3031a655539f280e5054a54b80317c0101457c617c0101818081bcd1fc023a801871382d40582c4500132a2100001edf8880a070385a403020350055502100001e000000fd0030f01eff3c000a202020202020000000fc003237474b373530460a202020200178020324f12309070749010203041112131f908301000065030c00100067d85dc4017cc00073e18078703864400837980c582f2100001ae65f00a0400060303020340055502100001eb49100a050c0783030203400555021000018000000ff003731324e54435a384a3437350a0000000000000000000000000000000000000072";
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

            rate = "60.00";
            position = "1920x0";
            mode = "1920x1080";
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
            "00ffffffffffff001e6d0d77ab6e04000c1b0103803c2278ea3031a655539f280e5054a54b80317c0101457c617c0101818081bcd1fc023a801871382d40582c4500132a2100001edf8880a070385a403020350055502100001e000000fd0030f01eff3c000a202020202020000000fc003237474b373530460a202020200178020324f12309070749010203041112131f908301000065030c00100067d85dc4017cc00073e18078703864400837980c582f2100001ae65f00a0400060303020340055502100001eb49100a050c0783030203400555021000018000000ff003731324e54435a384a3437350a0000000000000000000000000000000000000072";
        };
        config = {
          "eDP-1-1" = { enable = false; };

          "HDMI-0" = {
            enable = true;
            primary = true;
            crtc = 0;
            rate = "60.00";
            position = "0x0";
            mode = "1920x1080";
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
