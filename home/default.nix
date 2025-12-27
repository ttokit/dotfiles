{ config, pkgs, lib, ... }:

{
  imports = [
    ./git.nix # Git 設定を分離して管理
  ];

  # ユーザー情報
  # lib.mkForce で他のモジュールからの上書きを防ぐ
  home.username = "ttokit";
  home.homeDirectory = lib.mkForce "/Users/ttokit";

  # Home Manager 自体の管理を有効化
  programs.home-manager.enable = true;

  # direnv の設定（プロジェクト単位の環境切り替え用）
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # nix-direnv で高速化 & キャッシュ
  };

  # zsh を有効化（direnv のフックを動かすために必要）
  programs.zsh.enable = true;

  # 必須: Home Manager のバージョン管理
  home.stateVersion = "24.11";
}
