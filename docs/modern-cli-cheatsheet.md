# モダンCLIツール チートシート

従来のUNIXコマンドをRust製モダンツールに置換した環境のリファレンス。

## クイックリファレンス

| 元コマンド | 新コマンド | エイリアス |
|-----------|-----------|-----------|
| cat | bat | `cat` |
| ls | eza | `ls`, `ll`, `la`, `lt` |
| find | fd | なし（構文が異なる） |
| grep | ripgrep | `grep` |
| cd | zoxide | `cd`（自動学習） |
| ps | procs | `pp` |
| du | dust | `dst` |
| top | bottom | `btm` |

---

## bat（cat置換）

シンタックスハイライト付きファイル表示。

```bash
cat file.txt          # 行番号+ハイライト表示
cat -p file.txt       # プレーンモード（装飾なし）
cat -l rust file.txt  # 言語を明示指定
cat -A                # 全ファイルのテーマ一覧
cat --list-themes     # 利用可能なテーマを表示
```

---

## eza（ls置換）

アイコン付きの美しいファイル一覧。

```bash
ls                    # アイコン付き一覧
ll                    # 詳細表示 + git ステータス
la                    # 隠しファイル含む
lt                    # ツリー表示
lt -L 2               # ツリー（深さ2まで）
eza --git-ignore      # .gitignore を尊重
eza -s modified       # 更新日時でソート
```

---

## fd（find代替）

高速で直感的なファイル検索。`find` とは構文が異なるためエイリアスなし。

```bash
fd pattern            # パターンにマッチするファイル
fd "\.nix$"           # 正規表現で検索
fd -t f               # ファイルのみ
fd -t d               # ディレクトリのみ
fd -e nix             # 拡張子で絞り込み
fd -H                 # 隠しファイルも含む
fd . -x rm            # マッチしたファイルを削除（確認あり）
```

---

## ripgrep（grep置換）

超高速テキスト検索。

```bash
grep pattern          # コード内検索
grep -i pattern       # 大文字小文字を無視
grep -C 3 pattern     # 前後3行も表示
grep -w word          # 単語として検索
grep -t nix pattern   # ファイルタイプで絞り込み
grep -l pattern       # マッチしたファイル名のみ
grep --hidden pattern # 隠しファイルも検索
```

---

## fzf（ファジー検索）

あいまい検索インターフェース。

### キーバインド

| キー | 動作 |
|------|------|
| `Ctrl+R` | コマンド履歴検索 |
| `Ctrl+T` | ファイル検索（カレントディレクトリ） |
| `Alt+C` | ディレクトリ移動 |

### パイプ活用

```bash
ls -la | fzf          # 出力から選択
cat $(fzf)            # 選択したファイルを表示
vim $(fzf)            # 選択したファイルを編集
kill $(ps aux | fzf)  # プロセスを選んでkill
```

---

## zoxide（cd置換）

学習型スマートディレクトリジャンプ。

```bash
cd dirname            # 通常のcd + 学習
cd dotfiles           # 頻度ベースでジャンプ
cd git dot            # 複数キーワードで絞り込み
cdi                   # fzf でインタラクティブ選択
```

**ポイント**: 使えば使うほど賢くなる。よく訪れるディレクトリへのジャンプが高速化。

---

## delta（git diff強化）

美しいシンタックスハイライト付きdiff。

```bash
git diff              # delta で自動表示
git show HEAD         # コミット詳細も美しく
git log -p            # パッチ付きログも対応
git diff --side-by-side  # サイドバイサイド表示
```

### delta 操作

| キー | 動作 |
|------|------|
| `n` | 次の変更箇所へ |
| `N` | 前の変更箇所へ |
| `q` | 終了 |

---

## procs（ps置換）

カラフルなプロセス一覧。

```bash
pp                    # プロセス一覧
pp --tree             # ツリー表示
pp node               # キーワードでフィルタ
pp --sortd cpu        # CPU使用率でソート
pp --sortd mem        # メモリ使用量でソート
```

---

## dust（du置換）

ディスク使用量をグラフィカルに表示。

```bash
dst                   # カレントディレクトリ
dst -d 2              # 深さ2まで
dst /path             # 指定パスを解析
dst -r                # 逆順表示
```

---

## bottom（top置換）

モダンなシステムモニター（TUI）。

```bash
btm                   # インタラクティブモニター起動
```

### 操作キー

| キー | 動作 |
|------|------|
| `Tab` | ウィジェット切替 |
| `e` | プロセスツリー展開 |
| `k` | プロセスをkill |
| `s` | ソート変更 |
| `?` | ヘルプ表示 |
| `q` | 終了 |

---

## starship（プロンプト）

ミニマルで高速なプロンプト（TokyoNight テーマ）。

### 切り替え

```bash
# デフォルト: Starship が有効

# p10k に戻す
USE_STARSHIP= zsh

# または
unset USE_STARSHIP && exec zsh
```

---

## ヒント

### シェルスクリプトでは元コマンドを使う

エイリアスはインタラクティブシェルでのみ有効。スクリプト内では `/bin/cat`, `/usr/bin/find` など元コマンドを使用。

### Nerd Font が必要

アイコン表示には Nerd Font が必要。この環境では `HackGen NF` が設定済み。

### 困ったら

```bash
bat --help            # ヘルプ表示
eza --help
fd --help
rg --help
```
