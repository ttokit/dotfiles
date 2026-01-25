# CLAUDE.md

## Context7

Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.

## Code Style Guidelines

- 自明なコードコメントは書かないでください
- 不要な空白は削除してください
- ファイルの末尾には必ず改行を入れること（新規作成・編集問わず）

## GitHub Operations

- GitHubのリソース（リポジトリ、Issue、PR、コード等）を取得する際は、常にghコマンドを使用する
- WebFetchやWebSearchではなく、ghコマンドを優先する

## Git Commit Messages

Conventional Commits 形式で、description は日本語で記述する。
破壊的変更は `!` を付与（例: `feat!: 認証APIを変更`）

## Development Philosophy

- TDD を採用（テスト先行）
