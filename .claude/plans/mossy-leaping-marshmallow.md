# zsh補完で大文字小文字を区別しない設定

## 概要

zshの補完（タブ補完）時に大文字小文字を区別せず、`~/dow` → `~/Downloads` のようにサジェストされるようにする。

## 現状

- `home/zsh.nix` で `enableCompletion = true` が設定済み
- 大文字小文字を区別しない補完設定（`zstyle matcher-list`）がない

## 変更内容

### 修正ファイル

- `home/zsh.nix`

### 追加する設定

`initExtra` に以下を追加：

```nix
initExtra = ''
  # 大文字小文字を区別しない補完
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
'';
```

この設定により：
- `dow<Tab>` → `Downloads` にマッチ
- `DOW<Tab>` → `downloads` にもマッチ
- 双方向で大文字小文字を無視した補完が可能

## 検証手順

1. ビルド確認
   ```bash
   darwin-rebuild build --flake .#ttokit-mac-mini
   ```

2. 適用
   ```bash
   sudo darwin-rebuild switch --flake .#ttokit-mac-mini
   ```

3. 新しいターミナルを開いて動作確認
   ```bash
   cd ~/dow<Tab>  # → ~/Downloads に補完されることを確認
   ```
