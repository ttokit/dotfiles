{ config, lib, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/ghq/github.com/ttokit/dotfiles";
in
{
  # Claude Code ネイティブインストール用の PATH 設定
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file = {
    ".claude/CLAUDE.md".source = ./claude/CLAUDE.md;

    # ステータスライン表示スクリプト
    ".claude/statusline.sh" = {
      source = ./claude/statusline.sh;
      executable = true;
    };

    # 通知サウンドスクリプト
    ".claude/notification-sound.sh" = {
      source = ./claude/notification-sound.sh;
      executable = true;
    };
  };

  # settings.json は Claude Code が実行時に書き込むため
  # home.file ではなく activation スクリプトでシンボリックリンクを作成
  home.activation.claudeSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    SETTINGS_LINK="${config.home.homeDirectory}/.claude/settings.json"
    SETTINGS_TARGET="${dotfilesDir}/config/claude/settings.json"

    if [ -L "$SETTINGS_LINK" ]; then
      CURRENT_TARGET=$(readlink "$SETTINGS_LINK")
      if [ "$CURRENT_TARGET" != "$SETTINGS_TARGET" ]; then
        echo "Fixing Claude settings.json symlink: $CURRENT_TARGET -> $SETTINGS_TARGET"
        rm "$SETTINGS_LINK"
        ln -s "$SETTINGS_TARGET" "$SETTINGS_LINK"
      fi
    elif [ ! -e "$SETTINGS_LINK" ]; then
      echo "Creating Claude settings.json symlink -> $SETTINGS_TARGET"
      ln -s "$SETTINGS_TARGET" "$SETTINGS_LINK"
    else
      echo "Warning: ~/.claude/settings.json exists but is not a symlink, skipping"
    fi
  '';
}
