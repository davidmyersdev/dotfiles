#!/usr/bin/env bats

setup() {
  REPO_ROOT="$(cd "${BATS_TEST_DIRNAME}/../../../../.." && pwd)"

  load "${REPO_ROOT}/node_modules/bats-support/load"
  load "${REPO_ROOT}/node_modules/bats-assert/load"

  HOOK="${BATS_TEST_DIRNAME}/enforce-read.sh"
}

assert_allowed() {
  run bash "$HOOK" <<< "$(make_input "$1")"

  assert_success
  assert_output ''
}

assert_denied() {
  run bash "$HOOK" <<< "$(make_input "$1")"

  assert_success
  assert_output --partial '"permissionDecision": "deny"'
}

make_input() {
  jq -nc --arg command "$1" '{
    cwd: "/tmp",
    hook_event_name: "PreToolUse",
    permission_mode: "default",
    session_id: "test",
    tool_input: {
      command: $command,
      description: "test",
    },
    tool_name: "Bash",
    tool_use_id: "test",
  }'
}

@test 'blocks bat' { assert_denied 'bat README.md'; }
@test 'blocks cat' { assert_denied 'cat README.md'; }
@test 'blocks head' { assert_denied 'head file.txt'; }
@test 'blocks less' { assert_denied 'less file.txt'; }
@test 'blocks more' { assert_denied 'more file.txt'; }
@test 'blocks tail' { assert_denied 'tail -f log.txt'; }

@test 'blocks piped reader' { assert_denied 'echo hi | cat'; }
@test 'blocks chained reader' { assert_denied 'ls && cat file.txt'; }
@test 'blocks absolute path' { assert_denied '/usr/bin/cat x'; }

# shellcheck disable=SC2016
@test 'blocks subshell reader' { assert_denied 'echo $(cat file.txt)'; }
@test 'blocks git cat-file' { assert_denied 'git cat-file -p HEAD:README.md'; }

@test 'blocks uppercase' { assert_denied 'CAT file'; }
@test 'blocks mixed case' { assert_denied 'Tail log.txt'; }

@test 'allows cattle' { assert_allowed 'echo cattle'; }
@test 'allows catalog' { assert_allowed 'echo catalog'; }
@test 'allows category' { assert_allowed 'echo category'; }
@test 'allows header' { assert_allowed 'echo header'; }
@test 'allows tailwind' { assert_allowed 'tailwind build'; }
@test 'allows concatenate' { assert_allowed 'echo concatenate'; }

@test 'allows ls' { assert_allowed 'ls -la'; }
@test 'allows git' { assert_allowed 'git status'; }
@test 'allows echo' { assert_allowed 'echo hello world'; }
@test 'allows grep' { assert_allowed 'grep -r pattern .'; }
@test 'allows mkdir' { assert_allowed 'mkdir -p foo/bar'; }

@test 'deny payload has required fields' {
  run bash "$HOOK" <<< "$(make_input 'cat README.md')"

  assert_success

  run jq -e '
    .hookSpecificOutput.hookEventName == "PreToolUse"
    and .hookSpecificOutput.permissionDecision == "deny"
    and (.hookSpecificOutput.permissionDecisionReason | type) == "string"
    and (.hookSpecificOutput.permissionDecisionReason | length) > 0
  ' <<< "$output"

  assert_success
}
