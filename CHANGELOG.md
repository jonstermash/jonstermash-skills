# Changelog

All notable changes to the `jonstermash-skills` plugin are recorded here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); this project uses
[semantic versioning](https://semver.org/).

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

## [0.3.0] and earlier

See git history. Versions through 0.3.0 predate this changelog:
- **0.3.0 / 0.2.0** — expanded `make-it-make-sense` with accuracy, heading, and redundancy rules.
- **0.1.0** — initial `make-it-make-sense` skill; restructured the repo as an installable plugin
  marketplace.
