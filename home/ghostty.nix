{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;

    # macOS では brew cask でインストール済みのため、パッケージは無効化
    package = null;

    settings = {
      # テーマ
      theme = "TokyoNight";

      # フォント設定（白源 Nerd Font）
      font-family = "HackGen Console NF";
      font-size = 20;
      font-thicken = true;
      adjust-cell-height = 2;

      # ウィンドウ設定
      maximize = true;
      macos-titlebar-style = "tabs";
      background-opacity = 0.8;
      unfocused-split-opacity = 0.7;
      background-blur = true;
      macos-option-as-alt = true;
      window-inherit-working-directory = true;
      window-save-state = "always";

      # シェル統合
      shell-integration = "detect";

      # キーバインド
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+j=goto_split:bottom"
        "ctrl+k=goto_split:top"
        "ctrl+l=goto_split:right"
        "shift+enter=text:\\x1b\\r"
        "cmd+d=new_split:right"
        "cmd+e=equalize_splits"
      ];
    };
  };
}
