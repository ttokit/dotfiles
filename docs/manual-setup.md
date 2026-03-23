# 手動セットアップ手順

`darwin-rebuild switch` では自動化できない手順のまとめ。

## 1. ブートストラップ

```bash
# 1. Determinate Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. dotfiles を clone して適用
git clone https://github.com/ttokit/dotfiles.git ~/ghq/github.com/ttokit/dotfiles
cd ~/ghq/github.com/ttokit/dotfiles
sudo darwin-rebuild switch --flake .#ttokit-mac-mini
```

## 2. 手動インストールが必要なアプリ

cask に存在しないため、個別にインストールが必要。

| アプリ | インストール方法 |
|---|---|
| Claude Code | `curl -fsSL https://claude.ai/install.sh \| bash` |
| Dia | [dia.md](https://dia.md/) からダウンロード |
| RunCat | Mac App Store |
| VoiceOS | [voiceos.com](https://voiceos.com/) からダウンロード |
| Usage4Claude | 配布元からダウンロード |

## 3. 手動設定が必要な項目

- 1Password: 初回ログイン・Touch ID 設定
- Google Chrome: プロファイル同期
- Slack: ワークスペースへのサインイン
- Cursor: Settings Sync
- Raycast: 設定のインポート
