---
name: make-it-make-sense
description: >-
  Zoom out and simplify any written or presented output so it's understandable on the first pass.
  Premise: AI-generated content is almost always too detailed, too dense, and pitched too deep to
  grasp on a first read — so simplifying is the DEFAULT, not a special case, regardless of who the
  reader is. The result must stay true, non-redundant, and correctly framed — never trade accuracy
  for brevity. Use this whenever PRODUCING a deliverable, not only when revising one — writing a post,
  deck, memo, or doc from scratch counts, since the fix is cheaper before the draft sprawls than
  after. Applies to a slide deck, presentation, report, memo, one-pager, proposal, email, doc,
  diagram, or summary, and fires on cues like "simplify," "zoom out," "make it high-level," "too
  wordy / too dense / too technical / too long," "tighten this," "too much jargon," "wall of text,"
  "make it clearer," "fix the titles," or "is that true?" Often run directly as the
  /make-it-make-sense slash command. When in doubt about whether an output is too in-depth, assume it
  is, and run this pass.
---

# Make It Make Sense

## Premise

The goal is clarity — understandable on the first pass. AI outputs are almost always too in-depth to get there — too much detail, too dense, pitched too deep — so zooming out is the **default move**, not something reserved for a particular audience. Assume whatever was just produced needs simplifying, and do it.

But cutting is the usual move, not the only one. Sometimes clarity means restructuring, reframing, or *adding* a missing signpost or first step. And whatever the move, the result must stay **true, non-redundant, and correctly framed** — simpler-but-wrong is worse than slightly-longer-but-right.

## When it makes sense

Simplifying is the default, but it earns its keep most in anything meant to be **understood quickly** — decks, summaries, updates, proposals, anything with an audience and a narrow window of attention. The further a piece sits from "reference material someone studies" and the closer to "something someone skims once," the more this pass matters.

Ease off in the few cases where depth is the deliverable: reference docs and specs where completeness is the point, legal or technical material where precision can't be traded for brevity, or when the reader has asked for the full picture. Even then, simplify the *framing* — lead with the answer, signpost the structure — and let the depth live underneath.

## The pass

Two parts: **shape** the piece, then **verify** it. Both are the procedure. The verify steps are the ones that quietly get skipped when they live only in the prose sections below — so they're numbered steps here, not background reading. A rule you read but don't run is a rule that fails.

### Shape it

1. **Name the subject.** Every piece is about someone — usually the reader, the writer, or a named actor. Decide who, and keep them the subject throughout. The failure mode is quietly swapping in a hypothetical third party ("a VP skimming your deck"): it reads plausibly sentence by sentence and leaves the reader asking who "you" even is.
2. **Lead with the answer.** Put the single main takeaway first, before any supporting detail. The reader should get the point in seconds, not after wading through buildup.
3. **Ask what's missing, not only what's extra.** Before you cut, check whether the confusion is *absence* rather than excess — a missing signpost, an unstated first step, an order that fights the reader's mental model. If so, restructure, reframe, or add the missing piece. Cutting is the usual move, not the only one, and a piece can be too short to follow.
4. **Cut to what matters.** Keep the few points that carry the message. Everything else gets dropped or moved down a layer.
5. **Plain words.** Replace jargon, acronyms, and internal/technical terms with what they actually mean. If a term has to stay, define it once, simply.
6. **Move the detail out.** Zoom out to the level someone grasps quickly. Mechanics and exhaustive detail move into an appendix, speaker notes, or a linked doc — **relocated, not deleted**.
7. **Match the medium.** Slides: a headline plus a few short phrases, one idea per slide, detail in the speaker notes. Docs: short prose, bottom-line first. Email: the ask in the first line. Diagrams: see "Diagrams read from the subject" below.
8. **Don't overshoot into bare — or into cute.** Simple ≠ empty: every point you keep needs a concrete anchor — a number, a name, an example — so it still says something. **But the anchor comes from the source or the person, never from you.** If you don't have a real number, name, or example, ask for one or stay general — an invented anchor reads *more* credible than the vague version and it's false. And don't reach for personality where a plain statement is clearer; a forced quip or teaser in place of a direct line costs clarity and ages badly. Aim for a sparse surface with real substance underneath.

### Then verify

Run each of these — don't just read it. These are the checks that kept failing when they lived only as prose sections further down.

9. **Check every referent.** After any cut or reorder, re-read every pronoun, every "this / that / these," and every definite article ("the workflow," "the playbook") and confirm the thing it points to still exists. Check heading→first-sentence seams and narrative person the same way. → *"Check every referent after you cut."*
10. **Redundancy and contradiction.** Compare every section against every other, asking both: did the reader already get this, and do these two claims disagree? → *"Redundancy and contradiction across the whole piece."*
11. **Heading test.** Read the headings alone, in order: each distinct, together they tell the story, zero colons-as-crutch, zero filler — and no pronoun whose antecedent lives outside the outline. → *"Titles and headings."*
12. **Rhythm.** Break run-on sentences — but don't smooth a fragment that's the writer's deliberate punch. → *"Let the sentences breathe."*
13. **Verify every specific.** Confirm each figure, name, and date against the source — including the ones already in the draft. When the draft is AI-written, its specifics are the likeliest fabrications. → *"Simplify without distorting."*

## Simplify without distorting

When you simplify, the shorter version must stay true — to the facts *and* to the advice. This is the constraint on every other move in this skill.

Distortions to watch for:

- **Over-generalizing quantifiers** — "this covers *every* segment" when it covers three; an "*always*/*all*/*never*" the source doesn't support. Name the real scope.
- **Collapsing distinct actions** — calling a tool a "fix" when it only *diagnoses*; saying a step "sends" the email when it drafts one; "saves to the shared drive" when it writes to a temp file. Verb precision matters.
- **Wrong specifics** — figures, names, dates, syntax, menu paths, UI labels. Confirm against the actual source, not your memory of it. **And a specific's presence in the draft is not evidence it's true** — when the draft is itself AI-written, its numbers and names are the likeliest fabrications in the piece, and they read as the author's own. Confirm every figure, name, and date against the original source or ask the person. "I won't invent a number for you" is not a reason to *protect* a number that was already invented.
- **Flipped advice** — compressing "write a detailed brief" down to "keep it short," or "review carefully" into "trust the output." You often know more than the reader; don't let a neat phrasing encode the wrong lesson.

If you can't verify a simplified claim, flag it rather than shipping it clean and confident.

## Check every referent after you cut

Cutting is what breaks referents: delete the sentence that introduced "the playbook," and every later "the playbook" points at nothing. The prose stays grammatical, so it survives a re-read. After any cut, re-read every pronoun, every "this / that / these," and every definite article — "the workflow," "the review," "the skill" — and confirm the thing it names still exists in the piece. If it doesn't, name it again or cut the reference.

Cuts and reorders orphan more than nouns:

- **Transitions.** A section can survive a restructure with its heading intact but its opening line no longer connecting to what now precedes it. After any reorder, re-read each heading→first-sentence seam, not just the nouns — "how do we get from this heading to this paragraph?"
- **Person.** Pick the piece's person — "I," "you," or the imperative — and hold it. Don't let a passage open in one and close in another ("*Ask* for shorter and the count drops… now *I'm* reassembling the logic myself"). Splicing sentences from different drafts is exactly how the drift creeps in, so check person on the same pass you check referents: after every splice.

## Write about the artifact from the artifact

When the piece describes an existing artifact — a skill, a product, a doc, a feature — its substance comes from the artifact itself, read in full, not from your memory of conversations about it. Quote or closely paraphrase what it actually says; don't write *around* it with anecdotes and invented examples standing in for its real content. Sourcing from the artifact also fixes fabrication for free, because its own examples replace the ones you'd otherwise invent.

Represent its scale honestly, too. "It'll be running on everything" for what is really a list of editing moves is scope inflation — the heading-buzzword problem applied to a claim. Describe what the thing is, at the size it actually is.

## Titles and headings

**A heading is either a plain label or a real hook — never a limp in-between.** This applies to any medium and any level: a slide headline, a doc section head, a report title, an email subject line — and the smaller labels too, a **bolded lead-in** inside a section or a list-item label. If it heads content, it's a heading.

- **Reference / utility content** — content someone looks things up in rather than reads through (an FAQ, a glossary, a cheat sheet, a spec or comparison table, a methodology appendix, a table of contents): use the plain, descriptive label — "FAQ," "Glossary," "Pricing Tiers," "Methodology." Don't dress these up; a cute title on reference content reads as noise. (Rename a section from "Everything You've Ever Wondered" back to "FAQ.")
- **Argument / narrative content** — content that makes a point the reader follows start to finish (the pitch, the finding, the takeaway): use a genuine claim or question with tension. A report finding: "Churn is a pricing problem, not a product one." An email subject: "We're moving the launch to August." A slide: "Never start from a blank page." Each creates a pull the body then resolves. The heading names the idea or makes the claim; the specifics live in the body — "Why the launch slipped" over "Launch moved from June 14 to August 2 over vendor issues."

The arbiter between the two failure directions: **does the heading make a claim (or pose a question) the body then pays off?** A hook that isn't a claim is a teaser; a label on argument content is a summary.

**Anti-patterns to reject on sight:**

- **Vague buzzwords** — "revolutionize," "delve," "game-changer," "unlock," "supercharge," "seamless," "elevate." Empty calories; cut them.
- **Zero tension** — the heading summarizes the content instead of creating curiosity. A report head like "Overview of Our Findings," or a slide like "The Steps Build on Each Other."
- **Cheesy colon constructions** — "Q3 Results: What You Need to Know," "Our Approach: A Deep Dive." Cut the colon; say the thing.
- **Captain Obvious** — a fact with no tension ("Our Product Has Several Features," "The Report Is Attached"). This one isn't limited to headings: the same empty statement in body prose ("under the hood, it's a text file") is the same failure — cut it or make it earn its place.
- **Orphaned pronoun** — a heading leaning on "it / this / that / what" whose antecedent lives in the paragraph above rather than in the outline ("This is every time," "What it does," "Knowing how it fails is the skill" — knowing how *what* fails?). It reads fine in place because the body supplies the referent — which is exactly what a heading can't borrow. A heading names its own subject.
- **Forced cleverness** — reaching for a catchy count or teaser ("Five Rules Worth Keeping," "3 Things That'll Surprise You").
- **Filler words** — "using it *well*," "*A quick look at* X." If a word can go, it goes.
- **Over-long** — if it wraps to two lines, it's probably a subheading. Demote the long "clever" line and write a short heading above it.

**Test:** read only the headings (or subject lines, or the doc's outline) in order. They should (a) each be distinct, (b) tell the story on their own, (c) contain zero colons-as-crutch and zero filler, and (d) carry no pronoun whose antecedent lives outside the outline — reading the headings alone, any "it / this / that" still standing needs its noun spelled out.

## Redundancy and contradiction across the whole piece

After a draft, sweep the **whole** piece — every section, paragraph, or slide against every other. For any two, ask **both** questions:

- **Did the reader already get this?** If it's covered, merge or cut. Emphasis comes from placement, not repetition.
- **Do these two claims disagree?** A contradiction reads fine locally and only surfaces when the pair is held together — an intro calling the output "accurate and unusable at the same time" against a later section arguing it's frequently wrong. Each half is clean alone; only the pairing exposes it.

The usual redundancy offenders: a chart and a table showing the same numbers; an intro that restates the executive summary; a "next steps" that repeats the recommendation; two diagrams making the same point. Each survives until explicitly questioned — so question each pair, on both counts.

## Define by essence, not example

Lead a definition or framing with the core idea in plain terms; attach examples only as illustration ("…e.g. X, Y"). If the examples were removed, the sentence should still define the thing.

The failure mode is a term defined *as* its examples — "context" explained as "the business background, brand, and notes" instead of "the supporting information that helps the work." The examples eat the definition.

## Shape it for scanning

A simplified piece should be **navigable at a glance** — the reader's eye should find the structure before they read a word.

- **Break lists out.** When you're naming several things, give them their own lines as bullets instead of burying them in a sentence. Three bullets register instantly; the same three items inside a sentence have to be untangled first.
- **Build a hierarchy.** Use headings, subheads, and indentation so the shape of the content shows through the structure alone. Someone reading only the headings should still come away knowing roughly what's there.
- **Emphasize with intent.** Reach for **bold**, _italic_, or underline on the few words that carry the most weight — a key number, the decisive term, the actual ask. Keep it to a handful, since if half the page is bold then nothing stands out. Spotlight only what's on-message, never a detail that pulls the eye away from the point.

## Let the sentences breathe

Watch the rhythm of the prose, not just the layout. Run-on sentences that pile clause on clause are as hard to follow as a dense paragraph, so break them where they sprawl. But don't overcorrect into a string of clipped, stuttering fragments, because choppy staccato is its own kind of friction. Aim for sentences that move at an even, unforced pace — varied enough to read smoothly, contained enough to stay clear.

**But AI stutter and authorial punch look identical to a pattern-matcher.** Before you smooth a fragment or a cluster of short sentences, check whether it's the writer's own move — present in their published work, or explicitly approved. A one-word fragment used as a deliberate beat ("***Wrong.***") is voice, not a tic. Flag it as a question rather than silently fixing it. The goal is to remove the machine's tics, not the writer's voice.

## Diagrams read from the subject

Diagrams are content before they're visuals — the same clarity pass applies to what a diagram *says*. Put the subject/actor (usually the user) as the visual focus and the origin of the flow, and make every arrow mean something.

- Choose a reading direction that matches the mental model (top-down from the actor is usually safest).
- Every arrow encodes a true relationship and direction; don't add arrows for decoration or drop them and lean on floating boxes.
- Represent supporting elements as what they are (a key that "unlocks," not a co-equal box).

The failure mode is a diagram that's technically complete but reads wrong: a misleading left-to-right chain, missing arrows, a helper element drawn as a peer, the subject buried instead of centered.

## Prefer patterns over brittle specifics

For anything that evolves, lock examples to patterns and placeholders and cut content that silently goes stale. Teach the shape, not the snapshot. Use "the {vendor} integration" or "the current leader (X today)"; avoid an exhaustive feature list, a today's-pricing table, or a roster of names that will be wrong next quarter.

This complements the concrete-anchor rule, not contradicts it: every point still needs an anchor — just pick a durable one, or date it ("X today") so the reader knows it's a snapshot.

## Cut the filler, keep the piece honest

- **No unrequested pleasantries or decorative filler.** Greetings and asides addressed to the reader stay out unless the prompter asked for them. Same rule for filler dressed up as structure — an eyebrow (the small kicker line above a headline), parenthetical, footnote, or subtext line that adds personality but no information. Judge the content, not the form: a footnote that cites a source stays; one that makes a joke goes.
- **Keep scaffolding in sync.** Scaffolding is any part of the piece that describes or points at other parts rather than being content itself — builder notes, section labels, cross-references, page/section counts, a "three questions" promise in an intro. After edits, all of it must match the actual content. Stale instructions undermine trust.
- **Re-verify facts about the piece itself.** Round counts, word counts, "the version you're reading," "two sections later" — these are invalidated by the very editing this skill performs. "It took six rounds" is true at round six and wrong by round ten; "nearly twice the word count of what you're reading" flips truth-value every time the draft changes length. Re-check every self-referential specific on every pass, and prefer durable phrasings ("nearly twice as long") over exact counts that rot.
- **Completeness for how-to content** — make sure the reader can actually *start*: prerequisites and the literal first action (e.g. how to turn the thing on) belong in the piece, not assumed.

## Check

Read it back cold and fast. If the main point isn't obvious within a few seconds, or any line needs insider knowledge to follow, simplify again. The verify steps in "The pass" are the itemized checks; this is the gut check they add up to. The strongest test: hand it to a fresh agent (or person) with zero context — whatever they can't follow is exactly what to fix.

## The instinct to resist

The pull is to show all the work — to prove the depth is there. But understanding-fast is what gets rewarded, not thoroughness. The depth still exists; it just belongs in an appendix or notes, not in the reader's face.
