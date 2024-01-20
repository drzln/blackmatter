{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "hello-ninja";
  version = "1.0";

  # Create the C source file and the Ninja build file
  src = pkgs.runCommandNoCC "hello-src" { } ''
    mkdir $out
    cat >$out/hello.c <<EOF
    #include <stdio.h>
    int main() {
        printf("Hello, World!\\n");
        return 0;
    }
    EOF

    cat >$out/build.ninja <<EOF
    rule cc
      command = cc \$in -o \$out

    build hello: cc hello.c
    EOF
  '';

  nativeBuildInputs = [ pkgs.ninja ];

  buildPhase = ''
    cd $src
    ninja -v
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/hello $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "A simple Hello World program built with Ninja";
    platforms = pkgs.lib.platforms.all;
  };
}
