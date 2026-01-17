{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      format = "$directory$git_branch$git_status$nodejs$python$rust$nix_shell$character";

      character = {
        success_symbol = "[❯](bold #7aa2f7)";
        error_symbol = "[❯](bold #f7768e)";
      };

      directory = {
        style = "bold #7dcfff";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        style = "bold #bb9af7";
        symbol = " ";
      };

      git_status = {
        style = "bold #e0af68";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "$\${count}";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };

      nodejs = {
        style = "bold #9ece6a";
        symbol = " ";
      };

      python = {
        style = "bold #e0af68";
        symbol = " ";
      };

      rust = {
        style = "bold #f7768e";
        symbol = " ";
      };

      nix_shell = {
        style = "bold #7aa2f7";
        symbol = " ";
        format = "[$symbol$state]($style) ";
      };
    };
  };
}
