# Planning: audience, message, sections, results

Planning words (message, order, arc) are for working with Aviv. They do not appear in the deck.

## Audience and detail level

Ask Aviv to choose (step 2 of `SKILL.md`). He can mix, e.g. a research audience with a
high-level first part.

| Level | Audience | Slides (no backup) | On the slide | Methods | Method slides |
|---|---|---|---|---|---|
| **High-level** | Management, clinical or product people, other teams without ML background | 5-8 | Plain words, no equations, no metric names. At most one key number per observation. | Plain words: what data, what was compared, how sure. Details in backup or a linked report. | Rare: one simple picture |
| **Technical** | Engineers and scientists outside this project | 8-12 | Terms defined at first use. Key numbers; CIs where they matter. | Method in brief, key equation, data subset, counts | When a result needs the method |
| **Research team** | The team that works on the models and data | 10-15, up to 20 for a long review | Metric names, effect sizes, noise floors, caveats | Full checklist, math, code pointers, exact data and filters | When the method is new to the team |

The level decides:

- the number of slides, and which results make it (a high-level deck moves nuance and secondary results to backup);
- the vocabulary, and the detail of Methods;
- how many caveats are on the summary slide:
  - research team: all of them;
  - high-level: the ones that change the decision, the rest in backup.

A high-level deck never hides a caveat that would change the audience's decision.

## The message

Aviv writes 2-3 sentences (step 3):

- the main message;
- why it matters to this audience (a decision, a next experiment, a model change);
- what they should do or think after the talk.

With no main result yet (work in progress), the message is a status: what is known, what is not, the next test.

Questions that help him refine it (step 4):
- Is this one message or two? Which one is the talk about?
- What does the audience believe now, and what changes?
- Which result removes the alternative explanation the audience will think of?
- Which result would you drop if you had half the time?
- Which sentence does the data not yet support?

## Order of the results

After the message is agreed, choose an order with Aviv and name the pattern in the outline. The
order of notebooks and reports is not the order of the deck.

| Pattern | Use when | Order |
|---|---|---|
| Question to answer | One clear question and answer | Question, setup, evidence by strength, answer |
| Each result raises the next question | Findings build on each other | Result, "so we asked", next result |
| Elimination | "Not A, not B, so C" | Ruled-out alternatives, then the one that holds |
| Recommendation first | The audience must decide | Recommendation, evidence, caveats |
| Status so far | Work in progress | Known, unknown, what each next test decides |

## Choice of results

Include a result when it:

- is a step of the main claim (the claim fails without it);
- removes the most likely alternative explanation;
- surprises the audience, and holds up;
- is needed to trust the next result.

Leave it out of the main flow (backup or out) when it:

- repeats another result (keep the clearer figure);
- is a sanity check that passed (one line in a Methods section);
- is tangential (backup, "Other findings");
- is WIP and not agreed as Preliminary.

Keep a negative result when it removes an alternative the audience will think of.

Put strong evidence early. Each result follows from the one before.

## Slide budget

- Fixed slides: motivation and goal, main findings, data, summary (plus backup).
- Result slides: the rest.
- A method slide only when the audience cannot read the next result without it.
- About 1 slide per 2 minutes. Over budget: cut the weakest result, not the Methods.

## Work in progress

- Status line under the title: "Work in progress, <date>".
- Titles of unfinished results say what the data shows now, hedged ("no clear difference yet").
- A "Preliminary" tag says why in one line ("one seed", "not re-run").
- Summary: what we know / do not know / next.
- The last slide before backup states the feedback or decision Aviv wants.
- A gap is a slide in the outline marked "missing". Do not fill it with a proposed result.

## Outline (what you send Aviv)

```
Deck: <name>   Audience: <who>   Level: <high-level|technical|research team>   Format: <...>
Slides: <n> (about <min> min)   Order pattern: <pattern>
Message (Aviv's words, refined): <2-3 sentences>

    Title (factual observation)            Source       Visual               Type
 A. <Section: the question or topic it covers>
 1  Motivation and goal                    spec, index  context diagram      fixed
 2  Main findings                          all          findings diagram     fixed
 3  Data                                   010          table + figure       fixed
 B. <Section>
 4  <observation>                          020 s2       020-gap.png          result
 5  How <method> works                     040 s3       040-method.svg       method
 ...
 C. <Section>
 n  Summary: observations and caveats      all          summary diagram      fixed

Methods depth: <per level>
Left out (and why): ...        Preliminary / WIP: ...
Missing for the message: ...   Diagrams to make: ...
Questions for you: ...
```

- Titles are short factual observations (`slides.md`).
  - Mark a title that says more than the observations of its report "(beyond report)".
  - Aviv's OK covers the titles and the sections.
- **Sections** are decided here, before the deck is written.
  - A section is one question or topic.
  - It starts with a short intro slide (what we ask, why), and ends with a link to the next section.
  - Above 8 slides, sections are required.

## Visual review

After the outline is approved, before you write the deck:

- Make one HTML page with all planned visuals, numbered in deck order, each with its slide title.
- Save it next to the outline (e.g. `decks/figure-review.html`).
- Aviv comments by number.
- Fix the visuals, then write the deck.
