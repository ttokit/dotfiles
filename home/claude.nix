{ config, lib, pkgs, ... }:

{
  # Claude Code 設定ファイルを ~/.claude/ に配置
  home.file = {
    ".claude/settings.json".source = ./claude/settings.json;
    # CLAUDE.md と agents/ は将来的に追加可能
    # ".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
    # ".claude/agents/".source = ./claude/agents;
  };
}
