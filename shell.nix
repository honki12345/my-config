{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.gcc
    pkgs.zsh
    pkgs.python311
    pkgs.ruby_3_2
    pkgs.zlib.dev
    pkgs.openssl.dev
    pkgs.libffi.dev
    pkgs.libyaml.dev
  ];
  
  shellHook = ''
    export SHELL=${pkgs.zsh}/bin/zsh
    ENV=nix exec zsh
  '';
}

