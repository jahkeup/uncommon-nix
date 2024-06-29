{ gccStdenv, src, version, libarchive, libintl, linuxHeaders }:

gccStdenv.mkDerivation {
  pname = "sfutils";
  inherit src version;

  nativeBuildInputs = [ libarchive ];
  buildInputs = [ libintl linuxHeaders ];

  unpackPhase = ''
    bsdtar -xf $src
    tar -xf sfutils-*.tar.gz
    cd sfutils-*/
  '';
}
