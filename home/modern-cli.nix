{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat      # cat置換: シンタックスハイライト付きファイル表示
    eza      # ls置換: アイコン付きファイル一覧
    fd       # find置換: 高速ファイル検索
    ripgrep  # grep置換: 超高速テキスト検索
    procs    # ps置換: カラフルなプロセス一覧
    dust     # du置換: グラフィカルなディスク使用量表示
    bottom   # top置換: モダンなシステムモニター
  ];

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };
}
