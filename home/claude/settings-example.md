# Claude Code settings.json 設定例

`~/.claude/settings.json` の設定例。このファイルは Claude Code が自動更新するため、
dotfiles では直接管理せず、参考用としてドキュメント化している。

## 設定例

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "model": "opus",
  "language": "Japanese",
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/notification-sound.sh"
          }
        ]
      }
    ]
  },
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0
  },
  "enabledPlugins": {
    "example-skills@anthropic-agent-skills": true,
    "code-review@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true,
    "pr-review-toolkit@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "code-simplifier@claude-plugins-official": true,
    "typescript-lsp@claude-plugins-official": true
  }
}
```

## 設定項目の説明

| 項目 | 説明 |
|------|------|
| `model` | 使用するモデル（`opus`, `sonnet` など） |
| `language` | 出力言語 |
| `hooks.Notification` | 通知時に実行するコマンド |
| `statusLine` | ステータスライン表示用コマンド |
| `enabledPlugins` | 有効化するプラグイン |

## 注意事項

- `feedbackSurveyState` などの動的な項目は Claude Code が自動生成するため、上記例には含めていない
- スクリプト（`statusline.sh`, `notification-sound.sh`）は Home Manager で `~/.claude/` に配置される
