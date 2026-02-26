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
- ghコマンドがTLSエラーで失敗した場合、sandboxモードが原因の可能性が高い。sandboxを無効化してリトライすること

## Git Commit Messages

Conventional Commits 形式で、description は日本語で記述する。
破壊的変更は `!` を付与（例: `feat!: 認証APIを変更`）

## Development Philosophy

- TDD を採用（テスト先行）

## Agent Guidelines

- 過剰な正確さよりシンプルさを優先すること
- YAGNI、KISS、DRY を徹底する
- 後方互換のための shim やフォールバックは、循環的複雑度を増やさない場合のみ許容する
