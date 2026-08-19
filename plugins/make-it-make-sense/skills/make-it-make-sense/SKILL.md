---
name: make-it-make-sense
description: >-
  Zoom out and simplify any written or presented output so it's understandable on the first pass.
  AI output is almost always too detailed, too dense, and pitched too deep, so simplifying is the
  DEFAULT, not a special case — but the result must stay true, non-redundant, and correctly framed;
  never trade accuracy for brevity. Runs as a procedure: frame the reader, then passes over
  substance, structure, and line, each closed by a gate, then a cold read. Use it whenever
  PRODUCING a deliverable, not only revising one — written from scratch counts. Applies to a slide
  deck, report, memo, email, doc, diagram, or summary, and fires on cues
  like "simplify," "zoom out," "make it high-level," "too wordy / dense / technical / long," "tighten
  this," "too much jargon," "wall of text," "make it clearer," "fix the titles," or "is that true?"
  When in doubt whether output is too in-depth,
  assume it is and run the pass. A separate opt-in --codify flag drafts Instructions-for-Claude
  additions from a session's voice edits.
---

# Make It Make Sense

## Premise

The goal is clarity — understandable on the first pass. AI outputs are almost always too in-depth to get there — too much detail, too dense, pitched too deep — so zooming out is the **default move**, not something reserved for a particular audience. Assume whatever was just produced needs simplifying, and do it.

But cutting is the usual move, not the only one. Sometimes clarity means restructuring, reframing, or *adding* a missing signpost or first step. And whatever the move, the result must stay **true, non-redundant, and correctly framed** — simpler-but-wrong is worse than slightly-longer-but-right.

## How this skill runs

An editor doesn't hold fifteen loose rules in mind. They run a **procedure**: know the reader, then work the piece in passes, and each pass ends in a check they actually perform. This skill is that procedure.

1. **Frame the reader** — infer who it's for, state it, edit against it.
2. **Pass 1 · Substance** — is it true, backed, and at the right depth?
3. **Pass 2 · Structure** — does the shape carry the argument?
4. **Pass 3 · Line** — does it read smoothly out loud?
5. **Cold read** — would a stranger get it? Ship, or loop back.

Each pass does its moves **then clears a gate** before you move on. The gate is the point — a rule you read but don't run is a rule that fails, and a check that lives only at the very end is the one that quietly gets skipped. So the gate closes the pass; you don't leave a pass until it's clear.

The moves below are stated in one line each. The tell-lists, examples, and edge cases live in `references/` — load the named file when the pass needs it. But the **gate fires from this file alone**: you never need a reference open to know the check.

## When it makes sense

Simplifying is the default, but it earns its keep most in anything meant to be **understood quickly** — decks, summaries, updates, proposals, anything with an audience and a narrow window of attention. The further a piece sits from "reference material someone studies" and the closer to "something someone skims once," the more this pass matters.

Ease off in the few cases where depth is the deliverable: reference docs and specs where completeness is the point, legal or technical material where precision can't be traded for brevity, or when the reader has asked for the full picture. Even then, simplify the *framing* — lead with the answer, signpost the structure — and let the depth live underneath.

---

## Frame the reader

Everything downstream — how deep, what to cut, what a heading can assume — is a judgment about *someone*. So name them first. This is the one step you do before touching a word.

- **Infer from the draft's own signals.** The medium, the vocabulary already in use, what the draft explains vs. assumes, what it asks the reader to do — a competent editor reads all of it. You don't need to be told the audience; you can usually see it.
- **State it in one visible line.** "Editing this as: an exec who knows the project, deciding on budget." Stating it is how a wrong guess gets caught — and how the rest of the pass has something to aim at.
- **Ask only on a genuine fork.** Ask the person *only* when two readers are both plausible **and** the two readings would produce different edits — an exec skim vs. an engineer's reference. Most drafts don't fork; state the assumption and proceed. (When no one's there to answer, the stated assumption *is* the answer.)
- **Name the subject too.** Separate from who it's *for*: who it's *about*. Every piece has a subject — usually the reader, the writer, or a named actor. Pick one and hold it throughout; don't quietly swap in a hypothetical third party ("a VP skimming your deck"), which reads fine sentence by sentence and leaves the reader asking who "you" even is.

**Gate:** the reader is stated in one line. If you can't state it, that's the first finding — resolve it before editing.

---

## Pass 1 · Substance

Is it true, backed, and pitched at the right depth for this reader?

- **Ask what's missing, not only what's extra.** Before cutting, check whether the confusion is *absence* — a missing signpost, an unstated first step, an order that fights the reader's mental model. A piece can be too short to follow. Restructure or add, not just cut.
- **Cut to what matters.** Keep the few points that carry the message; drop or demote the rest.
- **Say it plainly.** Replace jargon, acronyms, and internal terms with what they mean. If a term must stay, define it once — by its essence, not its examples (`references/framing-tells.md`).
- **Move the detail out.** Mechanics and exhaustive detail go to an appendix, speaker notes, or a linked doc — **relocated, not deleted**.
- **Don't overshoot into bare — or into cute.** Every kept point needs a concrete anchor (number, name, example) or it says nothing — but the anchor comes from the source or the person; an invented one reads *more* credible than the vague version and it's false (no real anchor → ask, or stay general). And don't reach for personality where a plain statement is clearer: a forced quip or teaser in place of a direct line costs clarity and ages badly. Aim for a sparse surface with real substance underneath.
- **Impact over activity.** Lead with what the reader *gets*, not what you *did* — and never frame your own effort, or a cost to them, as their win. (`references/framing-tells.md`)
- **Cut defensive framing.** Copy that pre-justifies or braces for criticism points the eye at the weak spot. State what happened, then the path forward. (`references/framing-tells.md`)
- **Grade on the gap, not around it.** A pass verdict — or a low-severity rating — trailed by a disqualifying caveat is a false headline: "our spec was right, with one real gap" is "this car runs, but it has no wheels." Rate on what the reader can't do, not on how gracefully it fails or how it ranks against something worse. If the gap changes their action, it *is* the verdict: lead with it, and don't shrink it with "one," "minor," or "just." (`references/framing-tells.md`)
- **Make quantitative claims land.** Every headline number tied to money or a decision; causation kept distinct from correlation; comparisons not overclaimed. And **"not a fluke" is a defensive assertion — strip it**: re-earn it only by *showing* the denominator (the volume behind the result); if you can't show the volume, flag the figure and drop the claim. Never assert it, never infer the number. (`references/quant-claims.md`)
- **Frame decisions consultatively.** When the piece asks the reader to decide: first confirm each item is actually *their* call to make — don't route the author's own decision (internal staffing, headcount) to the reader — then structure it situation → options → recommendation → the specific ask. Don't fabricate a recommendation the author never gave. (`references/framing-tells.md`)
- **Don't distort while simplifying, and source claims from the artifact itself.** Watch the distortion tells (over-generalized quantifiers, collapsed actions, flipped advice); write about a thing from the thing, read in full. (`references/framing-tells.md`)

**Verify every specific — including the ones already in the draft.** A number's presence in an AI-written draft is not evidence it's true; its figures and names are the *likeliest* fabrications, and they read as the author's own. Confirm each against the source or ask the person; if you can't, flag it rather than ship it clean.

**Gate:** the takeaway is statable in one line — the spine, even where the piece both reports a result and asks for a decision; every figure reconciles to a source or is flagged; no anchor is invented. And a reader who acted on that one line alone, having read none of the caveats, would do the right thing — if any caveat would change their action, the takeaway is wrong, not just incomplete.

---

## Pass 2 · Structure

Does the shape carry the argument — before anyone reads a word?

- **Lead with the answer.** The main takeaway first, before buildup. The point lands in seconds.
- **Match the medium.** Slides: a headline plus a few short phrases, one idea each. Docs: short prose, bottom-line first. Email: the ask in the first line. (`references/layout.md`)
- **Make the headings do the work.** A heading is a plain label *or* a real claim — never a limp in-between, and never spin forced onto reference content or an editorialized read of a result. (`references/titles.md`)
- **Shape it for scanning.** Break buried lists onto their own lines; build a real hierarchy; spend emphasis on the few words that carry weight; let whitespace and reading direction do their job. (`references/layout.md`)
- **Diagrams read from the subject.** A diagram is content before it's a visual: subject as the focus and origin, every arrow a true relationship. (`references/layout.md`)
- **Kill redundancy and contradiction.** Sweep every section against every other, both questions: did the reader already get this (merge/cut — emphasis comes from placement, not repetition), and do these two claims disagree (a contradiction reads clean locally and only surfaces when the pair is held together)? An executive summary earns its place only at a **different altitude** than the detail it precedes — a one-line verdict plus what it sets up, not a re-telling. Usual offenders: a chart and a table showing the same numbers, an intro restating the executive summary, a "next steps" repeating the recommendation, two diagrams making the same point.

**Gate:** read the headings alone, in order. They're each distinct, they tell the story on their own, and they carry zero colons-as-crutch, zero filler, and no pronoun whose antecedent lives outside the outline.

---

## Pass 3 · Line

Does it read smoothly, out loud, with nothing dangling?

- **Check every referent.** Cutting orphans references: after any cut or reorder, re-read every pronoun, "this/that/these," and definite article ("the playbook") and confirm the thing it names still exists. Same for heading→first-sentence seams and for narrative person — pick "I," "you," or the imperative and hold it. (`references/line-edit.md`)
- **Mind the rhythm.** Break run-on sentences where they sprawl; don't overcorrect into stuttering fragments. But AI-stutter and a writer's deliberate punch look identical to a pattern-matcher — before smoothing a fragment, check it isn't the author's voice, and flag rather than silently fix. (`references/line-edit.md`)
- **Cut the filler, keep the piece honest.** No unrequested pleasantries or decorative asides; keep scaffolding (cross-references, counts, "three questions" promises) in sync with the actual content; re-verify self-referential facts (round/word counts, "the version you're reading") that the editing itself invalidates; and for how-to content, make sure the reader can actually *start*. (`references/line-edit.md`)
- **Keep process and meta out of the deliverable.** Change-logs, edit rationale, "(was slide 19)," "27 slides → 25" — those go in the message to the requester, not inside the artifact. The finished piece reads as if it were always the plan.

**Gate:** read it aloud (or sub-vocalize). Zero stumbles, zero half-thoughts, zero sentences you have to re-run to parse.

---

## Cold read

Read it back cold and fast, as if you'd never seen it. If the main point isn't obvious within a few seconds, or any line needs insider knowledge to follow, the piece isn't done — route the failure back to the pass that owns it (a wrong number → Substance, a heading that doesn't land → Structure, a sentence you stumbled on → Line) and run that pass again.

The strongest version: hand it to a **fresh agent or person with zero context**. Whatever they can't follow is exactly what to fix. For high-stakes pieces, do this literally rather than imagining it.

## The instinct to resist

The pull is to show all the work — to prove the depth is there. But understanding-fast is what gets rewarded, not thoroughness. The depth still exists; it just belongs in an appendix or notes, not in the reader's face.

## `--codify` — turn a session's edits into voice preferences

Opt-in, power-user flag, separate from the editing pass. When the user runs `/make-it-make-sense --codify`, read the *voice* edits from this session and draft additions to their account-wide **Instructions for Claude** — the pass de-slops everyone's output; `--codify` captures one person's voice. Full procedure, format, and the `(tentative)` rule: `references/codify.md`.
