# Nix Dotfiles

macOS (Apple Silicon) 向けの Nix ベース dotfiles。Nix Flakes + nix-darwin + Home Manager（モジュール統合）+ Determinate Nix を使用。

## コマンド

```bash
# 設定変更の適用（sudo必須）
sudo darwin-rebuild switch --flake .#ttokit-mac-mini

# Claude Code での検証（ビルドのみ）
darwin-rebuild build --flake .#ttokit-mac-mini

# 新しい .nix ファイル追加時（Git追跡が必要）
git add <new-file.nix>
```

## アーキテクチャ

```
flake.nix                    # エントリーポイント
├── darwin/default.nix       # macOS システム設定
└── home/
    ├── default.nix          # Home Manager エントリ
    ├── git.nix              # Git 設定
    ├── zsh.nix              # Zsh 設定
    └── ghostty.nix          # Ghostty ターミナル設定
```

## 参照

- @docs/multi-mac-setup.md - 複数Mac環境の管理（将来用）

## Individual Preferences
<!-- Optional: personal instructions (not committed) -->
- @~/.claude/dotfiles-instructions.md
