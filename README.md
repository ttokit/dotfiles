# dotfiles

macOS (Apple Silicon) 向けの Nix ベース dotfiles リポジトリ。

## 使用技術

- **[Nix Flakes](https://nixos.wiki/wiki/Flakes)** - 再現可能なパッケージ管理
- **[nix-darwin](https://github.com/LnL7/nix-darwin)** - macOS システム設定の宣言的管理
- **[Home Manager](https://github.com/nix-community/home-manager)** - ユーザー環境の宣言的管理
- **[Determinate Nix](https://github.com/DeterminateSystems/nix-installer)** - 推奨 Nix インストーラー

## セットアップ

### 1. Determinate Nix のインストール

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### 2. リポジトリのクローン

```bash
git clone https://github.com/ttokit/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

### 3. 設定の適用

```bash
sudo darwin-rebuild switch --flake .#ttokit-mac-mini
```

## ディレクトリ構成

```
flake.nix                    # エントリーポイント
├── darwin/default.nix       # macOS システム設定
└── home/
    ├── default.nix          # Home Manager エントリ
    ├── git.nix              # Git 設定
    ├── zsh.nix              # Zsh 設定
    ├── ghostty.nix          # Ghostty ターミナル設定
    └── claude.nix           # Claude Code 設定
```

## 新しいMacでのセットアップ

別のMacでこの設定を使用する場合、ホスト名が異なる場合は以下を変更：

| ファイル | 変更箇所 |
|---------|---------|
| `flake.nix` | `darwinConfigurations."ホスト名"` |

ホスト名の確認：

```bash
scutil --get LocalHostName
```

## 設定変更の適用

設定ファイルを編集した後：

```bash
sudo darwin-rebuild switch --flake .#ttokit-mac-mini
```

## 参考リンク

- [Nix公式マニュアル](https://nixos.org/manual/nix/stable/)
- [nix-darwin オプション一覧](https://daiderd.com/nix-darwin/manual/index.html)
- [Home Manager オプション一覧](https://nix-community.github.io/home-manager/options.xhtml)
