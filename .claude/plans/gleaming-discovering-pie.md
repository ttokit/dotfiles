# モダンCLIツール導入計画

## 概要

従来のUNIXコマンド（cat, ls, find, grep, ps, du, top）をRust製モダンツールに置換し、TokyoNightテーマで統一された美しいターミナル環境を構築する。

## 導入ツール一覧

| 元コマンド | モダンツール | エイリアス設定 |
|-----------|-------------|---------------|
| cat | bat | `cat=bat` (完全置換) |
| ls | eza | `ls=eza --icons`, `ll=eza -la --icons --git`, `la=eza -a --icons`, `lt=eza --tree --icons` |
| find | fd | エイリアスなし（構文が異なる） |
| grep | ripgrep | `grep=rg` (完全置換) |
| cd | zoxide | cd置換モード |
| ps | procs | `pp=procs` (別名) |
| du | dust | `dst=dust` (別名) |
| top | bottom | `btm=bottom` (別名) |
| - | fzf | Ctrl+R/T, Alt+C |
| - | delta | git pager |
| p10k | starship | 環境変数で切替 |

## ファイル構成

```
.
├── docs/
│   └── modern-cli-cheatsheet.md  # [新規] チートシート
└── home/
    ├── default.nix        # imports追加
    ├── modern-cli.nix     # [新規] bat, eza, fd, rg, procs, dust, bottom
    ├── fzf.nix            # [新規] fzf + zsh統合
    ├── zoxide.nix         # [新規] zoxide + cd置換
    ├── starship.nix       # [新規] starship + Tokyo Night
    ├── git.nix            # [変更] delta統合
    ├── zsh.nix            # [変更] エイリアス追加, プロンプト切替
    └── yazi.nix           # [変更] 新ツール統合
```

## 実装詳細

### 1. home/modern-cli.nix（新規作成）

```nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat      # cat置換
    eza      # ls置換
    fd       # find置換
    ripgrep  # grep置換
    procs    # ps置換
    dust     # du置換
    bottom   # top置換
  ];

  programs.bat = {
    enable = true;
    config.theme = "tokyonight";  # または "TwoDark"
  };
}
```

### 2. home/fzf.nix（新規作成）

```nix
{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;  # Ctrl+R, Ctrl+T, Alt+C
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
  };
}
```

### 3. home/zoxide.nix（新規作成）

```nix
{ ... }:
{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];  # cd置換モード
  };
}
```

### 4. home/starship.nix（新規作成）

```nix
{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = false;  # zsh.nixで条件付き有効化
    settings = {
      # Tokyo Night preset + カスタマイズ
      format = "$directory$git_branch$git_status$nodejs$python$rust$character";
      # ... Tokyo Night色設定
    };
  };
}
```

### 5. home/git.nix（変更）

追加内容:
```nix
programs.git.delta = {
  enable = true;
  options = {
    navigate = true;
    side-by-side = true;
    line-numbers = true;
    syntax-theme = "tokyonight";
  };
};
```

### 6. home/zsh.nix（変更）

追加エイリアス:
```nix
shellAliases = {
  # 既存
  cc = "claude";
  lg = "lazygit";

  # 新規: ファイル操作
  cat = "bat";
  ls = "eza --icons";
  ll = "eza -la --icons --git";
  la = "eza -a --icons";
  lt = "eza --tree --icons";

  # 新規: 検索（fd は構文が異なるためエイリアスなし）
  grep = "rg";

  # 新規: システム（別名併用）
  pp = "procs";
  dst = "dust";
  btm = "btm";
};
```

プロンプト切替ロジック:
```nix
sessionVariables = {
  USE_STARSHIP = "1";  # デフォルトで Starship 有効
};

initExtra = ''
  # プロンプト切替（USE_STARSHIP=1 で Starship、未設定で p10k）
  if [[ -n "$USE_STARSHIP" ]]; then
    eval "$(starship init zsh)"
  else
    # Powerlevel10k 設定（USE_STARSHIP="" で切り替え可能）
    ...
  fi
'';
```

**切り替え方法:**
- デフォルト: Starship
- p10kに戻す: `USE_STARSHIP= zsh` または `unset USE_STARSHIP && exec zsh`

### 7. home/yazi.nix（変更）

新ツール統合設定を追加（プレビューアーにbat使用など）

### 8. home/default.nix（変更）

新規モジュールのimport追加:
```nix
imports = [
  ./git.nix
  ./zsh.nix
  ./ghostty.nix
  ./claude.nix
  ./ssh.nix
  ./yazi.nix
  ./npm.nix
  # 新規
  ./modern-cli.nix
  ./fzf.nix
  ./zoxide.nix
  ./starship.nix
];
```

## 検証手順

1. **ビルド確認**
   ```bash
   darwin-rebuild build --flake .#ttokit-mac-mini
   ```

2. **適用**
   ```bash
   sudo darwin-rebuild switch --flake .#ttokit-mac-mini
   ```

3. **ツール動作確認**
   ```bash
   cat --version   # bat
   ls              # eza with icons
   ll              # eza with git status
   fd -e nix             # find の代替（構文が異なる）
   grep "pattern" .      # rg
   cd ~/git        # zoxide learning
   cd dotfiles     # zoxide jump
   pp              # procs
   dst             # dust
   btm             # bottom
   ```

4. **fzf統合確認**
   - `Ctrl+R`: コマンド履歴検索
   - `Ctrl+T`: ファイル検索
   - `Alt+C`: ディレクトリ移動

5. **プロンプト確認**
   ```bash
   # デフォルト: Starship（適用後すぐに有効）

   # p10k に戻したい場合
   USE_STARSHIP= zsh
   ```

6. **git diff確認**
   ```bash
   git diff        # delta でシンタックスハイライト
   git log -p      # delta で美しい表示
   ```

## チートシート（docs/modern-cli-cheatsheet.md）

新規作成するチートシートの構成:

```markdown
# モダンCLIツール チートシート

## bat（cat置換）
- 機能: シンタックスハイライト付きファイル表示
- 基本: `cat file.txt` → 行番号+ハイライト
- オプション: `-p` プレーンモード、`-l` 言語指定

## eza（ls置換）
- 機能: アイコン付きファイル一覧
- 基本: `ls`, `ll`, `la`, `lt`
- オプション: `--git` gitステータス、`--tree` ツリー表示

## fd（find代替）
- 機能: 高速ファイル検索（find とは構文が異なる）
- 基本: `fd pattern` → パターンにマッチするファイル
- オプション: `-e nix` 拡張子指定、`-t f` ファイルのみ、`-t d` ディレクトリのみ

## ripgrep（grep置換）
- 機能: 超高速テキスト検索
- 基本: `grep pattern` → コード内検索
- オプション: `-i` 大文字小文字無視、`-C 3` 前後3行表示

## fzf（ファジー検索）
- 機能: あいまい検索インターフェース
- キーバインド: Ctrl+R 履歴、Ctrl+T ファイル、Alt+C ディレクトリ
- パイプ: `ls | fzf` で選択

## zoxide（cd置換）
- 機能: 学習型ディレクトリジャンプ
- 基本: `cd dirname` → 頻度ベースでジャンプ
- インタラクティブ: `cdi` で fzf 選択

## delta（git diff強化）
- 機能: git差分の美しい表示
- 自動: `git diff`, `git show`, `git log -p` で有効
- オプション: `-s` サイドバイサイド表示

## procs（ps置換）
- 機能: カラフルなプロセス一覧
- 基本: `pp` → プロセス一覧
- オプション: `--tree` ツリー表示

## dust（du置換）
- 機能: ディスク使用量をグラフィカルに表示
- 基本: `dst` → カレントディレクトリ
- オプション: `-d 2` 深さ2まで

## bottom（top置換）
- 機能: システムモニター（TUI）
- 基本: `btm` → インタラクティブモニター
- 操作: q 終了、? ヘルプ

## starship（プロンプト）
- 切替: `USE_STARSHIP=1 zsh` で有効化
- 設定: ~/.config/starship.toml
```

## 注意事項

- **TokyoNight テーマ**: bat, fzf, delta, starship すべてで統一
- **zoxide学習**: 使用するほどジャンプ精度が向上
- **Nerd Font必須**: HackGen NF が既に設定済みなので問題なし
- **エイリアス注意**: シェルスクリプト内では元コマンドが使用される
- **fd は find の代替**: 構文が異なるためエイリアスなし。`fd -e nix` = `find -name "*.nix"`

## ロールバック

問題が発生した場合:
1. `git checkout` で変更前の状態に戻す
2. `darwin-rebuild switch` で再適用
