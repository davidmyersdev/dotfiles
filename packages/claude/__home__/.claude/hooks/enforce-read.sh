#!/usr/bin/env bash

# https://code.claude.com/docs/en/hooks#common-input-fields
# https://code.claude.com/docs/en/hooks#pretooluse-input
#
# {
#   "cwd": "/Users/david/workspace/dotfiles",
#   "hook_event_name": "PreToolUse",
#   "permission_mode": "default",
#   "session_id": "213da10f-dbb1-4b8f-a5b5-4dc7572ad482",
#   "tool_input": {
#     "command": "cat README.md",
#     "description": "Display README contents",
#   },
#   "tool_name": "Bash",
#   "tool_use_id": "toolu_01abc123",
#   "transcript_path": "/Users/david/.claude/projects/-Users-david-workspace-dotfiles/213da10f-dbb1-4b8f-a5b5-4dc7572ad482.jsonl",
# }
input=$(cat)

commands_to_block=(
  bat
  cat
  head
  less
  more
  tail
)

commands_to_block_pattern=$(IFS='|'; echo "${commands_to_block[*]}")

if echo "$input" | jq -r '.tool_input.command' | rg -iq "\\b(${commands_to_block_pattern})\\b" > /dev/null
then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "Reading files via Bash is not allowed.",
      additionalContext: "Try to use the Read tool instead.",
    },
  }'
fi
