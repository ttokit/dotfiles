{ config, pkgs, lib, ... }:

{
  imports = [
    ./git.nix     # Git 設定
    ./zsh.nix     # zsh 設定
    ./ghostty.nix # Ghostty 設定
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

  # グローバルにインストールするパッケージ
  home.packages = with pkgs; [
    nodejs_24 # 最新LTS (Krypton, 2028年4月までサポート)
  ];

  # 必須: Home Manager のバージョン管理
  home.stateVersion = "24.11";
}
