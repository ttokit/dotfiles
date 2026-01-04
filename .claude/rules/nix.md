---
paths: "**/*.nix"
description: Nix configuration guidelines for this dotfiles repository. Use when editing or creating .nix files.
---

# Nix ファイル編集ガイドライン

## Determinate Nix との互換性

Determinate Nix は独自のデーモンを管理するため、`darwin/default.nix` で `nix.enable = false` を設定して競合を回避。

## Home Manager の統合方式

Home Manager は nix-darwin のモジュールとして組み込まれている（スタンドアロンではない）。設定変更は `home-manager switch` ではなく `darwin-rebuild switch` で適用。

## homeDirectory のオーバーライド

sudo 実行時の null 値競合を防ぐため、`home.homeDirectory` には `lib.mkForce` が必要。

## Git 設定の形式

Home Manager の最新版では、非推奨の `userName`, `userEmail`, `aliases`, `extraConfig` ではなく `programs.git.settings` を使用。

## Ghostty 設定

Ghostty は設定ファイルを順番に読み込み、後のファイルが優先される：
1. `~/.config/ghostty/config`（Home Manager が生成）
2. `~/Library/Application Support/com.mitchellh.ghostty/config`

両方存在すると後者が優先される。Home Manager の設定を使うには Application Support の config を削除またはリネーム。
