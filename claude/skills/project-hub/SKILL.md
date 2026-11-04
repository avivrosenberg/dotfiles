---
name: project-hub
description: Use when Aviv asks to track a research project in Notion - a project hub page with the status, research questions, current best answers and evidence, and one sub-page per experiment with full methods and results from his analysis (notebooks, figures, tables, model runs). Trigger on "make a report from notebook X", "put these results in Notion", "update the report with the new figures", "create a sub-page for this experiment", "address my comments on the report", "update the hub", "refresh the project page", "what is the project status", or a pasted Notion link to a project hub or one of its sub-pages.
---

# Project hub in Notion

Claude keeps one place in Notion for all the results of a research project: a **hub page** that
tracks the project (status, questions, current best answers, evidence), and one **sub-page per
experiment** with all its current methods and results. Aviv uses the sub-pages to recall the
exact methods and to scrutinize the results, so the methods must be complete and exact.

- Page design (hub, sub-page, step block, methods checklist, flags, writing rules):
  `structure.md`. Read it before you write or restructure a page. It is a guideline, not a form.
- Notion mechanics (working copy, figure upload, markdown, safe edits, comments): `notion.md`.
- Two or more sub-pages in one run, or a hub refresh: `multi-page.md` (one sub-agent per page).

## Ownership

- **Claude writes the pages.** Aviv reviews them and asks for changes.
- **Questions and goals are Aviv's.** Propose changes; apply them only after he approves.
- **Conclusions are Aviv's.** Write only conclusions that Aviv agreed to, from the chat, the
  spec or the project records: local, global and group conclusions, the short-answer callout
  and the hub answers. Do not propose conclusions on a page. If a section has no agreed
  conclusion, write "Conclusion: not yet discussed" and list it under "Questions for Aviv" in
  the chat report.
- **Audience:** the hub starts private and goes public when mature. Write every page so the
  team understands it without the chat.

## Page boundaries

- One sub-page = one main question (or 2-3 linked ones) with one shared setup (same runs, data,
  method family). If the short-answer callout needs two unrelated paragraphs, split the page. A
  new type of question ("what is the gap?" vs "does an intervention close it?") is a new page.
- One page per experiment, updated in place. Never make a second page for the same experiment.
- Notebooks are not pages. One sub-page can use several notebooks, and one notebook can feed
  several sub-pages. The page order follows the argument, not the notebook order.
- Findings flow up one level: step -> experiment ("Other findings", "Open questions") -> hub
  (leads, candidate questions).

## Inputs

- **Spec:** the research spec of the experiment (from `research-collab`), if one exists. It is
  the first source for the question, the hypotheses and predictions (the "Expectation" of each
  step) and the method intent. The code is the source of truth for what was done.
- **Repo conventions:** the "project-hub" section of each analysis repo's `CLAUDE.local.md`:
  analysis and figure folders, notebook format, runs and their metrics, other repos to record
  SHAs for, extra methods-checklist items. If a repo has no such section, infer the conventions
  from the repo, confirm them with Aviv before the first Notion write, then propose to add them.
- **Project sources:** the repos and analysis folders in the hub provenance line.
- Project notes: only if Aviv points to them.

## Keep the context small

- Read large pages from a working copy, and only the sections you edit (`notion.md`).
- Fetch each page once per edit round. Fetch again only after a `replace_content`, after
  warnings, or before the next round.
- Look only at the figures in scope, as a smaller copy in the scratchpad
  (`sips -Z 1000 <fig> --out <scratchpad>/fig/<name>.png`).
- Read large notebooks, code and Bash output in parts. Do not read the Notion markdown spec
  unless `notion.md` does not cover a block type.

## Workflow

### 1. Find the inputs
- Fetch the hub. If a sub-page has the same experiment question (also in an older format), this
  is an update (step 6).
- **New project:** propose the hub context, goals and questions to Aviv; write them after he
  approves. **Hub in an older format:** tell Aviv; restructure only when he asks.
- Read the spec, the notebooks and the modules they import (for jupytext pairs: the script for
  code and markdown, the notebook for outputs). Collect the saved figures, printed numbers and
  tables. Inline-only outputs: `python3 -I scripts/extract_nb_outputs.py <nb.ipynb> <out_dir>`
  (in this skill folder).
- Record the git SHA of each repo (`git -C <repo> rev-parse --short HEAD`) and any uncommitted
  changes.
- Check that inputs are complete and current: notebooks without outputs, partial runs, figures
  older than their code or no longer made by it. Results that Aviv marked WIP stay off the page;
  list them as pending in "Open questions".

### 2. Understand the results
New page: read the full analysis. Update: work on the delta only. Make a **change list**:
1. Fetch the page: sections, flag markers, provenance SHAs. If it has markers, read those open
   flags on the Review page.
2. `git -C <repo> diff <sha> -- <analysis folder> <imported modules>` plus uncommitted changes;
   compare figures and outputs with the page. Each item: **new**, **updated** or **unchanged**.
3. **Flag fixes:** for each open flag, a quick check if the diff does what its suggested fix
   asks. Add it with one line on what changed. Not a review.
4. **Comments:** read all open comments (`notion.md`). Add each with its anchor and the change
   it asks for. A question gets an answer in the chat report. A comment you cannot interpret
   goes to Aviv before you write. Comments alone can be the whole change list.

Then read the implementation of the items in scope (notebook, analysis modules, the shared code
that loads data and computes metrics, also in other repos), and collect the methods checklist
of each step (`structure.md`). Look at each figure in scope and note what it shows before you
read Aviv's markdown about it. Report obvious problems (numbers that disagree, broken figures)
in chat. A full correctness review is `project-hub-review`, only when Aviv calls it.

### 3. Propose the outline, then wait
For a new page or a restructure, send an outline (about 40 lines): question(s) (mark your
additions "proposed"), inputs and gaps, sections in order (heading, question, figures), appendix
and what is left out, unexpected findings, hub effect, unclear method details, questions for
Aviv. No result summaries. Write after Aviv approves. Skip for updates that keep the structure.

### 4. Prepare the outputs
Small presentation-only changes to the analysis code are allowed: figures that follow
`self-explanatory-figures`, inline figures saved to file, printed results collected into a CSV
table, figure files below 10 MB. Never change a computation. Commit them in a separate commit
on the analysis branch, by the repo's git rules. Tell Aviv each change. If Aviv is editing the
same files now, list the changes instead of making them.

### 5. Write and publish
- Build tables on the page for numbers that the notebook only prints.
- **Check before you publish:**
  - every step has a Methods toggle that covers the checklist (or "n/a"), each symbol defined,
    each equation linked to its function;
  - each conclusion agrees with the numbers and figures, and is conditional on the open flags
    of its section;
  - the content passes the write checklist in `notion.md` (a failed full write costs a resend).
- Upload figures with `--manifest` (`notion.md`).
- After a create or `replace_content`: fetch once into a working copy and grep it (block order,
  tabs and toggles, image count, no literal `{color=`, `` $` `` or `\{`). After an
  `update_content` with no warnings, do not fetch.

### 6. Iterate
**Before the edit:**
- Fetch the page and read its open comments again. Keep Aviv's edits.
- Choose the edit mode from the change list, before the first edit:

  | Change list has | Edit mode |
  |---|---|
  | Text and table changes only | `update_content`, targeted edits |
  | Any new or changed figure, or a new section | One `replace_content` of the whole page, from one fresh fetch |

  Do not mix the modes: edits made before a `replace_content` are lost. `update_content` cannot
  change images.
- Before a `replace_content`, save the open comments (anchor, text): their anchors can be lost.

**The edit:**
- Edit only new and updated sections. Upload only changed figures (`notion_upload.py --check`);
  unchanged ones keep their fetched `<image source=...>` block.
- Apply every comment item. A structure change needs the outline step only if it changes the
  questions or the section order. Never resolve or answer a comment in Notion.
- Flag fixes: on the Review page, set the status to `fix pending review` with one line (what
  changed, SHA); mark the flag as pending in the page marker line. Never set `resolved`: only
  `project-hub-review` closes flags. A conclusion that uses a flag fix stays conditional on it.
- When results change, update every place that uses them: section, global conclusions,
  short-answer callout, hub (step 7).
- Update the provenance line and add a changelog line (reproducibility toggle).

**Report in chat:** added, changed (and why), removed (and why), flag fixes (and flags touched
but not fixed), each comment (what you did, your answer, or why not), hub changes.

### 7. Update the hub
After each new or updated sub-page. The hub must always agree with its sub-pages.
- Fetch the hub once. Update only the questions that the page answers or whose evidence cites a
  changed section: table row and details (`structure.md`).
- Use the sub-page conclusions and evidence word for word (with sub-agents: their reports).
- **Synthesis rules:**
  - No new claims. Each answer combines sub-page conclusions and links their sections.
  - Standing caveats of a project (e.g. one seed per training run): state once, on the
    provenance line. Don't repeat them per answer, don't downgrade a status for them, don't
    propose them as a next check. A specific, quantified noise concern is fine.
  - If two pages disagree, show both and set the status to `contradicted`. Do not choose one.
  - An answer that uses a flagged result is conditional on that flag.
- Add new leads. A lead that could become a question goes to Aviv as a proposal in chat.
- Update the status block, sub-page list and provenance line (add new sources).
- Edit with targeted `update_content` ("Hub edits" in `notion.md`).
- Report each changed answer or status (old, new, why) and the proposed questions or goals.
