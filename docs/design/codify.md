# Design note — `make-it-make-sense --codify`

Why the `--codify` flag works the way it does. This is a design record, not runtime instruction —
the skill body (`SKILL.md`) states only what to *do*; the reasoning lives here so it doesn't burn
context on every run.

## The problem it solves

Style preferences set cold are near-useless. Nobody can judge their own voice in the abstract — only
against real output. The signal that reveals voice is the edits a person makes to finished work, and
those exist only after a session has run. `--codify` harvests that signal instead of asking the user
to describe a voice they can't yet see.

## Decisions

### Manual and user-invoked — invoking it is the consent
The user runs `--codify` only when they judge a session voice-defining. That judgment *is* the
consent, so the flag can propose freely without second-guessing whether the session qualified.

### Count voice-edits, not error-fixes — but don't over-trust the counter
Most edits fix fabrications, orphaned headings, or slop; those reveal nothing about voice. Only edits
that change *correct* copy for tone or register are signal. Telling the two apart is unreliable, so
the flag never relies on getting it right: it shows its work and the user prunes. The classifier only
has to be a decent first pass. (This is also why the manual flag shipped before the automatic nudge —
see below.)

### Propose, don't absorb
The skill never mutates its own behavior from these inferences. It drafts text; the user pastes it
into Settings → "Instructions for Claude." The paste is both the write and the approval.

### Output is Markdown with fixed section headers
The draft has two audiences: the human approving it now, and — if direct-write ever ships — a parser
applying it later. Markdown with labeled sections (`Voice`, `Length`, `CTAs`, …) serves both: headers
give a machine structure to map, bullets stay plain enough to scan and paste by hand. JSON/YAML read
as machine-only and raise the bar to approve.

## Capability finding — no write tool today

Direct-write is not available today, but not for the obvious reason. Skills write account settings
routinely *when a connector exposes the tool* (updating a QuickBooks profile, editing a Notion page).
The wall isn't "a chat skill can't reach settings" — it's that there is **no tool for the
Instructions-for-Claude field specifically.** That's a conditional gap: if a preferences connector
ever ships that field as a tool, direct-write becomes possible and the "draft, user pastes" step
should be revisited. Until then, drafting well is the whole job.

## The `(tentative)` flag and its stateless limitation

A line is `(tentative)` when it rests on one session's signal, or on edits that were only partly about
voice. Promotion (dropping the flag) is meant to happen when the same rule surfaces again from
unrelated content across a different session — same instinct twice is voice; once is a candidate.

**Limitation:** a skill has no memory across sessions. The model running `--codify` cannot know what
a prior run proposed, so it cannot auto-promote — doing so would mean fabricating a cross-session
history it can't see. Two consequences, both reflected in `SKILL.md`:
- The model promotes only on evidence in front of it — e.g. the user's current instructions, shown in
  the session, already containing the rule. Otherwise it leaves the line tentative.
- Promotion is ultimately the user's to confirm; they hold the running instructions doc and clear the
  flag when they've seen a line proposed twice.

## Scope boundary — personal field vs. skill

Two destinations; `--codify` writes only to the first.

- **Instructions for Claude (personal voice):** peer address, warm register, sign-off habits, soft
  CTAs, deliberate fragments. One user's voice — wrong to enforce on anyone else.
- **The skill (universal rules):** lead with the answer, never fabricate specifics, plain over clever.
  These improve anyone's output and belong in the pass itself.

The platform doesn't enforce this: "Instructions for Claude" is a single account-wide field that
accepts anything and fires on every chat. So the separation is a discipline `--codify` enforces, not
a wall the platform provides. When a proposed line is arguably a universal rule, the flag surfaces it
as a question rather than writing it — putting "lead with the answer" in the account-wide field would
fire it on every chat whether the skill runs or not, and that's the user's call.

## Deferred — and how the nudge was actually scoped

The original spec deferred the **automatic nudge** (a proactive mention of the flag after a
heavily-edited session), reasoning that it needs reliable edit-counting the manual flag doesn't.

In a skill that framing partly dissolves: the "classifier" is just the model's judgment, which the
skill already leans on everywhere — there's no separate counter to build and gate on. So a scoped
nudge shipped in 0.4.0: *offer `--codify` at most once per session, only when the session involved
real voice edits.*

What genuinely can't be built is the spec's "mention once, **ever**." A stateless skill has no
cross-session memory, so the model can't know it already nudged the user last week. The honest,
implementable scope is therefore **once per session**, not once per lifetime.
