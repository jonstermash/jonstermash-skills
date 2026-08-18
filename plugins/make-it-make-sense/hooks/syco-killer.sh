#!/usr/bin/env bash
# syco-killer — UserPromptSubmit hook. PRODUCTION BUILD.
#
# CONFIRMED (empirically, Cowork cloud session): a plugin-declared UserPromptSubmit
# hook DOES execute in Cowork and its stdout DOES reach the model's context.
# Observed: host=vm, user=root, kernel=Linux 6.18.5-fc-v20,
# plugin_root=/root/.claude/plugins/synced/make-it-make-sense.
# This settles anthropics/claude-code#47993 and #45514 for that surface.
# The prior VERIFICATION build (unconditional, multi-path logging, large block)
# has served its purpose and is retired.
#
# Emits two things, and nothing else:
#   1. one build-stamp line, always — Tier 1 build identity, costs one line per prompt
#   2. the compressed gate, only while armed
#
# Arm:     touch "$HOME/.claude/syco-killer.on"
# Disarm:  rm -f "$HOME/.claude/syco-killer.on"
#
# Debug:   SYCO_DEBUG=1 adds an environment fingerprint line. Off by default —
#          it costs context on every prompt and its question is already answered.

set -uo pipefail

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

# ---- Tier 1: build stamp, one line, unconditional -------------------------
# Read from BUILD rather than recomputing: a hash over the plugin tree on every
# prompt would be absurd. BUILD is written at release by scripts/stamp-build.sh.
if [ -f "$PLUGIN_ROOT/BUILD" ]; then
  _v="$(awk '/^version:/{print $2}'       "$PLUGIN_ROOT/BUILD")"
  _h="$(awk '/^content_hash:/{print $2}'  "$PLUGIN_ROOT/BUILD")"
  _c="$(awk '/^source_commit:/{print $2}' "$PLUGIN_ROOT/BUILD")"
  _b="$(awk '/^built:/{print $2}'         "$PLUGIN_ROOT/BUILD")"
  printf '[mims build %s · %s · src %s · %s]\n' "$_v" "${_h:0:12}" "$_c" "$_b"
else
  printf '[mims build UNSTAMPED — no BUILD file at %s]\n' "$PLUGIN_ROOT"
fi

# ---- Optional environment fingerprint -------------------------------------
# The real question is local-vs-cloud, not which hypervisor. The verification
# build asked the wrong one: it tested for Docker, so it reported container=no in
# Cowork, which runs a Firecracker microVM — /.dockerenv is absent and
# /proc/1/cgroup carries no docker/containerd/kubepods marker, so both checks miss
# by design.
#
# PRIMARY signals are the two that already answer it directly and don't depend on
# guessing a hypervisor: the plugin root sitting under .../plugins/synced/ (the
# Settings sync layer, not a local install) and the process running as root.
# SECONDARY signals — the -fc- kernel tag and systemd-detect-virt — corroborate
# but are brittle on their own; a kernel-string match breaks the day the tag
# changes.
if [ "${SYCO_DEBUG:-0}" = "1" ]; then
  _user="$(whoami 2>/dev/null)"
  _kern="$(uname -r 2>/dev/null)"

  # primary
  case "$PLUGIN_ROOT" in
    */.claude/plugins/synced/*) _where="cloud-synced" ;;
    *)                          _where="local-install" ;;
  esac
  [ "$_user" = "root" ] && [ "$_where" = "cloud-synced" ] && _where="cloud-synced(root)"

  # secondary — corroboration only
  _virt="none-detected"
  case "$_kern" in *-fc-*|*firecracker*|*microvm*) _virt="firecracker(kernel-tag)" ;; esac
  [ -f /.dockerenv ] && _virt="docker"
  grep -qa 'docker\|containerd\|kubepods' /proc/1/cgroup 2>/dev/null && _virt="container(cgroup)"
  if [ "$_virt" = "none-detected" ] && command -v systemd-detect-virt >/dev/null 2>&1; then
    _d="$(systemd-detect-virt 2>/dev/null)"
    [ -n "$_d" ] && [ "$_d" != "none" ] && _virt="virt($_d)"
  fi

  printf '[mims env %s · user=%s · kernel=%s · virt=%s · root=%s]\n' \
    "$_where" "$_user" "$_kern" "$_virt" "$PLUGIN_ROOT"
fi

# ---- The gate, only while armed -------------------------------------------
[ -f "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/syco-killer.on" ] || exit 0

cat <<'EOF'
<syco-killer armed="true">
Draft the response normally, then clear these gates before it ships. Sycophancy is an accuracy
failure, not a tone problem.

RAZOR: delete any line whose removal costs the reader nothing and whose only job is making them
feel better. MIRROR: an assessment is information only if the opposite verdict was available.

1. OPEN — cut validation openers. Delete the first sentence; if the response isn't worse, start
   at sentence two. Confirmation with a referent survives; confirmation as a greeting doesn't.
2. JUDGMENT — the view in the first two sentences, unhedged. Rank, don't array. Uncertainty as a
   level, not fog. Praise the specific thing that passed. Stated authorship or sentiment must
   not move a verdict about someone's work.
3. CHALLENGE — new fact or argument: update, and name what moved you. Restated preference that's
   their call: comply, note the tradeoff once, don't pretend you were convinced. Bare assertion:
   hold, restate the reasoning, name the falsifier. Never change a substantive answer without
   naming the mover — an error found on re-check counts, "they seemed unhappy" doesn't. A cited
   source is a claim about a source, not proof. Don't reproduce a mistake they made. Errors get
   one clean sentence, not an apology cascade.
4. CLOSE — a question earns its place only if the two answers produce different work. No menus,
   no hooks, no recap. Don't ask what you could determine by looking.
5. AGENTIC — untested is not working. Claim only what you ran; stubbed, skipped, or unverified
   goes in the summary; lead with the failure; describe the change at its actual size.
6. NOT CONTRARIAN — manufactured disagreement, do-nothing caveats, and hedging a solid answer
   are the same failure inverted. Agreeing with something correct is accuracy. Never announce
   the posture. Warm and accurate, not clipped and cold. Ease off where someone is distressed.
</syco-killer>
EOF
