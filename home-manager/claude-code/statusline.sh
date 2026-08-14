#!/usr/bin/env bash

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
CONTEXT=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
GIT_BRANCH=$(git branch --show-current)

echo "model:$MODEL dir:${DIR##*/} branch:$GIT_BRANCH context:${CONTEXT}%"
