{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    cmake
    pkg-config
  ];
}
