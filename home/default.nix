{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./git.nix         # Git 設定
    ./zsh.nix         # zsh 設定
    ./ghostty.nix     # Ghostty 設定
    ./claude.nix      # Claude Code 設定
    ./ssh.nix         # SSH 設定
    ./yazi.nix        # Yazi ファイルマネージャー設定
    ./neovim.nix      # Neovim エディタ設定
    ./npm.nix         # npm グローバルパッケージ管理
    ./modern-cli.nix  # モダンCLIツール（bat, eza, fd, rg, procs, dust, bottom）
    ./fzf.nix         # ファジー検索
    ./zoxide.nix      # スマートディレクトリジャンプ
    ./starship.nix    # プロンプト（TokyoNight テーマ）
    ./rust.nix        # Rust/Cargo
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
    uv        # Python パッケージマネージャー (uvx を含む)
    gh        # GitHub CLI
    lazygit   # Git TUI クライアント
    nodePackages.typescript
    nodePackages.typescript-language-server
    # フォント
    hackgen-nf-font  # 白源 Nerd Font（日本語 + Nerd Fontアイコン対応）
    # GUI アプリ
    inputs.arto.packages.${pkgs.system}.default # Markdown リーダー
    # ユーティリティ
    duti # デフォルトアプリ設定ツール
  ];

  # マークダウンファイルのデフォルトアプリをArtoに設定
  home.activation.setDefaultApps = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Setting Arto as default app for Markdown files..."
    ${pkgs.duti}/bin/duti -s com.lambdalisue.Arto public.markdown all 2>/dev/null || true
    ${pkgs.duti}/bin/duti -s com.lambdalisue.Arto net.daringfireball.markdown all 2>/dev/null || true
  '';

  # 必須: Home Manager のバージョン管理
  home.stateVersion = "24.11";
}
