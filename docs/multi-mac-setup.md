# 複数Mac環境の管理

現在は単一ホスト（ttokit-mac-mini）のみ。別のMacを追加する場合の一般的なアプローチ。

## アプローチ

1. **複数ホストをコミット** - flake.nix に複数の darwinConfigurations を定義
2. **共通設定のモジュール化** - `modules/` に共通部分を抽出
3. **flake-parts/Blueprint** - 自動発見機能で接続コード削減

## 参考リポジトリ

- [billimek/dotfiles](https://github.com/billimek/dotfiles)
- [clo4/nix-dotfiles](https://github.com/clo4/nix-dotfiles)
