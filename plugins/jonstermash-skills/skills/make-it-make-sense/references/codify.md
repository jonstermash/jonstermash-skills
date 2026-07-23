# `--codify` — turn a session's edits into voice preferences

Opt-in, power-user flag, separate from the editing pass. When the user runs `/make-it-make-sense --codify`, read the *voice* edits from this session and draft additions to their account-wide **Instructions for Claude**. The pass de-slops everyone's output; `--codify` captures one person's voice.

Preferences set cold are near-useless — nobody judges their own voice in the abstract, only against real output. That signal lives in the edits someone makes to finished work, which exist only once a session has run.

**Invoking it is consent.** The user runs `--codify` only when they judge the session voice-defining, so propose freely. You may also **offer it once, proactively**, when a session involved real voice edits — but at most once, and never after light or purely corrective work, where an unprompted pitch is just noise.

## Run it in two steps — never skip the first

1. **Show the edits, then let the user prune.** List the edits you read as voice-defining and wait for the user to cut any that aren't. Count **voice edits, not error-fixes**: fixing a fabrication, an orphaned heading, or slop reveals nothing about voice. Only edits that change *correct* copy for tone or register count — a clipped line warmed up, a hedge cut, a hard CTA softened. Your read is a first pass; the prune is the correction. If nothing in the session qualifies, say so and stop — never manufacture preferences to fill the block.
2. **Draft the block — after the prune, output it and nothing else.** No preamble, no wrap-up: the user copies from the first header to the last bullet and pastes it into Settings → "Instructions for Claude." That paste is both the write and the approval. No tool writes the field for you, so drafting well is the whole job.

## The draft's format

- **Fixed section headers** — `Voice`, `Length`, `CTAs`, plus any the session surfaces. Same names every time, so the user always finds the same thing in the same place.
- **One preference per bullet, imperative, self-contained** — each must make sense lifted out of context. No "also," no "as above."
- **Lead with the rule, not the reason** — "Cut hedging," not "Because AI over-hedges, cut hedging."
- **Markdown, not JSON or YAML** — plain bullets stay easy to scan and paste by hand.
- **Mark thin-signal lines `(tentative)`** — see below.

## The `(tentative)` flag

Mark a line `(tentative)` when it rests on one session's signal, or on edits that were only partly about voice — the draft admitting it might be guessing. Default to tentative when unsure.

Drop the flag only on evidence you can see in front of you: if the user shows their current instructions and the same rule is already there from an earlier session, this run confirms it — promote it. Otherwise leave it tentative. You have no memory of past runs, so never promote on a hunch that you proposed it before. A kept-but-never-repeated tentative line stays flagged — that's honest, not a bug.

## Voice only — ask before writing a universal rule

`--codify` writes **voice** lines only: peer address, warm register, sign-off habits, soft CTAs, deliberate fragments. That's one person's voice — wrong to enforce on anyone else.

Universal rules — lead with the answer, never fabricate specifics, plain over clever — belong in *this skill*, not the personal field. When a proposed line is arguably one of those, surface it as a question instead of writing it. "Instructions for Claude" is one account-wide field that fires on every chat, so a universal rule placed there runs whether the skill runs or not — the user's call, not the flag's.

## Example draft

```markdown
# Style

**Voice**
- Lead with the answer — no preamble or throat-clearing.
- Cut hedging, recaps, and clever-for-its-own-sake phrasing.
- (tentative) Write like a peer who knows the basics; don't lecture or prove the obvious.
- (tentative) Warm and human, not clipped ad-copy — contractions, asides, the occasional emoticon.

**Length**
- Default to a few sentences; expand only when I ask.

**CTAs**
- (tentative) Soft invitations over hard sells.
```

The confident lines came from edits made this session. The `(tentative)` lines came from a *different* session editing different content — plausibly voice, but unconfirmed, and flagged so the user isn't handed another session's register as their own.
