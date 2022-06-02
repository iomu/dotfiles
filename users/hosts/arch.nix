{ config, pkgs, lib, inputs, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user"
    "${builtins.readFile ../modules/system-management/apply-user-arch.sh}";
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

  programs.git.userEmail = "muellerjohannes23@gmail.com";
  home.packages = [ apply-user pkgs.nixgl.auto.nixGLDefault ];

  home.sessionVariables = { TERMINAL = terminal; };

  home.sessionPath = [
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/sbin"
    "/usr/bin"
    "/sbin"
    "/bin"
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
          "DP-2" =
            "00ffffffffffff0010ac03a1553646300a1d0104a5361e783b9051a75553a028135054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c4500202f2100001e000000ff003543325830393335304636550a000000fc0044454c4c204157323531384846000000fd0030f0ffff3c010a20202020202001f7020319f14c9005040302071601141f12132309070783010000866f80a07038404030203500202f2100001a5a8780a070384d4030203500202f2100001aa1dd8078703850401c20980c202f2100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002a";
          "HDMI-0" =
            "00ffffffffffff0009d1117f455400000317010380351e782e48a0a654549f260d5054a56b803168317c4568457c6168617c953cd1c0023a801871382d40582c4500132a2100001e000000ff003531443031363634534c300a20000000fd0018780f8711000a202020202020000000fc0042656e5120584c32343131540a0157020323f15090050403020111121314060715161f202309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001f8c0ad08a20e02d10103e9600132a210000190000000000000000000000000000000000000000c7";
        };
        config = {
          "DP-2" = {
            enable = true;
            crtc = 1;
            mode = "1920x1080";
            position = "0x0";
            rate = "60.00";
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
          "DP-3".enable = false;
        };
      };
    };
  };
}
