---
name: research-collab-report
description: Build or update a local HTML report that holds all the results of one analysis notebook or script (figures, tables, methods, how to interpret, observations), plus a linked index page per analysis. Part of the research-collab loop - a way to present results to Aviv for review. Use when Aviv asks for a report of a notebook or script, asks to update one, or after a notebook or script with a report was re-run (offer first). Local files only; publish only when Aviv asks.
---

# Research-collab report

A local HTML page per analysis notebook or script, so Aviv can see all its results in one place
at any time, and an index page per analysis that links them. Inline results in the chat are for
fast iteration; the reports are the persistent view.

- Report page design (principles, outline, step block, Methods checklist, HTML layout, writing
  rules): `report.md`. Read it before you write or restructure a report.
- Index page design: `index.md`.

**Conclusions are Aviv's.** Write only conclusions that he agreed to, in the chat, the spec or
the project records. Otherwise write "Conclusion: not yet discussed".

## Files

- Location: the reports folder that the project instructions give. Default:
  `<analysis folder>/reports/`. Not in git: if the analysis `.gitignore` does not list
  `reports/`, add it.
- One report per notebook or script: `reports/<notebook or script name>.html`.
- One index per analysis: `reports/index.html`.
- Shared CSS and JS, if any: `reports/assets/`.
- Figures: relative links to the saved files (e.g. `../out/figures/020-gap/fig.png`). Do not
  copy or embed them. Tables: built from the saved CSV files or the notebook outputs.

## Build a report

1. **Inputs:** the spec (question, predictions, method intent), the notebook or script and the
   modules it imports, its saved figures and tables, its printed outputs, the runs, and the git
   SHA of each repo (plus uncommitted changes). The code is the source of truth for the methods.
2. **Check the inputs:** outputs missing or older than their code, partial runs, WIP results.
   Tell Aviv; WIP results stay off the page.
3. **Look at every figure** and note what it shows before you read the notebook markdown.
4. **Write** the report with `report.md`. Check before you finish: each step has its Methods
   toggle with the full checklist (or "n/a"), each symbol defined, each equation linked to its
   function, each figure with "How to interpret".
5. **Index:** create or update `index.html` with `index.md`.
6. **Check the render once** in the browser pane (light and dark): every image loads, math
   renders, toggles and tabs work, links between pages work, nothing overlaps. Make one pass of
   fixes; do not loop.
7. **Tell Aviv** the path, and the open questions for him (unknown method details, steps with no
   agreed conclusion).

## Update a report

- After a notebook or script with a report is changed and re-run, offer to update its report.
- Update only the changed steps (diff the code since the provenance SHAs, compare the outputs).
  Keep the rest, and keep Aviv's requested changes.
- Update the provenance, the changelog (appendix) and the index (row, and every conclusion,
  finding or caveat that cites a changed step).
- Tell Aviv in one short list what changed: added, changed, removed.
