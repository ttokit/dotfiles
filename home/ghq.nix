{ pkgs, ... }:

{
  home.packages = [ pkgs.ghq ];

  programs.zsh.initContent = ''
    function ghq-fzf() {
      local repo=$(ghq list | fzf --prompt="repo> ")
      if [[ -n "$repo" ]]; then
        BUFFER="cd $(ghq root)/$repo"
        zle accept-line
      fi
      zle reset-prompt
    }
    zle -N ghq-fzf
    bindkey '^]' ghq-fzf
  '';
}
