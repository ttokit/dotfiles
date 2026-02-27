{ config, pkgs, lib, ... }:

let
  npmGlobalDir = "${config.home.homeDirectory}/.npm-global";

  npmGlobalPackages = [
    "@openai/codex@0.106.0"
  ];
in
{
  home.file.".npmrc".text = ''
    prefix=${npmGlobalDir}
  '';

  home.sessionPath = [ "${npmGlobalDir}/bin" ];

  home.activation.npmGlobalPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Installing npm global packages..."
    ${pkgs.nodejs_24}/bin/npm install -g ${builtins.concatStringsSep " " npmGlobalPackages}
  '';
}
