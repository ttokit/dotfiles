#!/bin/bash

input=$(cat)

model_name=$(echo "$input" | jq -r '.model.display_name' | sed 's/ *(.*)$//')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Context percentage: prefer used_percentage, fallback to manual calculation
context_percent=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -z "$context_percent" ] || [ "$context_percent" = "null" ]; then
    context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 1000000')
    current_usage=$(echo "$input" | jq '.context_window.current_usage')
    if [ "$current_usage" != "null" ]; then
        current_tokens=$(echo "$current_usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
        autocompact_buffer=33000
        effective_size=$((context_size - autocompact_buffer))
        context_percent=$((current_tokens * 100 / effective_size))
        [ $context_percent -gt 100 ] && context_percent=100
    else
        context_percent=0
    fi
else
    context_percent=$(printf "%.0f" "$context_percent")
fi

# Rate limits
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

session_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [ -n "$session_cost" ] && [ "$session_cost" != "null" ] && [ "$session_cost" != "empty" ]; then
    session_cost=$(printf "%.4f" "$session_cost")
else
    session_cost=""
fi

# Directory name (truncate to 15 chars)
dir_name=$(basename "$current_dir")
max_dir_len=15
if [ ${#dir_name} -gt $max_dir_len ]; then
    dir_name="${dir_name:0:$max_dir_len}…"
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
DIM='\033[2m'
NC='\033[0m'

# True color gradient: green(0%) → yellow(50%) → red(100%)
rate_gradient() {
    local pct=$1
    if [ $pct -lt 50 ]; then
        local r=$((pct * 255 / 50))
        printf '\033[38;2;%d;200;80m' "$r"
    else
        local g=$((200 - (pct - 50) * 4))
        [ $g -lt 0 ] && g=0
        printf '\033[38;2;255;%d;60m' "$g"
    fi
}

braille_bar() {
    local pct=$1
    local width=8
    local chars=(' ' '⣀' '⣄' '⣤' '⣦' '⣶' '⣷' '⣿')
    [ $pct -lt 0 ] && pct=0
    [ $pct -gt 100 ] && pct=100
    local bar=""
    for ((i=0; i<width; i++)); do
        local seg_start=$((i * 100 / width))
        local seg_end=$(((i + 1) * 100 / width))
        if [ $pct -ge $seg_end ]; then
            bar+="${chars[7]}"
        elif [ $pct -le $seg_start ]; then
            bar+="${chars[0]}"
        else
            local frac=$(((pct - seg_start) * 7 / (seg_end - seg_start)))
            [ $frac -gt 7 ] && frac=7
            bar+="${chars[$frac]}"
        fi
    done
    echo -n "$bar"
}

fmt_bar() {
    local label=$1
    local pct=$2
    local color
    color=$(rate_gradient $pct)
    local bar
    bar=$(braille_bar $pct)
    echo -n "${DIM}${label}${NC} ${color}${bar}${NC} ${pct}%"
}

# Git info
cd "$current_dir" 2>/dev/null || cd /

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null || echo "detached")
    max_branch_len=20
    if [ ${#branch} -gt $max_branch_len ]; then
        branch="${branch:0:$max_branch_len}…"
    fi
    status_output=$(git status --porcelain 2>/dev/null)

    if [ -n "$status_output" ]; then
        total_files=$(echo "$status_output" | wc -l | xargs)
        line_stats=$(git diff --numstat HEAD 2>/dev/null | awk '{added+=$1; removed+=$2} END {print added+0, removed+0}')
        added=$(echo $line_stats | cut -d' ' -f1)
        removed=$(echo $line_stats | cut -d' ' -f2)

        git_info=" ${YELLOW}($branch${NC} ${YELLOW}|${NC} ${GRAY}${total_files} files${NC}"
        [ "$added" -gt 0 ] && git_info="${git_info} ${GREEN}+${added}${NC}"
        [ "$removed" -gt 0 ] && git_info="${git_info} ${RED}-${removed}${NC}"
        git_info="${git_info} ${YELLOW})${NC}"
    else
        git_info=" ${YELLOW}($branch)${NC}"
    fi
else
    git_info=""
fi

cost_info=""
if [ -n "$session_cost" ]; then
    cost_info=" ${GRAY}[\$$session_cost]${NC}"
fi

# Line 1: dir | model | git
line1="${BLUE}${dir_name}${NC} ${GRAY}|${NC} ${CYAN}${model_name}${NC}"
[ -n "$git_info" ] && line1="${line1} ${GRAY}|${NC}${git_info}"

# Line 2: ctx | 5h | 7d | cost (braille bars)
line2=$(fmt_bar "ctx" "$context_percent")

if [ -n "$five_hour_pct" ] && [ "$five_hour_pct" != "null" ]; then
    five_int=$(printf "%.0f" "$five_hour_pct")
    line2="${line2} ${GRAY}|${NC} $(fmt_bar "5h" "$five_int")"
fi

if [ -n "$seven_day_pct" ] && [ "$seven_day_pct" != "null" ]; then
    seven_int=$(printf "%.0f" "$seven_day_pct")
    line2="${line2} ${GRAY}|${NC} $(fmt_bar "7d" "$seven_int")"
fi

line2="${line2}${cost_info}"

echo -e "${line1}\n${line2}"
