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
