# Planning: audience, message, results

Planning words (message, order, arc) are for working with Aviv. They do not appear in the deck.

## Audience and detail level

Ask Aviv to choose (steps 2 of `SKILL.md`). He can mix: for example a research audience with a
high-level first part.

| Level | Audience | Slides (no backup) | On the slide | Methods section | Method slides |
|---|---|---|---|---|---|
| **High-level** | Management, clinical or product people, other teams without ML background | 5-8 | Plain words, no equations, no metric names. One number per claim. | Short, in plain words: what data, what was compared, how sure. Full details in backup or a linked report. | Rare: one simple picture of the idea |
| **Technical** | Engineers and scientists outside this project | 8-12 | Terms defined at first use. Key numbers with CIs. | Method in brief, key equation, data subset, counts | When a method is needed to read a result |
| **Research team** | The team that works on the models and data | 10-15, up to 20 for a long review | Metric names, effect sizes, noise floors, caveats on the slide | Full: all of the Methods checklist, math, code pointers, exact data and filters | When a method is new to the team or the result is meaningless without it |

The level decides:
- the number of slides and which results make it (a high-level deck drops nuance and
  secondary results to backup);
- the vocabulary and the detail of each data slide;
- how long the Methods section is, and whether it is on the slide, in a toggle, or in a backup;
- how many caveats are on the summary slide (all of them for the research team, the ones that
  change the decision for a high-level deck, the rest in backup).

Rule: a high-level deck still never hides a caveat that would change the audience's decision.

## The message

Aviv writes 2-3 sentences (step 3). They answer:
- What is the main message?
- Why does it matter to this audience (a decision, a next experiment, a model change)?
- What should they do or think after the talk?

If the project has no main result yet (work in progress), the message is a status: what is known,
what is not, the next test. That is valid.

Refine with Aviv (step 4). Questions that help him think:
- Is this one message or two? Which one is the talk about?
- What does the audience believe now, and what changes?
- What is the strongest alternative explanation, and which result removes it?
- Which result would you drop if you had half the time?
- Which of these sentences does the data not yet support?

## Order of the results

After the message is agreed, choose an order with Aviv. Name the pattern in the outline.

| Pattern | Use when | Order |
|---|---|---|
| Question to answer | One clear question and answer | Question, setup, evidence by strength, answer |
| Each result raises the next question | Findings build on each other | Result, "so we asked", next result |
| Elimination | "Not A, not B, so C" | Ruled-out alternatives, then the one that holds |
| Recommendation first | The audience must decide | Recommendation, evidence, caveats |
| Status so far | Work in progress | Known, unknown, what each next test decides |

The order of notebooks and reports is not the order of the deck.

## Choice of results

Score each inventory row. Include a result when it does at least one of these:
- is a step of the main claim (the claim fails without it);
- removes the most likely alternative explanation;
- surprises the audience, and holds up;
- is needed to trust the next result.

Leave a result out of the main flow (backup or out) when:
- it repeats another result (keep the clearer figure);
- it is a sanity check that passed (one line in a Methods section);
- it is tangential (backup, "Other findings");
- it is WIP and not agreed as Preliminary.

Keep a negative result when it removes an alternative the audience will think of. Put strong
evidence early. Order so that each result follows from the one before.

## Slide budget

- Fixed slides: motivation and goal, main findings, data, summary (plus backup).
- Result slides: the rest. A method slide only when the audience cannot read the next result
  without it; the Methods section holds the rest.
- About 1 slide per 2 minutes. Over budget: cut the weakest result, not the Methods.

## Work in progress

- Status line under the deck title: "Work in progress, <date>".
- Titles of unfinished results say what the data shows now, hedged ("no clear difference yet").
  A "Preliminary" tag says why in one line ("one seed", "not re-run").
- The summary slide has: what we know / what we do not know / next.
- The last slide before backup states the feedback or decision Aviv wants from the audience.
- A gap is a slide in the outline marked "missing". Do not fill it with a proposed result.

## Outline (what you send Aviv)

```
Deck: <name>   Audience: <who>   Level: <high-level|technical|research team>   Format: <...>
Slides: <n> (about <min> min)   Order pattern: <pattern>
Message (Aviv's words, refined): <2-3 sentences>

 #  Title (claim)                          Source       Visual               Type
 1  Motivation and goal                    spec, index  context diagram      fixed
 2  Main findings                          all          findings diagram     fixed
 3  Data                                   010          table + figure       fixed
 4  <claim>                                020 s2       020-gap.png          result
 5  How <method> works                     040 s3       040-method.svg       method
 ...
 n  Summary: conclusions and caveats       all          summary diagram      fixed

Methods section depth: <per level>
Left out (and why): ...        Preliminary / WIP: ...
Missing for the message: ...   Diagrams to make: ...
Strongest case against the main claim: ...
Questions for you: ...
```

Mark any title that goes beyond the agreed conclusions in the reports "(new claim)". Aviv's OK
of the outline covers them.
