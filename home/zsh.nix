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

    # プロンプト切替（USE_STARSHIP=1 で Starship、未設定で p10k）
    initContent = ''
      if [[ -n "$USE_STARSHIP" ]]; then
        # Starship プロンプト
        eval "$(starship init zsh)"
      else
        # p10k instant prompt (must be at the very top)
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        # p10k設定読み込み
        [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      fi
    '';

    # 環境変数（デフォルトで Starship 有効）
    sessionVariables = {
      USE_STARSHIP = "1";
    };

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

      # ファイル操作
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -la --icons --git";
      la = "eza -a --icons";
      lt = "eza --tree --icons";

      # 検索（fd は find と構文が異なるためエイリアスなし）
      grep = "rg";

      # システムモニタリング
      pp = "procs";
      dst = "dust";
      btm = "btm";
    };
  };

  # p10k.zshをホームディレクトリに配置
  home.file.".p10k.zsh".source = ./p10k.zsh;
}
