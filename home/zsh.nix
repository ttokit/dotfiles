{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    # macOS 標準プロンプトを再現
    # %n=ユーザー名, %m=ホスト名, %1~=カレントディレクトリ, %#=プロンプト記号
    initContent = ''
      PS1="%n@%m %1~ %# "
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
}
