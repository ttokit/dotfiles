# CLAUDE.md

## Conversation Guidelines

- 常に日本語で会話する

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

## Learning Documentation

For every project, write a detailed FOR_TTOKIT.md file that explains the whole project in plain language.

**File location:** `~/.claude/learnings/{project-name}/FOR_TTOKIT.md`

**When to create/update:**
- When explicitly requested by the user
- After completing a significant milestone or feature
- After fixing a non-trivial bug (especially when: root cause was unexpected, debugging took significant effort, or the fix revealed important insights about the system)
- When learning a new technology, pattern, or best practice through the work
- After making an important architectural decision

**Content to include:**
- Technical architecture and how the codebase is structured
- How the various parts are connected
- Technologies used and why we made these technical decisions
- Lessons learned: bugs encountered and how we fixed them, potential pitfalls and how to avoid them, new technologies used, best practices discovered

**Style requirements:**
- Write in Japanese (日本語で記述すること)
- Make it engaging to read; avoid boring technical documentation style
- Use analogies and anecdotes where appropriate to make concepts understandable and memorable
- Focus on the "why" behind decisions, not just the "what"
