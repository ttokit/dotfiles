{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "mtime";
        sort_reverse = true;
      };

      opener = {
        edit = [
          { run = "\${EDITOR:-vim} \"$@\""; block = true; }
        ];
        open = [
          { run = "open \"$@\""; desc = "Open with default app"; }
        ];
      };
    };
  };
}
