# Task Completion Checklist

## Nix 設定変更後

### 1. 新規ファイル追加時
```bash
git add <new-file.nix>
```
Nix が認識するには Git での追跡が必要

### 2. 設定の適用
```bash
sudo darwin-rebuild switch --flake .#ttokit-mac-mini
```

### 3. 動作確認
- 変更した設定が反映されているか確認
- 新しいパッケージがインストールされているか確認

### 4. コミット
```bash
git status
git add <changed-files>
git commit -m "変更内容を説明"
```

## 注意事項
- このプロジェクトにはリンターやフォーマッターは設定されていない
- Nix の評価エラーはビルド時に検出される
- `$HOME` の所有権に関する警告は無害
