# CLAUDE.md

## Context7

Use the Context7 MCP tools (resolve the library id, then get the docs) when code generation, setup or configuration steps depend on a library, framework or API, or when I need library/API documentation. Do this without me having to ask.

## Code Style Guidelines

- 自明なコードコメントは書かないでください
- コードから読み取れず、そこを変更する判断に必要な制約（不採用にした案とその理由を含む）はコメントに残す。ただし根拠は確認できたもの（要件・計測結果・履歴・実際に比較した結果）に限り、推測で理由を補わないこと
- 不要な空白は削除してください
- ファイルの末尾には必ず改行を入れること（新規作成・編集問わず）

## GitHub Operations

- GitHubのリソース（リポジトリ、Issue、PR、コード等）は gh コマンドで取得する。WebFetch や WebSearch は使わない
- ghコマンドがTLSエラーで失敗した場合、sandboxモードが原因の可能性が高い。sandboxを無効化してリトライすること

## Git Commit Messages

Conventional Commits 形式で、description は日本語で記述する。
破壊的変更は `!` を付与（例: `feat!: 認証APIを変更`）

## Git Worktree

worktree の作成・削除は git-wt（`git wt`）を使い、素の `git worktree add` は使わない。
配置先・コピー対象・フックは各リポジトリの `wt.*` git config に定義されているため、
素の git worktree で作るとそれらが適用されない。

- 作成: `WT=$(git wt --nocd <branch> origin/<デフォルトブランチ> | tail -1)`
  cd はシェル関数なのでエージェントからは効かない。最終行に出るパスを使う
- 削除: `git wt -d <branch>`（`-D` は force なのでユーザーの指示がある場合のみ）
- `wt.*` config は勝手に変更しない
- 例外: 使い捨ての detached worktree（特定コミットの確認など）は `git worktree add --detach` でよい
- git-wt が未導入の環境では素の `git worktree` にフォールバックする

## Development Philosophy

- TDD を採用（テスト先行）

## 入力スタイル

音声入力を使用することがあります。句読点や疑問符の欠落、固有名詞の表記揺れが含まれる場合があるため、文脈から意図を推測してください。

## Agent Guidelines

- 過剰な正確さよりシンプルさを優先すること
- YAGNI、KISS、DRY を徹底する
- 後方互換のための shim やフォールバックは、循環的複雑度を増やさない場合のみ許容する

## 成果物の書き方

PR説明・チケットのコメント・設計ドキュメントなど、他人が読む成果物には制作過程を書かない。
載せるのは結論と、読み手が判断を追うために必要な根拠だけ。

- ローカルレビュー（Codex等）の指摘一覧や「レビュー指摘を反映した」という節
- 会話・打ち合わせ・文字起こしから得た経緯（「朝会で〜と言われたので」「誰々の発言では」）
- 検討したが採らなかった案の列挙、指示された制約そのものへの言及

これらは書かず、そこから生まれた判断の内容だけを説明する。

## 日本語文章の推敲

他人が読む日本語の文章は、投稿・送信・コピー渡しの前に必ず推敲スキルを通す。
対象は Slack、GitHub の PR説明・レビューコメント・返信、Issue や Redmine のチケット本文とコメント、設計ドキュメント、メール、記事。

- 短い業務コミュニケーション（レビュー返信、Slack、チケットコメント）→ `workplace-japanese`
- 長文（PR説明、チケット本文、設計ドキュメント、記事、レポート）→ `natural-japanese`

明示的に「文章を書いて」と依頼されていなくても、上記の媒体に出す文面を作る場面では必ず通す。
他のスキルやワークフロー（PRレビュー対応、チケット起票など）の工程の内側で文面が発生する場合も同じ。
推敲では結論・事実・コミットハッシュ・技術用語を変えない。何を直すかは各推敲スキルに従う。

@RTK.md

<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->

[archify explainer: proactive] Make an Archify explainer page, unasked, for explanations, comparisons, decisions, diagnoses, reviews and plans that need a table, steps or several sections.
archify の出力先は作業ディレクトリではなく `~/archify/<repo>/<type>-<slug>-<YYYYMMDD-HHMMSS>/` にする。<repo> は `git rev-parse --git-common-dir` の親ディレクトリ名、リポジトリ外では `_misc`。
archify の explainer の下書きには必ず `@meta locale=en` を入れる（日本語ロケールが無く、未指定だと画面の文言が中国語になるため）。本文は日本語で書く。
archify の HTML は finalize の後に、中国語フォント名（PingFang SC、Hiragino Sans GB、Microsoft YaHei、Noto Sans SC、Songti SC、STSong、Noto Serif SC、Source Han Serif SC、Noto Sans Mono CJK SC）を日本語フォント（Hiragino Sans、Hiragino Kaku Gothic ProN、Yu Gothic UI、Noto Sans JP、Hiragino Mincho ProN、Yu Mincho、Noto Serif JP、Source Han Serif JP、Noto Sans Mono CJK JP）に置換し、`<html lang>` を `ja` にする。
