{ pkgs, lib }:

pkgs.stdenv.mkDerivation {
  name = "hello";
  version = "1.0";

  src = pkgs.writeText "hello.c" ''
    #include <stdio.h>

    int main() {
        printf("Hello, World!\n");
        return 0;
    }
  '';

  buildPhase = ''
    $CC $src -o hello
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/hello
  '';

  meta = with lib; {
    description = "A simple program that prints 'Hello, World!'";
    homepage = https://www.gnu.org/software/hello/;
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
