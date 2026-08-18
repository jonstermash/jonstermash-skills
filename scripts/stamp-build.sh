#!/usr/bin/env bash
# stamp-build.sh — write a build stamp into the plugin so a loaded build can identify itself.
#
# Usage:
#   scripts/stamp-build.sh                write the stamp
#   scripts/stamp-build.sh --check        recompute and compare; exit 1 on drift
#   scripts/stamp-build.sh --check <dir>  same, against an arbitrary plugin tree
#
# The <dir> form exists so scripts/verify-loaded-build.sh can check the SYNCED
# copy without duplicating the hash algorithm. One implementation, one source of
# truth — a verifier that reimplements the thing it verifies proves nothing.
#
# ---------------------------------------------------------------------------
# THE CIRCULARITY, AND WHAT I CHOSE
# ---------------------------------------------------------------------------
# Two things in the stamp look self-referential. Only one actually is.
#
# 1. CONTENT HASH — not circular, once the stamp file is excluded from its own
#    input. That exclusion is what makes it well-defined: the hash covers a fixed
#    file set that never includes BUILD, so writing BUILD cannot change the value
#    BUILD records. Deterministic and recomputable from any checkout, which makes
#    it the ONE field that can actually be verified. It is the real identity.
#
# 2. COMMIT SHA — genuinely circular, and unsolvable as literally specified.
#    Stamping "the commit that contains this stamp" cannot work: writing the SHA
#    changes the tree, which changes the commit, which changes the SHA. Fixed-point
#    iteration doesn't converge for a cryptographic hash. Amending doesn't help —
#    the amended commit has a new SHA too.
#
#    Options considered:
#      (a) Record the parent commit (HEAD at stamp time) and label it honestly.
#      (b) Don't commit the stamp; generate it into a release artifact instead.
#          Rejected: Cowork syncs from the repo tree, so an uncommitted stamp
#          never reaches the running build. This is the whole problem.
#      (c) Post-commit hook that rewrites the stamp after committing.
#          Rejected: leaves the working tree dirty after every commit and the
#          rewritten stamp is itself uncommitted — same failure as (b), plus churn.
#
#    CHOSE (a). `source_commit` is HEAD at stamp time, the PARENT of the commit
#    carrying the stamp. Permanent off-by-one, labelled rather than papered over.
#
#    TRADEOFF: source_commit is advisory. Use content_hash to prove identity.
#
# ---------------------------------------------------------------------------
# DRIFT vs UNEXPECTED FILES
# ---------------------------------------------------------------------------
# Measured on a live synced tree: the sync layer adds and strips nothing, and it
# preserves the executable bit. But a plugin can write into its OWN root at
# runtime — the pre-1.4.0 hook wrote hook-fired.log there — and a naive
# "hash every file present" would read that as content drift on the next check.
#
# So the stamp records the FILE SET it hashed. `--check` then hashes exactly that
# set and sorts differences into two buckets:
#   DRIFT      a recorded file is missing, or its bytes changed  -> exit 1
#   UNEXPECTED a file exists that wasn't recorded                -> reported, exit 0
# Known runtime-written paths are excluded outright and named as such, so they
# show up as neither.
# ---------------------------------------------------------------------------

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_DIR="$REPO_ROOT/plugins/make-it-make-sense"
STAMP_NAME="BUILD"

# Paths the plugin may write into its own root at runtime. Never hashed, never
# reported as unexpected. Add to this list rather than letting a check go red.
RUNTIME_PATHS="hook-fired.log"

if [ "${1:-}" = "--check" ] && [ -n "${2:-}" ]; then
  PLUGIN_DIR="$(cd "$2" 2>/dev/null && pwd)" || { echo "FAIL: no such directory: $2" >&2; exit 1; }
fi
STAMP_FILE="$PLUGIN_DIR/$STAMP_NAME"

sha256() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum | cut -d' ' -f1
  else shasum -a 256 | cut -d' ' -f1
  fi
}

is_runtime_path() {
  for r in $RUNTIME_PATHS; do [ "$1" = "$r" ] && return 0; done
  return 1
}

# Every file currently in the tree, excluding BUILD and known runtime artifacts.
current_files() {
  cd "$PLUGIN_DIR" || return 1
  find . -type f ! -name "$STAMP_NAME" -print \
    | sed 's|^\./||' \
    | while IFS= read -r f; do is_runtime_path "$f" || printf '%s\n' "$f"; done \
    | LC_ALL=C sort
}

# Hash a specific list of paths, in the given order. Paths are part of the digest
# input, so a rename changes the hash. Missing file -> non-zero.
hash_list() {
  cd "$PLUGIN_DIR" || return 1
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    [ -f "$f" ] || { echo "__MISSING__ $f"; return 3; }
    printf '%s  %s\n' "$(sha256 < "$f")" "$f"
  done | sha256
}

# ------------------------------------------------------------------ check mode
if [ "${1:-}" = "--check" ]; then
  [ -f "$STAMP_FILE" ] || { echo "FAIL: no $STAMP_NAME file at $STAMP_FILE" >&2; exit 1; }

  RECORDED_HASH="$(awk '/^content_hash:/{print $2}' "$STAMP_FILE")"
  # NOTE: print into a temp var and `next`. Using sub() on $0 then falling through
  # to the terminator rule tests the ALREADY-STRIPPED line, which no longer has the
  # leading indent — so it exits after the first entry and silently hashes one file.
  # That bug made --check fail identically no matter what changed. Don't reintroduce it.
  RECORDED_LIST="$(awk '/^files:/{f=1;next} f&&/^  [^ ]/{s=$0;sub(/^  /,"",s);print s;next} f{exit}' "$STAMP_FILE")"

  if [ -z "$RECORDED_LIST" ]; then
    echo "FAIL: stamp has no recorded file list — re-stamp with this version of the script" >&2
    exit 1
  fi

  # DRIFT: any recorded file missing?
  MISSING=""
  for f in $RECORDED_LIST; do
    [ -f "$PLUGIN_DIR/$f" ] || MISSING="${MISSING}${MISSING:+ }$f"
  done
  if [ -n "$MISSING" ]; then
    echo "FAIL: DRIFT — recorded file(s) missing from the tree:" >&2
    for f in $MISSING; do echo "         $f" >&2; done
    exit 1
  fi

  ACTUAL_HASH="$(printf '%s\n' "$RECORDED_LIST" | hash_list)"

  # UNEXPECTED: present now, not recorded. Reported, not drift.
  # RECORDED_LIST is newline-delimited; flatten it before the membership test or
  # every single file reads as unexpected (the pattern would never match).
  RECORDED_FLAT=" $(printf '%s\n' "$RECORDED_LIST" | tr '\n' ' ') "
  EXTRA=""
  CURRENT="$(current_files)"
  for f in $CURRENT; do
    case "$RECORDED_FLAT" in *" $f "*) ;; *) EXTRA="${EXTRA}${EXTRA:+ }$f" ;; esac
  done

  # Runtime artifacts present — named, so they read as expected rather than alarming.
  ARTIFACTS=""
  for r in $RUNTIME_PATHS; do
    [ -f "$PLUGIN_DIR/$r" ] && ARTIFACTS="${ARTIFACTS}${ARTIFACTS:+ }$r"
  done

  if [ "$ACTUAL_HASH" != "$RECORDED_HASH" ]; then
    echo "FAIL: DRIFT — recorded files are present but their bytes changed" >&2
    echo "  recorded: $RECORDED_HASH" >&2
    echo "  actual:   $ACTUAL_HASH" >&2
    exit 1
  fi

  echo "OK: content_hash matches ($RECORDED_HASH) over $(printf '%s\n' "$RECORDED_LIST" | wc -l | tr -d ' ') recorded files"
  [ -n "$ARTIFACTS" ] && echo "NOTE: runtime artifact(s) present, excluded by design: $ARTIFACTS"
  if [ -n "$EXTRA" ]; then
    echo "UNEXPECTED: file(s) present that were not in the stamp (NOT drift):"
    for f in $EXTRA; do echo "         $f"; done
    echo "         Expected right after a file is added or removed in the repo but before"
    echo "         re-stamping, or if the running plugin wrote into its own root."
  fi
  exit 0
fi

# ------------------------------------------------------------------ write mode
VERSION="$(python3 -c "import json;print(json.load(open('$PLUGIN_DIR/.claude-plugin/plugin.json'))['version'])")"
FILES="$(current_files)"
HASH="$(printf '%s\n' "$FILES" | hash_list)"
COUNT="$(printf '%s\n' "$FILES" | wc -l | tr -d ' ')"

SHA="$(git -C "$REPO_ROOT" rev-parse --short HEAD)"
DIRTY=""
git -C "$REPO_ROOT" diff --quiet HEAD -- "$PLUGIN_DIR" || DIRTY=" (uncommitted changes present at stamp time)"
BUILT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

{
  echo "# Build stamp. Generated by scripts/stamp-build.sh — do not edit by hand."
  echo "version:       $VERSION"
  echo "content_hash:  $HASH"
  echo "source_commit: $SHA$DIRTY"
  echo "built:         $BUILT"
  echo "file_count:    $COUNT"
  echo "files:"
  printf '%s\n' "$FILES" | sed 's/^/  /'
  echo ""
  echo "# content_hash covers exactly the files listed above — not 'whatever is in the"
  echo "# directory'. A file appearing later is reported as UNEXPECTED, not as drift,"
  echo "# so a plugin writing into its own root can't fake a content mismatch."
  echo "# Verify from any checkout: scripts/stamp-build.sh --check [dir]"
  echo "#"
  echo "# source_commit is the PARENT of the commit carrying this stamp — writing the"
  echo "# stamp changes the tree, so a commit cannot record its own SHA. It is advisory."
  echo "# Use content_hash to prove which build you are running."
} > "$STAMP_FILE"

echo "stamped $STAMP_FILE"
echo "  version:       $VERSION"
echo "  content_hash:  $HASH"
echo "  source_commit: $SHA$DIRTY"
echo "  built:         $BUILT"
echo "  files hashed:  $COUNT"
