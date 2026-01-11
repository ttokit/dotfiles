{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # Powerlevel10kプラグイン
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # p10k instant prompt（最初に読み込む）+ 設定読み込み
    initContent = ''
      # p10k instant prompt (must be at the very top)
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # p10k設定読み込み
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';

    # ヒストリ設定
    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      share = true;
    };

    # 便利機能
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # エイリアス
    shellAliases = {
      cc = "claude";
      lg = "lazygit";
    };
  };

  # p10k.zshをホームディレクトリに配置
  home.file.".p10k.zsh".source = ./p10k.zsh;
}
