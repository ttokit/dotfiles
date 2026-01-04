# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概要

macOS (Apple Silicon) 向けの Nix ベース dotfiles リポジトリ。以下を使用：
- **Nix Flakes** - エントリーポイント
- **nix-darwin** - macOS システム設定
- **Home Manager** - ユーザー環境管理（nix-darwin のモジュールとして統合）
- **Determinate Nix** - 公式インストーラーではなくこちらを使用

## コマンド

### 設定変更の適用
```bash
sudo darwin-rebuild switch --flake .#ttokit-mac-mini
```

`sudo` はシステムアクティベーションに必要。`$HOME` の所有権に関する警告は無害。

### Claude Code での検証

Claude Code ではインタラクティブなパスワード入力ができないため、`sudo darwin-rebuild switch` は実行できない。代わりにビルドのみで検証：

```bash
darwin-rebuild build --flake .#ttokit-mac-mini
```

実際の適用はユーザーが手動で `sudo darwin-rebuild switch` を実行する。

### 新しい .nix ファイルを追加した場合
Nix が認識するには Git での追跡が必要：
```bash
git add <new-file.nix>
```

## アーキテクチャ

```
flake.nix                    # エントリーポイント - inputs と darwinConfigurations を定義
├── darwin/default.nix       # macOS システム設定（nix-darwin）
└── home/
    ├── default.nix          # Home Manager エントリ - 全モジュールをインポート
    ├── git.nix              # Git 設定（programs.git.settings を使用）
    ├── zsh.nix              # Zsh 設定（プロンプト含む）
    └── ghostty.nix          # Ghostty ターミナル設定
```

## 実装上の注意点

### Determinate Nix との互換性
Determinate Nix は独自のデーモンを管理するため、`darwin/default.nix` で `nix.enable = false` を設定して競合を回避。

### Home Manager の統合方式
Home Manager は nix-darwin のモジュールとして組み込まれている（スタンドアロンではない）。設定変更は `home-manager switch` ではなく `darwin-rebuild switch` で適用。

### homeDirectory のオーバーライド
sudo 実行時の null 値競合を防ぐため、`home.homeDirectory` には `lib.mkForce` が必要。

### Git 設定の形式
Home Manager の最新版では、非推奨の `userName`, `userEmail`, `aliases`, `extraConfig` ではなく `programs.git.settings` を使用。

### Ghostty 設定
Ghostty は設定ファイルを順番に読み込み、後のファイルが優先される：
1. `~/.config/ghostty/config`（Home Manager が生成）
2. `~/Library/Application Support/com.mitchellh.ghostty/config`

両方存在すると後者が優先される。Home Manager の設定を使うには Application Support の config を削除またはリネーム。

### 複数Mac環境の管理（将来の検討事項）
現在は単一ホスト（ttokit-mac-mini）のみ。別のMacを追加する場合の一般的なアプローチ：

1. **複数ホストをコミット** - flake.nix に複数の darwinConfigurations を定義
2. **共通設定のモジュール化** - `modules/` に共通部分を抽出
3. **flake-parts/Blueprint** - 自動発見機能で接続コード削減

参考: [billimek/dotfiles](https://github.com/billimek/dotfiles), [clo4/nix-dotfiles](https://github.com/clo4/nix-dotfiles)
