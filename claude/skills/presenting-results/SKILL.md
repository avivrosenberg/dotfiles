---
name: presenting-results
description: How to show data, results and methods to Aviv in the chat - inline figures, inline tables, inline diagrams and interactive widgets, with observations but no conclusions. Use whenever you show a figure, a table, a data summary, analysis results, or explain how a method or pipeline works. Mandatory inside the research-collab loop.
---

# Presenting results

Show, don't only tell. Data summaries, results summaries and method explanations are figures,
tables or diagrams, with short text. Use text alone only when a visual adds nothing.

## Figures

- Inline in the chat text, as markdown image references with absolute paths:
  `![<short description>](/abs/path/to/figure.png)`. Aviv clicks the link to see the figure.
- The file must be inside a folder of the current session, or Aviv can't open it. If it is
  not, add the folder to the session first.
- Put each figure directly below the text it supports.
- Do not use file cards or published Artifacts for results, unless Aviv asks. For one view of
  all the results of a notebook or script, use `research-collab-report`.
- Save figures in the project's output folder (the project instructions say where), not in a
  temporary folder.
- Follow the `self-explanatory-figures` skill. Render each figure and look at it before you
  show it.

## Tables

- Inline markdown tables. Keep them small: the rows and columns that matter, rounded numbers.
- Bold only by a stated rule (e.g. "bold: |z| > 3").
- For a large table, show the top rows and save the full table as CSV next to the figures.

## Diagrams and interactive widgets

Use them often. They are the best way to explain how a method works, a pipeline, a data flow,
a data split, a study design, or how the parts of a plan fit together.

- Inline in the chat: the `show_widget` tool (load its guide with `read_me` first). SVG for
  static diagrams, HTML for interactive ones.
- Interactive when a parameter changes the picture (e.g. a slider for a regularization weight
  or a kernel bandwidth, a toggle between two designs).
- Keep each diagram sparse; split a complex topic into several diagrams, with text between them.
- Synthetic examples (data with known ground truth) explain a method well. Make them as figures
  in a separate method notebook.
- To keep a diagram with the project, also save it as an SVG file and reference it like a figure.

## Format of one result

```markdown
### <n>. <the question this result answers>

**Methods:** 1-3 lines: data, what is computed, the statistic and its CI.

![<description>](/abs/path/fig.png)

**How to interpret:** axes, marks, what "good" or "no effect" looks like.

**Observations:**
- Read the figure and present facts only, the few most important ones, with numbers
  where they add to the figure.
```

- Show results one at a time, or in small groups. Don't dump a whole analysis at once.
- Observations are not conclusions. Don't write "this shows", "this means" or "so".
