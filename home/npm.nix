{ config, pkgs, lib, ... }:

let
  npmGlobalDir = "${config.home.homeDirectory}/.npm-global";
in
{
  # npm グローバルインストール先をユーザーディレクトリに変更
  home.file.".npmrc".text = ''
    prefix=${npmGlobalDir}
  '';

  # PATH に npm グローバルの bin を追加
  home.sessionPath = [ "${npmGlobalDir}/bin" ];

  # グローバルパッケージのインストール
  home.activation.npmGlobalPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Installing npm global packages..."
    ${pkgs.nodejs_24}/bin/npm install -g @openai/codex
  '';
}
