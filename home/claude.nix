{ config, ... }:

{
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
}
