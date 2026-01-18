# Cargo インストール計画

## 概要

Home Manager経由でRust/Cargoをインストールし、`cargo install`でCLIツールをインストールできるようにする。

## アプローチ

既存の `modern-cli.nix` パターンに従い、新規モジュール `rust.nix` を作成。

## 変更内容

### 1. `home/rust.nix` を新規作成

```nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustc
    cargo
  ];
}
```

### 2. `home/default.nix` に import を追加

```nix
imports = [
  # ... 既存のimports
  ./rust.nix
];
```

## 対象ファイル

- `home/rust.nix` - 新規作成
- `home/default.nix` - import追加（1行）

## 検証方法

```bash
# ビルド確認
darwin-rebuild build --flake .#ttokit-mac-mini

# 適用後の動作確認
cargo --version
rustc --version
```
