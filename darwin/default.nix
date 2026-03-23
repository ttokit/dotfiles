{ pkgs, inputs, ... }:

{
  # Determinate Nix を使用しているため、nix-darwin の Nix 管理を無効化
  # Determinate Nix が独自のデーモンで Nix を管理するため
  nix.enable = false;

  # ユーザー固有の system.defaults 設定に必要
  system.primaryUser = "ttokit";

  # zsh をデフォルトシェルとして有効化
  # Home Manager の programs.zsh と連携するために必要
  programs.zsh.enable = true;

  # Nix管理アプリを /Applications/Nix Apps に配置（Spotlight対応）
  # シンボリックリンクではなくmkaliasでエイリアスを作成することでSpotlightが認識する
  system.activationScripts.applications.text = let
    apps = [
      inputs.arto.packages.${pkgs.system}.default
    ];
  in pkgs.lib.mkForce ''
    echo "setting up /Applications/Nix Apps..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    for app in ${builtins.concatStringsSep " " (map (p: "${p}/Applications/*.app") apps)}; do
      if [ -e "$app" ]; then
        app_name=$(basename "$app")
        echo "linking $app_name" >&2
        ${pkgs.mkalias}/bin/mkalias "$app" "/Applications/Nix Apps/$app_name"
      fi
    done
  '';

  # スクリーンショットの保存先を変更
  system.defaults.screencapture.location = "~/Pictures/Screenshots";

  # Homebrew パッケージの宣言的管理
  # cask（GUIアプリ）を一元管理。CLIツールはnixpkgsで管理。
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };
    taps = [
      "steipete/tap"
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
    ];
  };

  # 必須: nix-darwin のバージョン管理
  # これにより設定の互換性が保たれる
  system.stateVersion = 5;
}
