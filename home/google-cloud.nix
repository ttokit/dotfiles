{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = [
    pkgs.google-cloud-sdk
    inputs.google-workspace-cli.packages.${system}.gws
  ];
}
