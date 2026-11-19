---
name: research-collab-report
description: Build or update a local HTML report that holds all the results of one analysis notebook or script (figures, tables, methods, how to interpret, observations), plus a linked index page per analysis. Part of the research-collab loop - a way to present results to Aviv for review. Use when Aviv asks for a report of a notebook or script, asks to update one, or after a notebook or script with a report was re-run (offer first). Local files only; publish only when Aviv asks.
---

# Research-collab report

A local HTML page per analysis notebook or script, with all its results.
An index page per analysis links them.

- Inline results in the chat are for fast iteration.
- The reports are the persistent view.

Design files:

- Report page: `report.md`. Read it before you write or restructure a report.
- Index page: `index.md`.

**Facts only by default.**

- Write what the figures and tables show.
- Conclusions and interpretations are Aviv's.
- Add only the ones he stated, in the chat, the spec or the project records.
- Otherwise write "Conclusion: not yet discussed".

## Files

- Location: the reports folder from the project instructions.
  - Default: `<repo_out_dir>/<analysis_name>/reports/`, git-ignored.
  - brain-bugs: `out/analyses/` (constant `ANALYSES_OUT_DIR`, shared by all worktrees).
  - In analysis code, use `BASE_OUT_DIR` from `consts.py`.
- One report per notebook or script: `reports/<name>.html`.
- One index per analysis: `reports/index.html`.
- `reports/assets/`: copy `template/report.css` and `template/report.js` from this skill when missing.
  - They give the tabs and the figure zoom.
- Figures: relative links to the saved files (`../figures/020-gap/fig.png`), not copies.
- Tables: built from the saved CSV files or the notebook outputs.

## Build a report

1. **Repo conventions:** the "Analysis reports" section of the repo's `CLAUDE.local.md`.
   - If it is missing, ask Aviv.

2. **Inputs:**
   - the spec;
   - the notebook or script and its modules;
   - saved figures and tables, and printed outputs;
   - the runs;
   - the git SHA of each repo (plus uncommitted changes).

   The code is the source of truth for the methods.

3. **Check the inputs:** outputs missing or older than their code, partial runs, WIP results.
   - Tell Aviv.
   - WIP results stay off the page.

4. **Look at every figure** and note what it shows before you read the notebook markdown.

5. **Write** with `report.md`. Check each step:
   - its Methods toggle has the full checklist (or "n/a");
   - each symbol is defined;
   - each equation is linked to its function;
   - each figure has "How to interpret";
   - each non-trivial method has its diagram.

6. **Index:** create or update `index.html` with `index.md`.

7. **Check the render once** in the browser pane (light and dark):
   - images load, and a click on a figure opens the zoom;
   - math renders;
   - toggles, tabs and links work;
   - nothing overlaps.

   Make one pass of fixes, no loop.

8. **Tell Aviv** the path and the open questions:
   - unknown method details;
   - steps with no agreed conclusion.

## Update a report

- After a notebook or script with a report is changed and re-run, offer to update its report.
- Update only the changed steps.
  - Diff the code since the provenance SHAs, and compare the outputs.
  - Keep the rest, and keep Aviv's requested changes.
- A fix to a figure or a term goes to its source (notebook or script) first.
  - Then it goes to every report, index and deck that uses it.
- Update the provenance, the changelog (appendix) and the index.
  - Index: the row, and every conclusion, finding or caveat that cites a changed step.
- Tell Aviv in one short list what changed: added, changed, removed.
