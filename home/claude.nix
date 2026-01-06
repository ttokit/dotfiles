{ config, ... }:

{
  home.file = {
    ".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
    ".claude/commands/optimize.md".source = ./claude/commands/optimize.md;
    ".claude/optimize/optimization-guide.md".source = ./claude/optimize/optimization-guide.md;
    ".claude/optimize/templates.md".source = ./claude/optimize/templates.md;

    # idea-validator skill (Apache License 2.0, https://github.com/luislavena/skills)
    ".claude/skills/idea-validator/SKILL.md".source = ./claude/skills/idea-validator/SKILL.md;
    ".claude/skills/idea-validator/LICENSE".source = ./claude/skills/idea-validator/LICENSE;
    ".claude/skills/idea-validator/references/questioning-frameworks.md".source = ./claude/skills/idea-validator/references/questioning-frameworks.md;
    ".claude/skills/idea-validator/references/anti-patterns.md".source = ./claude/skills/idea-validator/references/anti-patterns.md;
    ".claude/skills/idea-validator/examples/README.md".source = ./claude/skills/idea-validator/examples/README.md;
    ".claude/skills/idea-validator/examples/scenario-01-challenging-vagueness.md".source = ./claude/skills/idea-validator/examples/scenario-01-challenging-vagueness.md;
    ".claude/skills/idea-validator/examples/scenario-02-solution-bias.md".source = ./claude/skills/idea-validator/examples/scenario-02-solution-bias.md;
    ".claude/skills/idea-validator/examples/scenario-03-feature-creep.md".source = ./claude/skills/idea-validator/examples/scenario-03-feature-creep.md;
    ".claude/skills/idea-validator/examples/scenario-04-cargo-cult.md".source = ./claude/skills/idea-validator/examples/scenario-04-cargo-cult.md;
    ".claude/skills/idea-validator/examples/scenario-05-validated-idea.md".source = ./claude/skills/idea-validator/examples/scenario-05-validated-idea.md;
    ".claude/skills/idea-validator/examples/scenario-06-symptoms-vs-root-cause.md".source = ./claude/skills/idea-validator/examples/scenario-06-symptoms-vs-root-cause.md;
    ".claude/skills/idea-validator/examples/scenario-07-vague-benefits.md".source = ./claude/skills/idea-validator/examples/scenario-07-vague-benefits.md;
    ".claude/skills/idea-validator/examples/scenario-08-when-to-back-off.md".source = ./claude/skills/idea-validator/examples/scenario-08-when-to-back-off.md;
    ".claude/skills/idea-validator/examples/scenario-09-manual-data-maintenance.md".source = ./claude/skills/idea-validator/examples/scenario-09-manual-data-maintenance.md;
  };
}
