# Changelog

All notable changes to this project are recorded here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); this project uses
[semantic versioning](https://semver.org/).

## [1.4.0]

### Added
- **Build stamp, so a loaded build can identify itself.** `scripts/stamp-build.sh` writes
  `plugins/make-it-make-sense/BUILD` with a version, a content hash, a source commit, and a UTC
  build time. Version strings are hand-typed, so a build where a skill changed but the version
  didn't is byte-different and version-identical — indistinguishable from inside a session. The
  content hash covers every file in the plugin directory **except** `BUILD` itself, which is what
  makes it well-defined rather than circular, and `--check` recomputes it from any checkout.
  `source_commit` is honestly labelled as the *parent* of the commit carrying the stamp: writing
  the stamp changes the tree, so a commit cannot record its own SHA. Use the content hash to prove
  identity; the SHA is advisory.
- **Three ways to read the build from a running session.** Tier 1: the hook prints one build line
  on every prompt, which lands in context with zero tool calls. Tier 2: `cat BUILD` at the synced
  plugin root. Tier 3 is **not implemented** — see below.

### Changed
- **The hook returns to production posture.** The v1.3.0 verification build was deliberately
  unconditional, wrote logs to three paths, and emitted a large block. Its question is answered.
  The arming gate is back, the logging is gone, and it now emits one build line always plus the
  compressed gate only while armed.
- **Container detection fixed.** The old heuristic tested for Docker (`/.dockerenv`, cgroup
  markers) and so reported `container=no` in Cowork, which runs a **Firecracker microVM** — both
  checks miss by design. It now tests for virtualization, keying on the `-fc-` tag in the kernel
  release that the Cowork session actually reported. Behind `SYCO_DEBUG=1`, since it costs context
  on every prompt and its question is now settled.

### Fixed
- **The description cap enforced since v0.4.0 was wrong.** This project trimmed skill descriptions
  to stay under **1,024** characters. The documented cap is **1,536** — "the combined `description`
  and `when_to_use` text is truncated at 1,536 characters in the skill listing to reduce context
  usage" — and it's configurable via `skillListingMaxDescChars`, so 1,536 is a default rather than
  a floor. Overflow is silent truncation in the listing, not an error, so the risk was real; the
  number was not. Both descriptions sit near 1,015 and were never close to the true limit.
  Nothing in the repo enforced 1,024 mechanically — it lived in the v0.4.0 changelog entry and in
  habit. The entry now carries a correction and the number is retired. **Descriptions are
  deliberately not re-expanded in this release**; this change stops enforcing a false constraint,
  it doesn't spend the headroom.
- **The v1.2.0 changelog entry was wrong, and it misled real decisions.** See the note added there.

### Decided (recorded so they don't get reopened)
- **`when_to_use`: not adopted.** It would be the natural home for trigger cues and would free
  description space, but there are two frontmatter schemas — Claude Code local and plugin skills
  accept all documented fields, while the claude.ai upload / Skills API / packaging path accepts
  exactly six (`name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`) and
  **hard-errors on unknown fields**. `when_to_use` is not among the six, and which validator runs on
  the GitHub-marketplace → Cowork → synced path is undocumented. Not worth an unknown-schema risk
  for a convenience.
- **`version:` in frontmatter: closed permanently.** Same reason, but worse — it would hard-error on
  the spec path. Not "untested." Not to be revisited.
- **Tier 3 (skill-level build stamp): abandoned.** The only documented carrier is `metadata`, which
  Claude Code explicitly "doesn't act on," so it never reaches model context and reading it requires
  a file read — which is Tier 2. Tier 3 collapsed into Tier 2 and added nothing.

### How to check which build is loaded
- Run `scripts/stamp-build.sh` here and note the `content_hash` it prints. Start a new Cowork
  session and read the hook's stamp line, which carries the same hash. If they match, the build you
  published is the build that is running. Compare by eye; no harness needed.
- **The hash is the only field that proves it.** The semver is hand-typed, and the sync layer's own
  counter and timestamps move whenever a sync runs, whether or not the content changed. Only the
  content hash is derived from the bytes.

### Changed — stamp checking
- **Drift and unexpected files are now different findings.** The stamp records the exact **file set**
  it hashed, so `--check` hashes that set rather than "whatever is in the directory." A recorded file
  that is missing or whose bytes changed is **DRIFT** and exits non-zero; a file that appears later is
  **UNEXPECTED** and is reported without failing. This matters because a plugin can write into its own
  root at runtime — pre-1.4.0 hooks wrote `hook-fired.log` there — and the naive approach would have
  read that as content drift forever. Known runtime-written paths are excluded outright and named.
  Measured, not assumed: the sync layer adds nothing, strips nothing, and preserves the executable
  bit, so drift points at the payload rather than the transport.

## [1.3.0]

### Added
- **The `UserPromptSubmit` hook, restored as a verification build.** v1.2.0 removed it on the
  belief that hooks don't run outside the Claude Code CLI. This build was deliberately
  unconditional — no arming gate, since an unarmed hook and a dead hook are indistinguishable from
  outside — and emitted a sentinel plus a host/kernel/container fingerprint to settle the question
  empirically.

### Result
- **Hooks fire in Cowork. Confirmed.** A plugin-declared `UserPromptSubmit` hook executes in
  Cowork's cloud container *and* its stdout reaches the model's context. Observed: `host=vm`,
  `user=root`, `kernel=Linux 6.18.5-fc-v20`,
  `plugin_root=/root/.claude/plugins/synced/make-it-make-sense`. This settles
  [anthropics/claude-code#47993](https://github.com/anthropics/claude-code/issues/47993) and
  [#45514](https://github.com/anthropics/claude-code/issues/45514) for this surface.
- The fingerprint also showed `container=no`, which was the heuristic being wrong rather than the
  environment being bare metal — corrected in 1.4.0.

## [1.2.0]

### Removed
- **The `UserPromptSubmit` hook.** It was the centerpiece of v1.0.0 and it never functioned in the
  surface this plugin is actually used in — hooks are Claude Code CLI only, and the Claude apps
  don't run them.

  > **Correction (1.4.0).** The claim above is false and this entry is left in place only so the
  > record is honest about it. Hooks **do** run in Cowork, and hook stdout **does** reach the
  > model's context — confirmed empirically in 1.3.0. The removal rested on a single documentation
  > snippet and two open issues reporting non-firing, none of which had been tested on this
  > surface. The hook was restored in 1.3.0. Anyone reading 1.2.0 to decide whether hooks are
  > viable should read 1.3.0 instead. Keeping it meant every doc carried a surface caveat and the headline feature was
  untestable for most users. `plugins/make-it-make-sense/hooks/` is gone.

### Changed
- **The standing rule is now *the* mechanism, not a fallback.** `references/standing-rule.md` is a
  paste-once block for **Settings → Instructions for Claude**, which loads every turn. Same
  unconditional delivery the hook was meant to provide, in the place it actually works.
- **`/syco-killer --standing`** prints the block; the arm/disarm modes are gone with the hook.
- **README leads with the Plugins UI.** CLI install moved to a collapsed section.

## [1.1.0]

### Added
- **`syco-killer`: the standing rule for surfaces that can't run hooks.** The v1.0.0 design leaned
  entirely on a `UserPromptSubmit` hook to make the gate always-on — but hooks are a Claude Code CLI
  mechanism, and the Claude apps don't run them, so the centerpiece was inert for anyone working in
  the chat or desktop UI. `references/standing-rule.md` now carries a paste-ready block for
  **Settings → Instructions for Claude**, which loads every turn in those surfaces, plus a
  surface-support table and a behavioral test procedure that doesn't rely on asking the model
  whether it's loaded (asking is itself the sycophancy vector).
- **`/syco-killer --standing`** prints that block.

### Changed
- **`syco-killer` must not report the gate as armed where the hook can't run.** Claiming a
  successful arm in a surface that ignores hooks is exactly the unverified-success failure the
  skill's own agentic section prohibits — committed by the skill itself.
- **README** documents which mechanism applies per surface.

## [1.0.0]

First stable release. Two skills instead of one, and the first bundled hook. Versions 0.6.0
through 0.8.0 were developed but never released; their changes are consolidated here.

### Changed
- **Renamed from `jonstermash-skills`.** The repo and marketplace are now `mims-public`; the
  plugin inside is **Make It Make Sense** (`make-it-make-sense`). Splitting the two names is the
  point — the repo is a container that can hold more over time, while the plugin keeps the name
  the project is actually known by.

  | | |
  |---|---|
  | Repo / marketplace | `mims-public` |
  | Plugin | `make-it-make-sense` — displayed as **Make It Make Sense** |
  | Skills | `/make-it-make-sense`, `/syco-killer` |

  **The skills are unchanged** — both keep their names and their behavior.

  Breaking for installs. GitHub redirects the old repo URLs, but the marketplace and plugin IDs
  changed, so existing installs must remove the old marketplace and re-add it:
  `/plugin marketplace add jonstermash/mims-public` then `/plugin install make-it-make-sense@mims-public`.
- **Added `displayName`** so the `/plugin` picker shows "Make It Make Sense" rather than the
  kebab-case identifier.
- **Plugin description and keywords** now name both bundled skills.

### Added
- **New skill: `syco-killer`.** Sycophancy treated as an accuracy failure, not a tone problem — it
  trades information for comfort, and it's self-erasing, since praise that's automatic carries no
  signal and takes the honest verdicts down with it. Runs **last**, as a gate on the drafted
  response rather than as framing on the way in; you can't filter a response you haven't written.
  Four gates, one per moment sycophancy enters: **the Open** (validation openers — delete the first
  sentence and see if anything is lost), **the Judgment** (the view in the first two sentences,
  unhedged; rank, don't array), **the Challenge** (sort pushback into new information → update,
  restated preference on their call → comply without pretending you were convinced, and assertion
  without evidence → hold and name the falsifier), and **the Close** (a question earns its place
  only if the two answers produce different work). Two tests decide any given line: the **razor**
  (delete it — if the reader loses nothing, it was padding) and the **mirror** (an assessment is
  information only if the opposite verdict was available). Plus a full agentic section — the claim
  ladder, done-means-done, weakened assertions, and the can't-verify protocol.
  Explicitly bounded against overcorrection: manufactured disagreement, do-nothing caveats, and
  hedging a solid answer are the same failure inverted; agreeing with something correct is accuracy;
  and the posture is never announced, since "to be blunt" is flattery pointed at yourself. Eases off
  — without switching off — where someone is distressed or courtesy is doing real social work.
  Tell-lists and worked rewrites in `references/tells.md` and `references/outcome-honesty.md`.
  Gate 2 and Gate 3 are grounded in the measurement literature rather than intuition: feedback
  bending to stated authorship and stated sentiment (the best-measured effect), mimicry of user
  mistakes, citation-flavored pushback as the highest-risk reversal trigger rather than the most
  convincing one, and the ~78% persistence of a reversal once you've folded. The same literature
  corrected an over-rotation in the draft — pressure-induced reversals run about 3:1 toward the
  *right* answer, so "restore the original if you can't name a new fact" was rewritten to accept an
  error you found on re-check as a legitimate mover.
- **First bundled hook: opt-in `UserPromptSubmit` injection.** A skill only loads when its
  description matches the moment, which is the wrong mechanism here — a sycophantic response doesn't
  feel sycophantic from the inside, so the skill would fire precisely when it isn't needed. The
  plugin now ships `hooks/hooks.json` and `hooks/syco-killer.sh`, injecting a ~35-line compressed
  rule ahead of every prompt in every session. Gated on `~/.claude/syco-killer.on` and silent until
  armed with `/syco-killer`, since installing a writing plugin shouldn't silently change how the
  assistant talks. `/syco-killer off` disarms; `/syco-killer --audit` reviews recent turns.

## [0.5.1]

### Added
- **`make-it-make-sense`: new line tell — the rhythmic `X, not Y` antithesis.** `line-edit.md` now
  flags antithesis reached for cadence rather than information ("that's a default, not a glitch"),
  and separates it from the *defensive* `X, not Y` already handled in `framing-tells.md` and from a
  genuine informative contrast that earns its place. Includes the strike-the-negation test and the
  same authorial-voice caution the fragment tic carries.

## [0.5.0]

### Changed
- **`make-it-make-sense`: restructured as an editor's procedure.** The skill now runs as *frame the
  reader → three passes (substance, structure, line), each closed by a gate → cold read*, replacing
  the flat list of rule sections. The reframing makes the checks actually fire: a gate you must clear
  to leave a pass runs, where an end-of-document checklist quietly gets skipped. Every prior principle
  is preserved — the exhaustive tell-lists, anti-patterns, and examples moved into per-pass reference
  files under `references/` (loaded on demand), while SKILL.md holds the runnable procedure and each
  gate fires from SKILL.md alone. Net: SKILL.md dropped from 217 to ~120 lines without losing a rule.

### Added
- **`make-it-make-sense`: frame-the-reader step.** A required first step — infer the reader from the
  draft's own signals, state the assumption in one line, and ask only on a genuine fork. Everything
  downstream (depth, cuts, what a heading can assume) is judged against it.
- **`make-it-make-sense`: new substance rules.** Cut defensive framing; impact over activity; make
  quantitative claims land (tie to money/decision, causation≠correlation, no overclaimed comparisons,
  "not a fluke" backed by the denominator or dropped); frame decisions consultatively (and check each
  decision is even the reader's to make).
- **`make-it-make-sense`: title and structure additions.** Reject throat-clearing/meta headings;
  don't force a claim (spin) onto reference content; don't editorialize a result in its headline;
  executive summaries earn their place only at a different altitude than the detail.
- **`make-it-make-sense`: layout rules.** Whitespace and reading direction as real structural tools.
- **`make-it-make-sense`: keep process/meta out of the deliverable.** Change-logs and edit rationale
  belong in the note to the requester, not the artifact.

## [0.4.0]

### Added
- **`make-it-make-sense`: `--codify` flag.** An opt-in, power-user path that reads a session's
  *voice* edits and drafts additions to the user's account-wide "Instructions for Claude." Separate
  from the editing pass — the pass de-slops everyone's output; `--codify` captures one person's
  voice. Includes a proactive one-per-session offer after voice-heavy sessions. Design rationale and
  known limitations: [`docs/design/codify.md`](docs/design/codify.md).

### Changed
- **`make-it-make-sense`: trimmed the frontmatter `description` under the 1,024-character limit.**
  It was 1,283 characters (over the platform cap and at risk of truncation, which would cut trigger
  keywords). Every trigger cue is preserved; only rationale prose was cut.

  > **Correction (1.4.0).** The 1,024 figure is wrong and was never sourced. The documented cap is
  > **1,536** for `description` + `when_to_use` combined, configurable via
  > `skillListingMaxDescChars`. The trim itself was still sound — 1,283 characters of rationale
  > prose was worth cutting — but the number was invented, and it went on to constrain later
  > releases for no reason. Don't carry it forward.

## [0.3.0] and earlier

See git history. Versions through 0.3.0 predate this changelog:
- **0.3.0 / 0.2.0** — expanded `make-it-make-sense` with accuracy, heading, and redundancy rules.
- **0.1.0** — initial `make-it-make-sense` skill; restructured the repo as an installable plugin
  marketplace.
