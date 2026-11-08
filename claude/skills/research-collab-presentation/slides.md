# Slides: types, layout, Methods, diagrams, checks

Format-agnostic. The format files (`format-notion.md`, `format-html.md`) say how this is written.

## Deck order

1. **Title block:** audience, date, author, status ("Work in progress" if so). Nothing else.
2. **Motivation and goal.**
3. **Main findings.**
4. **Data.**
5. **Result slides and method slides**, in the approved order.
6. **Summary:** conclusions and caveats. For work in progress: known, unknown, next, and the
   feedback or decision wanted.
7. **Backup:** results left out (title, figure, one line each), other findings, provenance
   (reports and SHAs, runs, data snapshot, date).

## Result slide

- **Title = the main finding**, as a sentence, with the key number when short. Use the verb
  strength of the evidence ("reduces", "is consistent with", "no clear difference"). Not a
  topic. Exceptions: title block, data slide, method slides.
- **One main visual:** a figure. Two only if the audience must compare them (side by side).
  Variants of one figure (per game, per headset) go in tabs or in backup.
- One gray line: how to read it (axes, marks, what "no effect" looks like).
- 2-4 short bullets: facts with numbers, and the claim of the title. No figure description.
- **Methods** (out of sight until needed: a toggle in Notion, vertical sub-slides in HTML): see below.
- Text is short. Detail goes in the Methods section.

**Every slide has a visual:** a figure or a diagram. A table of numbers counts only on the data
slide and, if no figure fits, on the summary slide. No text-only slide.

## Fixed slides

- **Motivation and goal:** why the question matters, the goal, one context diagram (the
  setting, the problem, what we want to change). Source: spec, index, project note.
- **Main findings:** 3-6 numbered findings, in one line each, and a diagram "How the findings
  connect" (one node per finding, arrows for "leads to the question"). Same wording as the result
  titles and the summary.
- **Data:** the data of the deck. Table of counts (cohorts, subjects, sessions, runs, splits)
  and one descriptive figure (sessions per headset, age distribution, a data-split diagram).
  Only the shared data. Subsets and filters of one result go in that slide's Methods section.
  The level (`planning.md`) sets the detail.
- **Summary:** a diagram "How the results fit together" (claims in order, caveats marked), the
  conclusions (numbered, each names its slide), the caveats with the strongest case against the
  main claim, and the next step. No new results.
- **Method slide:** title says what the method does for this study ("MMD compares two embedding
  distributions without assuming a shape"). A diagram of the idea, 2-4 bullets, the one equation
  the audience needs (not for the high-level level), and a Methods section with the full math.
  Place it right before the first result that needs it. Not up front.

## Methods (every slide)

Every slide has them, also fixed slides and result slides. The format file says how they are
hidden. A long Methods part can be split in several parts (sub-slides in HTML, headings in a
Notion toggle), each short enough to read without scrolling. Source: code and reports, not memory.
**Depth follows the detail level** (`planning.md`):
- *Research team:* the full checklist of `../research-collab-report/report.md` ("Methods"):
  data (runs, checkpoint, split, cohorts and filters with counts, unit of analysis,
  representation), processing in order, math (equations, each symbol defined, estimator,
  statistics: test, CI method, resamples, seeds), math to code (`module.py:function`, choices
  that change the result), parameter values. "n/a" where it does not apply. "unknown" when the
  code does not show it: ask Aviv.
- *Technical:* the method in a few lines, the key equation, the data subset and counts, the test
  and CI method, a link to the report step for the rest.
- *High-level:* plain words: which data, what was compared with what, how sure we are. A link to
  the report step.

Data subsets and nuances that the audience does not need to read the result go here, not on the
slide. Link the source report step in each Methods section.

## Figures

- Reuse the report figure files. Do not redraw what reads well.
- A figure that cannot be read at slide size (small text, many panels): make a presentation
  variant in the analysis code, same data and statistics, saved next to the original with a
  `slide-` prefix, following `self-explanatory-figures`. Never change a computation.
- Mark the claim in the figure: highlight the series or headset that the title is about.
- Each image below 10 MB.

## Diagrams

- **Reuse first.** Method diagrams are made in the `research-collab` or `research-collab-report`
  stage and live in `<analysis>/out/diagrams/<name>.svg` (and `.png`). Use them. If a diagram
  exists but is too detailed or too small for a slide, make a simplified copy with a `slide-`
  prefix.
- **Missing:** make it. Rules for the diagram, same as in the reports: inputs, steps, output,
  what the key quantity measures; a tiny synthetic example when it helps; not a code
  flowchart. Save as SVG in `out/diagrams/`, convert to PNG
  (`rsvg-convert -w 1800 in.svg -o out.png`), look at the PNG. Tell Aviv a diagram was
  made here, and offer to add it to the report.
- Needed on: method slides, each complex method, and the fixed slides (context, findings,
  data split, summary).
- Style: white rounded background (it must read on any page background), dark text, at least
  14 px at 900 px width, one idea per diagram (split a complex method into 2-3 diagrams).
  `artifact-diagramming` skill for the drawing guidance.

## Writing

- ASD-STE100. Short sentences, simple words, active voice. No em or en dashes.
- **No planning words on slides or in titles:** "narrative", "story", "storyline", "arc",
  "takeaway message". Use plain scientific wording: "Findings", "Summary", "How the findings
  connect", "Conclusions", "Caveats", "Next steps". The same holds for the Methods sections.
- Define each term at its first use in the deck. Spell out acronyms once.
- Metric code names in `backticks` only in Methods sections, and only at research-team level.
- Numbers have units, and the noise floor or null next to a difference.

## Checks before you write

1. Each slide: finding title (or an allowed exception), a visual, short bullets, a Methods
   section at the depth of the level (or "n/a").
2. Titles match the approved outline, none stronger than its report conclusion.
3. The findings slide, the result titles and the summary say the same, in the same order.
4. Every term and acronym is defined before use. No planning words.
5. Each figure and diagram was looked at at slide size.
6. The format file's checks.
