# CLAUDE.md

## Conversation Guidelines

- 常に日本語で会話する

## Context7

Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.

## Code Style Guidelines

- 自明なコードコメントは書かないでください
- 不要な空白は削除してください
- 新規ファイルを作成する際は必ず末尾に改行を足すこと

## GitHub Operations

- GitHubのリソース（リポジトリ、Issue、PR、コード等）を取得する際は、常にghコマンドを使用する
- WebFetchやWebSearchではなく、ghコマンドを優先する

## Git Commit Messages

Conventional Commits 1.0.0 の形式でコミットメッセージを作成：

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Type 一覧

- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマット等）
- `refactor`: バグ修正や機能追加ではないコード変更
- `perf`: パフォーマンス改善
- `test`: テストの追加・修正
- `chore`: ビルドプロセスやツールの変更

### ルール

- type は英語のまま使用
- description（説明文）は日本語で記述
- 破壊的変更がある場合は `!` を付与（例: `feat!: 認証APIを変更`）

### 例

- `feat: ユーザー認証機能を追加`
- `fix(auth): ログイン時のエラーハンドリングを修正`
- `docs: READMEにインストール手順を追加`
- `refactor: 認証モジュールの構造を整理`

## Development Philosophy

### Test-Driven Development (TDD)

- 原則としてテスト駆動開発（TDD）で進める
- 期待される入出力に基づき、まずテストを作成する
- 実装コードは書かず、テストのみを用意する
- テストを実行し、失敗を確認する
- テストが正しいことを確認できた段階でコミットする
- その後、テストをパスさせる実装を進める
- 実装中はテストを変更せず、コードを修正し続ける
- すべてのテストが通過するまで繰り返す
