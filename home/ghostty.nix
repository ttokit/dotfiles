{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;

    # macOS では brew cask でインストール済みのため、パッケージは無効化
    package = null;

    settings = {
      # テーマ
      theme = "TokyoNight";

      # フォント設定
      font-family = "Source Han Code JP";
      font-size = 20;
      font-thicken = true;
      adjust-cell-height = 2;

      # ウィンドウ設定
      maximize = true;
      macos-titlebar-style = "tabs";
      background-opacity = 0.8;
      background-blur = true;
      macos-option-as-alt = true;
      window-inherit-working-directory = true;
      window-save-state = "always";

      # シェル統合
      shell-integration = "detect";

      # キーバインド
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
        "shift+enter=text:\\x1b\\r"
      ];
    };
  };
}
