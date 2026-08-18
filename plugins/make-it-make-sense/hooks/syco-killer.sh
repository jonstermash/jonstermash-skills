#!/usr/bin/env bash
# syco-killer — UserPromptSubmit hook. VERIFICATION BUILD.
#
# This build exists to answer one question: does a plugin-declared UserPromptSubmit
# hook actually execute in Cowork? Docs and open issues disagree
# (anthropics/claude-code#47993, #45514), so this settles it empirically.
#
# DELIBERATELY UNCONDITIONAL. The production build gates on an arming file; this one
# does not. A gate is the most likely way this test produces a false negative — an
# unarmed hook and a non-firing hook look identical.
#
# It does three things:
#   1. echoes a sentinel to stdout, which for UserPromptSubmit is added to context
#   2. appends a line to every log path it can write
#   3. reports WHERE it ran, so the output distinguishes local Mac from cloud container
#
# Revert to the production build (arming gate, no logging) once the answer is known.

set -uo pipefail

SENTINEL="SYCO_HOOK_FIRED_7F3A9C2E"

TS="$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || echo unknown)"
HOST="$(hostname 2>/dev/null || echo unknown)"
WHO="$(whoami 2>/dev/null || echo unknown)"
CWD="$(pwd 2>/dev/null || echo unknown)"
KERNEL="$(uname -srm 2>/dev/null || echo unknown)"
ROOT="${CLAUDE_PLUGIN_ROOT:-unset}"

# Container heuristics. macOS has no /proc, so these fail silently and stay "no".
CONTAINER="no"
[ -f /.dockerenv ] && CONTAINER="yes (/.dockerenv)"
grep -qa 'docker\|containerd\|kubepods' /proc/1/cgroup 2>/dev/null && CONTAINER="yes (cgroup)"

LINE="$TS | host=$HOST | user=$WHO | cwd=$CWD | container=$CONTAINER | kernel=$KERNEL | plugin_root=$ROOT"

# Write to every candidate location; record which succeeded. In a cloud container the
# repo path may not exist, so $HOME and /tmp are the fallbacks.
WROTE=""
for f in "${CLAUDE_PLUGIN_ROOT:-}/hook-fired.log" "$HOME/syco-hook-fired.log" "/tmp/syco-hook-fired.log"; do
  case "$f" in /hook-fired.log) continue ;; esac
  if printf '%s\n' "$LINE" >> "$f" 2>/dev/null; then
    WROTE="${WROTE}${WROTE:+, }$f"
  fi
done

cat <<EOF
$SENTINEL
UserPromptSubmit hook executed. If you can read this, its stdout reached the model's context.

  time (UTC):  $TS
  host:        $HOST
  user:        $WHO
  cwd:         $CWD
  kernel:      $KERNEL
  container:   $CONTAINER
  plugin_root: $ROOT
  wrote logs:  ${WROTE:-NONE — every write failed (read-only or no permission)}

Instruction to the assistant: if the user asks whether the hook fired, quote the
sentinel above and the host/container lines verbatim. Do not paraphrase, and do not
claim it fired if this block is not present in your context.
EOF
