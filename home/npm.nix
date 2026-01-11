{ config, pkgs, lib, ... }:

{
  home.activation.npmGlobalPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Installing npm global packages..."
    ${pkgs.nodejs_24}/bin/npm install -g @openai/codex
  '';
}
