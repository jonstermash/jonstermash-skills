# Titles and headings reference

Loaded by **Pass 2 · Structure**. The Structure gate (the outline reads as an index, not a summary) fires from SKILL.md; this file is the how and the anti-pattern list.

## Categorical by default

**A heading names its subject. It does not state its content.** The default form is a categorical noun phrase — the thing the section is *about* — and you depart from it deliberately, not by drift.

This applies at any medium and any level: a slide headline, a doc section head, a report title, an email subject line, and the smaller labels too — a **bolded lead-in** inside a section, a list-item label. If it heads content, it's a heading.

| Instead of | Write |
|---|---|
| "What we measured, and over how long" | "Method" |
| "How we'd back this out if it fails" | "Rollback plan" |
| "Three caveats we couldn't rule out" | "Limitations" |
| "What this ends up costing" | "Cost" |

The reason is what a heading is *for*. The reader uses it to navigate — to find the part they need and skip the rest. That job wants a short, stable address. A heading that delivers the section's content instead makes the reader read the same thing twice and turns the outline into a summary, which is the one thing a table of contents must not be.

**The exception, chosen not drifted into.** Argument content can take a genuine claim or question with tension, and it's the right call where the heading may be the *only* thing read: a slide ("Never start from a blank page"), an email subject ("We're moving the launch to August"), a report's single headline finding ("Churn is a pricing problem, not a product one"). The test for a claim heading is whether **the body pays it off** — a claim the section doesn't deliver is a teaser. Use it once or twice in a piece, where it earns its place. An outline that is *entirely* claims has stopped being an outline.

**Don't force a claim onto reference content.** Forcing a punchy "claim" onto a status table, scorecard, agenda, or spec produces *spin* — the writer reaches for drama the data doesn't support ("Three advanced, one waited on purpose" over a plain "Q2 status"). If the reader consumes it row by row, label it plainly. And don't dress reference content up: rename "Everything You've Ever Wondered" back to "FAQ."

## The literal heading

The failure this default exists to stop, and the one that survives every other check on this page. A literal heading restates what the section says, in a sentence or sentence fragment, instead of naming what it's about.

- "Why the migration slipped from June to August"
- "What this means for the onboarding team"
- "Three caveats we couldn't rule out"
- "How the cache invalidation actually works"

None of these is a buzzword, a colon construction, a teaser, or an orphaned pronoun. Each has a real subject and reads well in place. That's exactly why they slip: they're only detectable against a stated default, not against a list of defects.

Two tests, either sufficient:

1. **Form.** Does it have a finite verb? "Why the migration *slipped*," "What this *means*," "How it *works*." A categorical heading is a noun phrase — the verb is a tell that the heading is doing the body's job.
2. **Redundancy.** Read the heading, then the section's first sentence. If they carry the same information, the heading is literal. This is the significance coda in miniature, at the top of the section instead of the bottom.

The fix is almost always a shorter noun phrase already sitting inside the heading: "Why the migration slipped from June to August" → "Migration delay." "How the cache invalidation actually works" → "Cache invalidation."

**Categorical is not vague.** "Overview," "Details," "Background," "Next Steps," "Other considerations" are categorical *and* useless — they'd sit unchanged over anyone's document on any topic. The default is the shortest noun phrase that is still specific to **this** piece. "Rollback plan" passes; "Approach" doesn't.

## Report a result; don't editorialize it

When a heading or label presents a result, lead with what happened and the number that proves it, then stop — the reader draws the verdict. "A win and a risk," "a bright spot," "surprisingly strong," "the good news" is the author's read, not the finding. State the outcome ("X drives 30% of revenue"); the significance is the reader's to feel, and any implication belongs in the supporting line, not the headline.

## Anti-patterns to reject on sight

- **Vague buzzwords** — "revolutionize," "delve," "game-changer," "unlock," "supercharge," "seamless," "elevate." Empty calories; cut them.
- **Generic** — a heading that would sit unchanged over anyone's document on any topic ("Overview of Our Findings," "The Steps Build on Each Other," "Background," "Other Considerations"). Categorical is the default, but categorical-and-interchangeable is the failure — cut to the shortest noun phrase specific to this piece ("Findings," or better, what they're findings *about*).
- **Throat-clearing / meta headings** — a heading that announces the structure instead of naming the content ("If you remember three things," "A few takeaways," "Here's what we'll cover," "Some thoughts on X"). Replace with the subject itself.
- **Cheesy colon constructions** — "Q3 Results: What You Need to Know," "Our Approach: A Deep Dive." Cut the colon; say the thing.
- **Captain Obvious** — a fact with no tension ("Our Product Has Several Features," "The Report Is Attached"). Not limited to headings: the same empty statement in body prose ("under the hood, it's a text file") is the same failure — cut it or make it earn its place.
- **Orphaned pronoun** — a heading leaning on "it / this / that / what" whose antecedent lives in the paragraph above rather than in the outline ("This is every time," "What it does," "Knowing how it fails is the skill" — knowing how *what* fails?). It reads fine in place because the body supplies the referent — exactly what a heading can't borrow. A heading names its own subject.
- **Forced cleverness** — reaching for a catchy count or teaser ("Five Rules Worth Keeping," "3 Things That'll Surprise You").
- **Filler words** — "using it *well*," "*A quick look at* X." If a word can go, it goes.
- **Over-long** — if it wraps to two lines, it's probably a subheading. Demote the long "clever" line and write a short heading above it.

## The heading test

Read only the headings (or subject lines, or the doc's outline) in order. The outline should read as an **index, not a summary**. Specifically:

1. each names its own subject rather than stating its content — no finite verb unless you chose a claim heading deliberately,
2. none restates the opening line of the section it heads,
3. each is specific to this piece — it could not sit unchanged over someone else's document on another topic,
4. no two are interchangeable with each other,
5. any claim heading is paid off by its body, and there are few enough of them that the outline still reads as an outline,
6. zero colons-as-crutch and zero filler, and
7. no pronoun whose antecedent lives outside the outline — any "it / this / that" still standing needs its noun spelled out.

**Note the criterion this replaced.** Earlier versions asked that the headings "tell the story on their own." That test was backwards: a categorical outline (Scope · Method · Findings · Limitations · Cost) fails it, while a fully literal one ("We tested 40 accounts over six weeks," "Churn traces to pricing, not onboarding," …) passes cleanly. The gate was selecting for the failure, which is why literal headings survived every anti-pattern on this page. Don't reintroduce it.
