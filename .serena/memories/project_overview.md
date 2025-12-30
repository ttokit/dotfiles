# Project Overview

## 目的
macOS (Apple Silicon) 向けの Nix ベース dotfiles リポジトリ

## 技術スタック
- **Nix Flakes** - エントリーポイント
- **nix-darwin** - macOS システム設定
- **Home Manager** - ユーザー環境管理（nix-darwin のモジュールとして統合）
- **Determinate Nix** - 公式インストーラーではなくこちらを使用

## アーキテクチャ
```
flake.nix                    # エントリーポイント - inputs と darwinConfigurations を定義
├── darwin/default.nix       # macOS システム設定（nix-darwin）
└── home/
    ├── default.nix          # Home Manager エントリ - 全モジュールをインポート
    ├── git.nix              # Git 設定
    ├── zsh.nix              # Zsh 設定（プロンプト含む）
    ├── ghostty.nix          # Ghostty ターミナル設定
    └── claude.nix           # Claude Code 設定
        └── claude/
            └── settings.json # Claude Code プラグイン設定
```

## 管理対象
- **Home Manager**: CLI ツール設定（Git, Zsh, Ghostty, Claude Code）、パッケージ
- **nix-darwin**: macOS システム設定
- **Homebrew**: GUI アプリ、更新頻度の高いバイナリ（Claude Code 本体など）
