{
  gccStdenv,
  src,
  version,
  libarchive,
  libintl,
  linuxHeaders,
  perl,
}:

gccStdenv.mkDerivation {
  pname = "sfutils";
  inherit src version;

  nativeBuildInputs = [
    libarchive
    perl
  ];
  buildInputs = [
    libintl
    linuxHeaders
  ];

  unpackPhase = ''
    bsdtar -xf $src
    tar -xf sfutils-*.tar.gz
    cd sfutils-*/
    patchShebangs .
    head -n 2 scripts/*
  '';

  postPatch = ''
    substituteInPlace app/sfupdate/Makefile.in \
          --replace-fail "/usr/share/sfutils/sfupdate_images" "$out/share/sfutils/sfupdate_images"
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/sfutils $out/share/licenses/sfutils-$version

    cp build/linux/tmp/sfupdate/sfupdate $out/bin/
    cp build/linux/tmp/sfboot/sfboot $out/bin/
    cp build/linux/tmp/sfctool/sfctool $out/bin/
    cp build/linux/tmp/sfkey/sfkey $out/bin/

    cp -r sfupdate_images $out/share/sfutils/

    cp LICENSE $out/share/licenses/sfutils-$version/
  '';
}
