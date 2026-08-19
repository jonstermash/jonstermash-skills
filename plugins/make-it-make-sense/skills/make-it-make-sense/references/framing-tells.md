# Substance reference — honesty, accuracy, framing

Loaded by **Pass 1 · Substance**. These are the tell-lists and edge cases behind the substance moves. The gate fires from SKILL.md without this file; open it for the *how*.

## Cut defensive framing

Copy that pre-justifies, braces for criticism, or spins a shortfall reads as insecure and draws the reader's eye straight to the weak spot. This matters most in anything an audience judges — client, leadership, or reviewer-facing work.

Tells to strip on sight:

- "on purpose," "by choice, not under-resourced," "deliberate(ly)," "a conscious decision"
- "not on us," "not our fault," "not by our readiness," "externally blocked"
- "isn't a fluke," "not a one-off," "this is real"
- "an honest read," "to be transparent," "full disclosure"
- "verified data," "real numbers" (used as a trust-me rather than a citation)
- "deferred, not abandoned," "delayed, not dropped"
- "rather than spread thin," "we chose to focus"

**The fix:** state what happened and the path forward. Name a shortfall plainly, then pivot — a reader trusts "deferred to Q3" far more than "deferred on purpose, not under-resourced." If a cause is genuinely external, say it once as a fact ("gated by the vendor's timeline"), not as a defense ("not on us"). A real strategic contrast ("automation, not promotion") is fine — that informs; the ban is on framing that exists to protect the author.

Note the seam with quantitative claims: "isn't a fluke" is on the strip-list *as a defensive assertion*. If the result genuinely isn't a volume artifact, you don't say so — you **show the denominator** (`quant-claims.md`). Don't assert it defensively; prove it, or drop the claim.

## Grade on the gap, not around it

A verdict lands, and one clause later the piece names something that revokes it. "Our spec was right, with one real gap." "The migration is complete — auth isn't wired up yet." "Broadly accurate; the revenue figure is off by a factor of ten." Each reads as good news with a footnote. Each is bad news with a preamble.

The plain version: **this car runs, but it doesn't have wheels.** Nobody says the car runs.

This is a substance failure, not a tone one, because the reader takes their action from the verdict and skims the qualifier. A headline that says "pass" over a body that says "fail" doesn't merely annoy — it routes the decision the wrong way, and the piece can point at the caveat afterward and claim it disclosed everything.

**The test — do the two halves imply the same action?** Read the verdict alone, then the caveat alone, and ask what each tells the reader to do next. Ship vs. hold. Approve vs. rework. Build on it vs. go back. If they diverge, the caveat is the verdict.

Tells:

- "right, with one gap," "correct but incomplete," "works, aside from," "solid overall — one caveat"
- "mostly," "broadly," "largely," "directionally right," "90% there," "nearly"
- diminutives doing the arguing the evidence can't: "one," "minor," "small," "just," "only," "a couple," "a single"
- "one *real* gap" — conceding it matters, then parking it in a subordinate clause
- a passing grade in the heading with the blocker demoted to a bullet, an appendix, or a "note"

**The fix: reorder so the true verdict is the headline.** "The spec misses the auth flow; everything else holds." Same two facts, and nothing is lost — what passed still gets said, it just stops being the lead. If the gap can be sized, size it ("blocks launch until fixed," "two weeks of rework") instead of reaching for "minor."

This is not a ban on caveats or on good news. When the gap genuinely doesn't change what the reader does — cosmetic, already scheduled, owned by someone else — "right, with a small gap still open" is accurate and stays. The rule fires only when the caveat is disqualifying and the framing hides it.

Note the seam with `syco-killer`: its Gate 2 says put a disqualifying flaw in the first paragraph, which is about *where* the bad news sits in a conversation. This is about the *verdict itself* — in an artifact, moving the gap up front isn't enough if the headline still reads "pass."

### The severity variant — rate the consequence, not the failure mode

The same shape, one level down: the headline isn't "pass," it's "low priority." Bug lists, risk registers, and audit findings are where it lives.

> "It fails cleanly and writes nothing, so it's much less urgent than #1 — but it blocks importing for any UPC the tenant hasn't used before."

Two moves are stacked there, and both are worth catching on their own:

- **Graded on the failure mode instead of the consequence.** "Fails cleanly and writes nothing" answers *will this corrupt data?* That's a real question with a good answer — it's just not the one that sets priority. The priority question is *what can't the user do?* Here: import any new product. Answering the safer question and reporting the result as the severity is the sleight of hand.
- **Severity by comparison.** "Much less urgent than #1" rates the item against another finding rather than on its own. Ranking is not absolution — in a list where everything below the top item gets softened this way, the reader deprioritizes a stack of individually blocking bugs.

Watch the scope label too. "Any UPC the tenant hasn't used before" is every new product — the main path, described as a boundary condition. When "edge case" is doing that work, the edge is the feature.

**The test — state the consequence with no comparison and no failure-mode adjective, then rate it.** "New UPCs can't be imported." If the rating moves once the softeners are gone, the softeners *were* the argument.

**The fix:** consequence first, and demote the graceful-failure fact to what it actually is. "Imports fail for any UPC the tenant hasn't used before. Nothing is written, so there's no cleanup." Both facts survive; "fails cleanly" stops being a priority claim and becomes a remediation note, which is the only thing it was ever evidence of.

Failing safe genuinely matters — it's the difference between a bug and an incident. It belongs in the line about *fixing* the thing, never in the line about *how much it matters*.

Tells: "fails cleanly," "fails safe," "no data loss," "non-destructive," "recoverable," "only affects," "less urgent than," "compared to #1," "second-order," "edge case," "low severity — but."

## Impact over activity

Summaries and subtitles default to listing what the author *did* instead of what the reader *gets*. The tell: every noun is an input — "a fix, a signed contract, a data set." That's a to-do list, not a result.

The sharper failure: presenting something that *costs* the audience as an achievement for them — "we deepened the partnership / signed a larger agreement" on a page meant to show the client value. To the reader that line is an expense, not a benefit.

**The fix:** make the subject the reader's business, lead with the outcome and a concrete number, and demote enablers (new budget, tooling, headcount, scope) to forward-looking context — what powers the next phase, not a trophy. "We protected the revenue stream that drives a third of the total" beats "we completed a fix, signed a scope, and gathered data."

## Frame decisions consultatively

When a piece asks the audience to decide something, a passive list of open items ("X is blocked — your call") reads as a status dump, not advice. First, sanity-check that each item is even the reader's decision to make — a list of "decisions for you" that quietly folds in the author's own calls (internal headcount, staffing, roadmap) misroutes the ask; move those out before structuring the rest. Then structure each real decision as **situation → options → your recommendation → the specific ask.** The recommendation is what makes it consultative.

If you don't have the author's actual recommendation, do not invent one. Insert a marked placeholder ("_recommendation to add_") and ask, or present the options with an explicit "for discussion" frame. Presenting neutral options is honest; fabricating a point of view the author never gave is not.

## Simplify without distorting

The shorter version must stay true — to the facts *and* to the advice. This is the constraint on every other move in the skill. Distortions to watch for:

- **Over-generalizing quantifiers** — "this covers *every* segment" when it covers three; an "*always*/*all*/*never*" the source doesn't support. Name the real scope.
- **Collapsing distinct actions** — calling a tool a "fix" when it only *diagnoses*; saying a step "sends" the email when it drafts one; "saves to the shared drive" when it writes to a temp file. Verb precision matters.
- **Wrong specifics** — figures, names, dates, syntax, menu paths, UI labels. Confirm against the actual source, not your memory of it. **And a specific's presence in the draft is not evidence it's true** — when the draft is itself AI-written, its numbers and names are the likeliest fabrications in the piece, and they read as the author's own. Confirm every figure, name, and date against the original source or ask the person. "I won't invent a number for you" is not a reason to *protect* a number that was already invented.
- **Flipped advice** — compressing "write a detailed brief" down to "keep it short," or "review carefully" into "trust the output." You often know more than the reader; don't let a neat phrasing encode the wrong lesson.

If you can't verify a simplified claim, flag it rather than shipping it clean and confident.

## Write about the artifact from the artifact

When the piece describes an existing artifact — a skill, a product, a doc, a feature — its substance comes from the artifact itself, read in full, not from your memory of conversations about it. Quote or closely paraphrase what it actually says; don't write *around* it with anecdotes and invented examples standing in for its real content. Sourcing from the artifact also fixes fabrication for free, because its own examples replace the ones you'd otherwise invent.

Represent its scale honestly, too. "It'll be running on everything" for what is really a list of editing moves is scope inflation — the heading-buzzword problem applied to a claim. Describe what the thing is, at the size it actually is.

## Define by essence, not example

Lead a definition or framing with the core idea in plain terms; attach examples only as illustration ("…e.g. X, Y"). If the examples were removed, the sentence should still define the thing.

The failure mode is a term defined *as* its examples — "context" explained as "the business background, brand, and notes" instead of "the supporting information that helps the work." The examples eat the definition.

## Prefer patterns over brittle specifics

For anything that evolves, lock examples to patterns and placeholders and cut content that silently goes stale. Teach the shape, not the snapshot. Use "the {vendor} integration" or "the current leader (X today)"; avoid an exhaustive feature list, a today's-pricing table, or a roster of names that will be wrong next quarter.

This complements the concrete-anchor rule, not contradicts it: every point still needs an anchor — just pick a durable one, or date it ("X today") so the reader knows it's a snapshot.
