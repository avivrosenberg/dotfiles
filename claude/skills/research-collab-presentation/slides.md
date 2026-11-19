# Slides: types, layout, Methods, diagrams, checks

Format-agnostic. The format files say how it is written.

## Deck order

- Sections come from the approved outline (`planning.md`).
- Order by dependency: define a thing before you use it.
- A method or reference space built for this study counts as a result.
  - Show it before the results that use it.

1. **Title block:** audience, date, author, status ("Work in progress" if so). Nothing else.

2. **Motivation and goal.**

3. **Main findings.**

4. **Data.**

5. **Result and method slides,** in the approved order.

6. **Summary:** observations and caveats.
   - Conclusions and next steps only as Aviv stated them. No placeholders.
   - Work in progress: known, unknown, next, and the feedback or decision wanted.

7. **Backup:**
   - results left out (title, figure, one line each);
   - other findings;
   - provenance (reports and SHAs, runs, data snapshot, date).

## Result slide

- **Title = a factual observation from the result shown, short.**
  - One line, about 4-10 words.
  - Based only on the evidence on the slide.
  - No interpretation, no full details, no exact metric values unless needed.
  - Good: "Headset 4980 decodes games worse than the rest".
  - Bad: "Headset 4980 game balanced accuracy is 0.41 vs 0.58 pooled (q = 0.003)".
  - Verb strength matches the evidence ("reduces", "is consistent with", "no clear difference").
  - Not a topic. Exceptions: title block, data slide, method slides.

- **One main visual:** a figure.
  - Two only if the audience must compare them (side by side).
  - Variants of one figure go in tabs or backup.

- **One gray line:** how to read it (axes, marks, what "no effect" looks like).

- **2-4 bullets, very short** (a few words to one short line).
  - Key values, not all of them.
  - No figure description. No explanation in full sentences.

- **Methods** (out of sight until needed): see below.

**Every slide has a visual:** a figure or diagram.

- A table counts only on the data slide.
- If no figure fits, a table can count on the summary slide.

## Fixed slides

- **Motivation and goal:**
  - why the question matters, and the goal;
  - one context diagram (setting, problem, what we want to change);
  - source: spec, index, project note.

- **Main findings:**
  - 3-6 numbered findings, one line each;
  - a diagram "How the findings connect" (one node per finding);
  - same wording as the result titles and the summary.

- **Data:** the shared data only.
  - A table of counts (cohorts, subjects, sessions, runs, splits).
  - One descriptive figure (sessions per headset, age distribution, a split diagram).
  - Subsets and filters of one result go in that slide's Methods.
  - The level sets the detail.

- **Method slide:**
  - The title says what the method does for this study ("MMD compares two embedding distributions without assuming a shape").
  - A diagram of the idea, and 2-4 bullets.
  - The one equation the audience needs (not for high-level).
  - Methods with the full math.
  - Place it right before the first result that needs it.

- **Summary:**
  - a diagram "How the results fit together" (observations in order, caveats marked);
  - the observations (numbered, each names its slide);
  - the caveats (real limits, not a rebuttal of the main claim);
  - the next step;
  - conclusions only as Aviv stated them;
  - no new results.

## Methods (every slide)

Every slide has them, also fixed and result slides.

- Write and check them with `research-methods` (method text, depth, layout).
- Link the source report step.
- Data subsets and nuances that the audience does not need to read the result go here, not on the slide.
- A long Methods part is split in parts.
  - Sub-slides in HTML, sub-headings in a Notion toggle.
  - Each part is readable without scrolling.

Depth follows the level (`planning.md`):

- research team: *Full*;
- technical: *Brief*;
- high-level: *Plain* (plus a link to the report step).

Slide limits for method content:

- One idea per slide or sub-slide.
- At most about 5-6 bullets and 1-2 block equations. More: split.
- Text, equations and diagram agree (`research-methods`, "Consistent with the text").
  - A simplified `slide-` copy of a diagram is allowed.

## Figures

- Reuse the report figure files.
- A figure that cannot be read at slide size (small text, many panels):
  - make a variant in the analysis code, same data and statistics;
  - save it next to the original with a `slide-` prefix;
  - follow `self-explanatory-figures`;
  - never change a computation.
- Mark the observation in the figure: highlight the series or headset that the title is about.
- A figure comes after the things it uses (a clustering, a reference space) are shown.
- Drop what the deck does not present. Do not repeat a figure.
- Every image opens in a zoom overlay on click (HTML template; Notion does it itself).
- Each image is below 10 MB.

## Diagrams

Method diagrams follow `research-methods`. Slide rules:

- **Reuse first.** The diagrams are made in the `research-collab` or `research-collab-report` stage.
  - If one is too detailed or small for a slide, make a simplified copy with a `slide-` prefix.
- **Missing:** make it with `research-methods`, save it, tell Aviv, and offer to add it to the report.
- Look at the PNG at slide size.
- Needed on: method slides, each complex method, and the fixed slides (context, findings, data split, summary).
- A method slide can use more than one diagram.

## Writing

- ASD-STE100. No em or en dashes.
- Facts only: slide text states what the results show.
  - Conclusions and interpretations only as Aviv stated them.
- No planning words on slides, titles or Methods ("narrative", "story", "storyline", "arc", "takeaway message").
  - Use "Findings", "Summary", "How the findings connect", "Caveats", "Next steps".
- Define each term at its first use. Spell out acronyms once.
- Metric code names in `backticks` only in Methods, and only at research-team level.
- Numbers have units. Key values are enough.
  - Put the noise floor or null next to a difference when it matters.

## Checks before you write

1. Each slide has a factual title (or an allowed exception), a visual, short bullets, and Methods at the depth of the level (or "n/a").
2. Titles match the approved outline, and none is stronger than its report.
3. The findings slide, the result titles and the summary say the same, in the same order.
4. Every term is defined before use. No planning words.
5. Each figure and diagram was looked at at slide size.
6. Method content follows `research-methods` and the slide limits above.
7. The slides are in the sections of the outline.
8. A change reached the notebook, the report and the deck.
9. The format file's checks.
