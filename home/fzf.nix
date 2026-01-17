{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      # TokyoNight colors
      "--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64"
      "--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64"
      "--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7aa2f7"
      "--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
    ];
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
  };
}
