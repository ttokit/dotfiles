# Style & Conventions

## Nix コードスタイル

### モジュール構造
```nix
{ config, pkgs, lib, ... }:

{
  # 設定項目
}
```

### コメント
- 日本語コメントを使用
- `#` でインラインコメント

### 命名規則
- ファイル名: ケバブケース（`default.nix`, `git.nix`）
- 設定モジュール: 機能ごとに分離（git.nix, zsh.nix, ghostty.nix, claude.nix）

## 実装上の注意点

### Determinate Nix との互換性
`darwin/default.nix` で `nix.enable = false` を設定（Determinate Nix が独自のデーモンを管理するため）

### Home Manager の統合方式
- nix-darwin のモジュールとして組み込み（スタンドアロンではない）
- 設定変更は `home-manager switch` ではなく `darwin-rebuild switch` で適用

### homeDirectory のオーバーライド
`home.homeDirectory` には `lib.mkForce` が必要（sudo 実行時の null 値競合を防ぐ）

### Git 設定の形式
`programs.git.settings` を使用（`userName`, `userEmail`, `aliases`, `extraConfig` は非推奨）

### Ghostty 設定
設定ファイルの優先順位:
1. `~/.config/ghostty/config`（Home Manager が生成）
2. `~/Library/Application Support/com.mitchellh.ghostty/config`（後者が優先）
