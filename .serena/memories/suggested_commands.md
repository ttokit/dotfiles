# Suggested Commands

## 設定変更の適用
```bash
sudo darwin-rebuild switch --flake .#ttokit-mac-mini
```
- `sudo` はシステムアクティベーションに必要
- `$HOME` の所有権に関する警告は無害

## 新しい .nix ファイルを追加した場合
```bash
git add <new-file.nix>
```
Nix が認識するには Git での追跡が必要

## Git コマンド
```bash
git status          # 変更確認
git add <files>     # ステージング
git commit -m "..."  # コミット
```

## システムユーティリティ（Darwin/macOS）
```bash
ls -la              # ファイル一覧
cd <dir>            # ディレクトリ移動
grep -r "pattern" . # 検索
find . -name "*.nix" # ファイル検索
```

## 注意
- このプロジェクトにはテスト、リント、フォーマットコマンドは設定されていない
- Nix の評価はビルド時に行われる
