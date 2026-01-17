{ config, pkgs, ... }:

{
  # delta（美しいdiff表示）
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "TwoDark";
    };
  };

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

    # Git 設定
    settings = {
      # ユーザー情報
      user = {
        name = "Tatsuya Toki";
        email = "tatsuya.toki@access-company.com";
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
