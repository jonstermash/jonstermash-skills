#!/usr/bin/env bash
# check-repo.sh — the release invariants, enforced rather than remembered.
#
# Usage:
#   scripts/check-repo.sh        run every check; exit 1 if any ERROR fired
#
# Run by .github/workflows/checks.yml on push and pull_request, and runnable by
# hand before committing. One implementation, one source of truth — the workflow
# calls this script rather than reimplementing the checks in YAML.
#
# ---------------------------------------------------------------------------
# WHY THESE FOUR
# ---------------------------------------------------------------------------
# Each one maps to a way an install has actually broken, or can break silently:
#
#   1. JSON PARSE     a malformed manifest takes the marketplace down entirely.
#   2. VERSION PARITY the failure this script was written for. 79e2728 bumped
#                     plugin.json and left marketplace.json on 1.4.0; the /plugin
#                     GUI reads the catalog, so a shipped release reached nobody.
#                     stamp-build.sh --check cannot see this: marketplace.json
#                     lives OUTSIDE the plugin dir and is not in the hashed set.
#   3. STAMP DRIFT    delegated to stamp-build.sh --check. Catches a shipped file
#                     edited without re-stamping, which makes the build line the
#                     hook prints every prompt describe a build nobody is running.
#   4. SKILL NAME     no explicit `name:` and the invocation name falls back to
#                     the install directory — a version string for marketplace
#                     installs, so it changes on every update and the skill
#                     silently becomes uninvocable. Nothing errors; it just stops
#                     working.
#
# ---------------------------------------------------------------------------
# ERROR vs WARN
# ---------------------------------------------------------------------------
# Only invariants that BREAK something are errors. The description length check
# warns instead: 1,536 is the documented default for the combined description and
# when_to_use text, it's configurable via skillListingMaxDescChars, and overflow
# is silent truncation in the skill listing rather than a failure. Failing a build
# on a configurable default would re-enact the v0.4.0 mistake of enforcing a cap
# the tooling never imposed — this repo already spent a release retiring a number
# it had enforced wrongly for four versions. Report it, don't gate on it.
# ---------------------------------------------------------------------------

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT" || exit 1

MARKETPLACE=".claude-plugin/marketplace.json"
PLUGIN_JSON="plugins/make-it-make-sense/.claude-plugin/plugin.json"
BUILD_FILE="plugins/make-it-make-sense/BUILD"
SKILLS_DIR="plugins/make-it-make-sense/skills"
DESC_LIMIT=1536

FAILED=0
err()  { echo "  ERROR: $*"; FAILED=1; }
warn() { echo "  WARN:  $*"; }
ok()   { echo "  ok:    $*"; }

# ------------------------------------------------------------ 1. JSON parses
echo "[1/4] manifests parse as JSON"
for f in "$MARKETPLACE" "$PLUGIN_JSON"; do
  if [ ! -f "$f" ]; then
    err "$f is missing"
  elif python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" 2>/dev/null; then
    ok "$f"
  else
    err "$f is not valid JSON"
    python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" 2>&1 | sed 's/^/         /'
  fi
done

# -------------------------------------------------------- 2. version parity
# Four places record the version and all four must agree. Read each from its own
# file rather than deriving one from another, or the check can't see a mismatch.
echo "[2/4] version parity across all four sources"
MKT_V="$(python3 -c "
import json
try: print(json.load(open('$MARKETPLACE'))['plugins'][0]['version'])
except Exception: print('')
" 2>/dev/null)"
PLG_V="$(python3 -c "
import json
try: print(json.load(open('$PLUGIN_JSON'))['version'])
except Exception: print('')
" 2>/dev/null)"
BLD_V="$(awk '/^version:/{print $2; exit}' "$BUILD_FILE" 2>/dev/null)"
# Top-most '## [x.y.z]' heading in the changelog.
CHG_V="$(awk 'match($0, /^## \[([0-9]+\.[0-9]+\.[0-9]+)\]/) {
  s = substr($0, RSTART, RLENGTH); gsub(/^## \[|\]$/, "", s); print s; exit
}' CHANGELOG.md 2>/dev/null)"

printf '         %-34s %s\n' "$MARKETPLACE"  "${MKT_V:-<unreadable>}"
printf '         %-34s %s\n' "$PLUGIN_JSON" "${PLG_V:-<unreadable>}"
printf '         %-34s %s\n' "$BUILD_FILE"  "${BLD_V:-<unreadable>}"
printf '         %-34s %s\n' "CHANGELOG.md (latest entry)" "${CHG_V:-<unreadable>}"

if [ -z "$MKT_V" ] || [ -z "$PLG_V" ] || [ -z "$BLD_V" ] || [ -z "$CHG_V" ]; then
  err "could not read a version from every source (see <unreadable> above)"
elif [ "$MKT_V" = "$PLG_V" ] && [ "$PLG_V" = "$BLD_V" ] && [ "$BLD_V" = "$CHG_V" ]; then
  ok "all four agree on $MKT_V"
else
  err "versions disagree — bump every source together, then re-stamp"
fi

# ---------------------------------------------------------- 3. build stamp
echo "[3/4] build stamp matches the plugin tree"
if [ ! -x scripts/stamp-build.sh ]; then
  err "scripts/stamp-build.sh is missing or not executable"
else
  if STAMP_OUT="$(scripts/stamp-build.sh --check 2>&1)"; then
    printf '%s\n' "$STAMP_OUT" | sed 's/^/         /'
    ok "stamp verified"
  else
    printf '%s\n' "$STAMP_OUT" | sed 's/^/         /'
    err "stamp drift — run scripts/stamp-build.sh and commit the result"
  fi
fi

# ------------------------------------------------------ 4. SKILL.md frontmatter
echo "[4/4] every SKILL.md declares an explicit name"
SKILL_REPORT="$(python3 - "$SKILLS_DIR" "$DESC_LIMIT" <<'PY'
import os, sys

skills_dir, limit = sys.argv[1], int(sys.argv[2])

def frontmatter(path):
    """Parse the leading --- block. Handles folded scalars (>- , > , |) since
    both skills use them; a folded value joins on spaces, which is what the
    listing counts."""
    with open(path, encoding="utf-8") as fh:
        lines = fh.read().split("\n")
    if not lines or lines[0].strip() != "---":
        return None
    try:
        end = lines.index("---", 1)
    except ValueError:
        return None
    fields, key, buf = {}, None, []
    for raw in lines[1:end]:
        if raw[:1] not in (" ", "\t") and ":" in raw:
            if key:
                fields[key] = " ".join(buf).strip()
            k, _, v = raw.partition(":")
            key, v = k.strip(), v.strip()
            buf = [] if v in (">-", ">", "|", "|-", "") else [v]
        elif key:
            buf.append(raw.strip())
    if key:
        fields[key] = " ".join(buf).strip()
    return fields

if not os.path.isdir(skills_dir):
    print("ERR|no skills directory at %s" % skills_dir)
    sys.exit(0)

found = False
for name in sorted(os.listdir(skills_dir)):
    path = os.path.join(skills_dir, name, "SKILL.md")
    if not os.path.isfile(path):
        continue
    found = True
    fm = frontmatter(path)
    if fm is None:
        print("ERR|%s has no YAML frontmatter block" % path)
        continue
    declared = fm.get("name", "").strip()
    if not declared:
        print("ERR|%s has no explicit `name:` — the invocation name would fall "
              "back to the install directory" % path)
    elif declared != name:
        print("ERR|%s declares name '%s' but lives in directory '%s'"
              % (path, declared, name))
    else:
        print("OK|%s -> /%s" % (path, declared))
    # Advisory only. See the ERROR vs WARN note at the top of check-repo.sh.
    n = len(fm.get("description", "")) + len(fm.get("when_to_use", ""))
    if n > limit:
        print("WARN|%s: description + when_to_use is %d chars, over the %d-char "
              "listing default (silently truncated, not an error)"
              % (path, n, limit))

if not found:
    print("ERR|no SKILL.md files found under %s" % skills_dir)
PY
)"

while IFS='|' read -r level msg; do
  [ -z "$level" ] && continue
  case "$level" in
    OK)   ok "$msg" ;;
    WARN) warn "$msg" ;;
    *)    err "$msg" ;;
  esac
done <<< "$SKILL_REPORT"

echo
if [ "$FAILED" -eq 0 ]; then
  echo "PASS — release invariants hold."
else
  echo "FAIL — fix the ERROR lines above before committing."
fi
exit "$FAILED"
