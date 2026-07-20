# Changelog

All notable changes to the `jonstermash-skills` plugin are recorded here. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); this project uses
[semantic versioning](https://semver.org/).

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
