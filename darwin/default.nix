{ pkgs, ... }:

{
  # Determinate Nix を使用しているため、nix-darwin の Nix 管理を無効化
  # Determinate Nix が独自のデーモンで Nix を管理するため
  nix.enable = false;

  # ユーザー固有の system.defaults 設定に必要
  system.primaryUser = "ttokit";

  # zsh をデフォルトシェルとして有効化
  # Home Manager の programs.zsh と連携するために必要
  programs.zsh.enable = true;

  # スクリーンショットの保存先を変更
  system.defaults.screencapture.location = "~/Pictures/Screenshots";

  # Homebrew パッケージの宣言的管理
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };
    taps = [
      "k1LoW/tap"
      "steipete/tap"
    ];
    brews = [
      "k1LoW/tap/mo"
      "mas"
    ];
    casks = [
      "1password"
      "1password-cli"
      "chatgpt-atlas"
      "claude"
      "clipy"
      "cmux"
      "codex"
      "codexbar"
      "cursor"
      "ghostty"
      "google-chrome"
      "homerow"
      "nani"
      "raycast"
      "rectangle"
      "slack"
      "todoist-app"
      "typeless"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "RunCat" = 1429033973;
    };
  };

  # 必須: nix-darwin のバージョン管理
  # これにより設定の互換性が保たれる
  system.stateVersion = 5;
}
