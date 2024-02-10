{ config, pkgs, lib, inputs, ... }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [ inputs.nixgl.overlay ];
    config = { allowUnfree = true; };
  };

in {
  custom = {
    system = "arch";
    terminal =
      "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.wezterm}/bin/wezterm";
  };
  imports = [ ../modules/desktop/wm/i3.nix ];

  home.packages = [ pkgs.nixgl.auto.nixGLDefault pkgs.texlab ];

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

  programs.autorandr = {
    enable = true;
    profiles = {
      "dual" = {
        fingerprint = {
          "DP-2" =
            "00ffffffffffff0010ac03a1553646300a1d0104a5361e783b9051a75553a028135054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c4500202f2100001e000000ff003543325830393335304636550a000000fc0044454c4c204157323531384846000000fd0030f0ffff3c010a20202020202001f7020319f14c9005040302071601141f12132309070783010000866f80a07038404030203500202f2100001a5a8780a070384d4030203500202f2100001aa1dd8078703850401c20980c202f2100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002a";
          "DP-0" =
            "00ffffffffffff001e6d7f5b2606050003200104b53c22789f8cb5af4f43ab260e5054254b007140818081c0a9c0b300d1c08100d1cf09ec00a0a0a0675030203a0055502100001a000000fd003090e6e63c010a202020202020000000fc004c4720554c545241474541520a000000ff003230334e54535539503235340a01f502031a7123090607e305c000e606050160592846100403011f13565e00a0a0a029503020350055502100001a5aa000a0a0a0465030203a005550210000006fc200a0a0a0555030203a0055502100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000da";
        };
        config = {
          "DP-2" = {
            enable = true;
            crtc = 1;
            mode = "1920x1080";
            position = "2560x0";
            rate = "240.00";
          };

          "DP-0" = {
            enable = true;
            primary = true;
            crtc = 0;
            rate = "143.97";
            position = "0x0";
            mode = "2560x1440";
          };

          "HDMI-0".enable = false;

          "DP-1".enable = false;
          "DP-3".enable = false;
        };
      };
    };
  };
}
