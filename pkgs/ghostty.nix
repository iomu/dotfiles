{ lib, stdenvNoCC, fetchurl, _7zz, makeBinaryWrapper, }:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ghostty";
  version = "1.0.1";

  src = fetchurl {
    url = "https://release.files.ghostty.org/${finalAttrs.version}/Ghostty.dmg";
    sha256 = "sha256-QA9oy9EXLSFbzcRybKM8CxmBnUYhML82w48C+0gnRmM=";
  };

  nativeBuildInputs = [ _7zz makeBinaryWrapper ];

  sourceRoot = ".";
  installPhase =
    "	runHook preInstall\n\n	mkdir -p $out/Applications\n	mv Ghostty.app $out/Applications/\n	makeWrapper $out/Applications/Ghostty.app/Contents/MacOS/ghostty $out/bin/ghostty\n\n	runHook postInstall\n";

  outputs = [ "out" "man" "shell_integration" "terminfo" "vim" ];

  postFixup =
    let resources = "$out/Applications/Ghostty.app/Contents/Resources";
    in "	mkdir -p $man/share\n	ln -s ${resources}/man $man/share/man\n\n	mkdir -p $terminfo/share\n	ln -s ${resources}/terminfo $terminfo/share/terminfo\n\n	mkdir -p $shell_integration\n	for folder in \"${resources}/ghostty/shell-integration\"/*; do\n		ln -s $folder $shell_integration/$(basename \"$folder\")\n	done\n\n	mkdir -p $vim\n	for folder in \"${resources}/vim/vimfiles\"/*; do\n		ln -s $folder $vim/$(basename \"$folder\")\n	done\n";

  meta = {
    description =
      "Fast, native, feature-rich terminal emulator pushing modern features";
    longDescription =
      "	Ghostty is a terminal emulator that differentiates itself by being\n	fast, feature-rich, and native. While there are many excellent terminal\n	emulators available, they all force you to choose between speed,\n	features, or native UIs. Ghostty provides all three.\n";
    homepage = "https://ghostty.org/";
    downloadPage = "https://ghostty.org/download";
    license = lib.licenses.mit;
    mainProgram = "ghostty";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    maintainers = with lib.maintainers; [ DimitarNestorov ];
    outputsToInstall = [ "out" "man" "shell_integration" "terminfo" ];
    platforms = lib.platforms.darwin;
  };
})
