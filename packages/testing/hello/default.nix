{ pkgs }:

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

  doBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/hello
  '';
}
