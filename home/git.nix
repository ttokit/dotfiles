{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # グローバル .gitignore
    ignores = [
      # macOS
      ".DS_Store"
      "._*"
      ".Spotlight-V100"
      ".Trashes"

      # エディタ
      "*.swp"
      "*~"
      ".idea/"
      ".vscode/"

      # Nix
      "result"
      "result-*"
    ];

    # Git 設定（新しい settings 形式）
    settings = {
      # ユーザー情報（後で変更してください）
      user = {
        name = "Your Name";
        email = "your.email@example.com";
      };

      # よく使うエイリアス
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        amend = "commit --amend --no-edit";
      };

      # その他の設定
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      push.autoSetupRemote = true;
      rerere.enabled = true; # 同じコンフリクトを自動解決
    };
  };
}
