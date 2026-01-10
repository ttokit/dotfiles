#!/bin/bash
# Claude Code通知サウンド - セッションごとに異なるサウンドを再生
#
# 使用方法:
#   Claude CodeのNotificationフックから呼び出される
#   stdinからJSON形式で通知データを受け取り、session_idに基づいて
#   固定のサウンドを選択して再生する

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')

# macOSシステムサウンドの配列
sounds=(
  "/System/Library/Sounds/Glass.aiff"
  "/System/Library/Sounds/Ping.aiff"
  "/System/Library/Sounds/Tink.aiff"
  "/System/Library/Sounds/Pop.aiff"
  "/System/Library/Sounds/Basso.aiff"
  "/System/Library/Sounds/Blow.aiff"
  "/System/Library/Sounds/Bottle.aiff"
  "/System/Library/Sounds/Frog.aiff"
  "/System/Library/Sounds/Funk.aiff"
  "/System/Library/Sounds/Hero.aiff"
)

# セッションIDをハッシュしてサウンドインデックスを決定
hash=$(echo -n "$session_id" | md5 | cut -c1-8)
index=$((16#$hash % ${#sounds[@]}))

afplay "${sounds[$index]}" &
