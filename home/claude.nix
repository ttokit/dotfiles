{ config, ... }:

{
  home.file = {
    ".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
    ".claude/commands/optimize.md".source = ./claude/commands/optimize.md;
    ".claude/optimize/optimization-guide.md".source = ./claude/optimize/optimization-guide.md;
    ".claude/optimize/templates.md".source = ./claude/optimize/templates.md;
  };
}
