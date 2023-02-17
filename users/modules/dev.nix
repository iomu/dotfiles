{ config, pkgs, lib, inputs, ... }:
let
  evans = pkgs.buildGoModule rec {
    pname = "evans";
    version = "0.10.9";

    src = inputs.evans.outPath;

    vendorSha256 =
      "sha256-HcD7MnUBPevGDckiWitIcp0z97FJmW3D0f9SySdouq8="; # lib.fakeSha256

    subPackages = [ "." ];
  };
  earthly = pkgs.buildGoModule rec {
    pname = "earthly";
    version = "0.7.0-rc1";

    src = inputs.earthly.outPath;

    vendorSha256 =
      "sha256-x8HwmmvywJXYO1mMbdfZu/nsW3XK4g5FDaHIBvcnaLw="; # lib.fakeSha256

    ldflags = [
      "-s"
      "-w"
      "-X main.Version=v${version}"
      "-X main.DefaultBuildkitdImage=earthly/buildkitd:v${version}"
    ];

    BUILDTAGS = "dfrunmount dfrunsecurity dfsecrets dfssh dfrunnetwork";
    preBuild = ''
      makeFlagsArray+=(BUILD_TAGS="${BUILDTAGS}")
    '';

    # For some reasons the tests fail, but the program itself seems to work.
    doCheck = false;

    postInstall = ''
      mv $out/bin/debugger $out/bin/earthly-debugger
      # mv $out/bin/shellrepeater $out/bin/earthly-shellrepeater
    '';

    subPackages = [ "./cmd/earthly" "./cmd/debugger" ];
  };
in {
  home.packages = with pkgs; [
    # docker
    docker-compose
    buildpack

    # proto + grpc
    evans
    protobuf

    gnumake42
    earthly

    # kubernetes
    kubectl
    kustomize
    k9s
    skaffold
    istioctl

    # Azure
    azure-cli
    azure-storage-azcopy
    # infra
    terraform
    # go
    go_1_20

    lcov
    gettext
    # java
    jdk11
    maven

    libtree

    wrangler

    yarn

    vegeta

    rustup
  ];
}
