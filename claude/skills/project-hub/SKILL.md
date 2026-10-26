---
name: project-hub
description: Use when Aviv asks to track a research project in Notion - a project hub page with the status, research questions, current best answers and evidence, and one sub-page per experiment with full methods and results from his analysis (notebooks, figures, tables, model runs). Trigger on "make a report from notebook X", "put these results in Notion", "update the report with the new figures", "create a sub-page for this experiment", "address my comments on the report", "update the hub", "refresh the project page", "what is the project status", or a pasted Notion link to a project hub or one of its sub-pages.
---

# Project hub in Notion

Claude keeps one place in Notion where all the results of a research project live, in order:
a project **hub page** and one **sub-page per experiment**. Claude writes both from Aviv's
analysis code and outputs.

- **The hub tracks the project:** its status and progress against the goals, the research
  questions, the current best answer to each question, and the evidence for it.
- **The sub-pages are a one-stop shop for one experiment:** all its current methods and results.
  Aviv uses them as a reference (to recall the exact methods) and to scrutinize the results.
  This is why the methods must be complete and exact (see "Methods" in `structure.md`).

The pages are a tool for thinking: they show every result clearly so that Aviv can find issues
and decide how to iterate.

**Ownership:**
- **Claude writes the hub and the sub-pages.** Aviv reviews them and asks for changes.
- **Questions and goals on the hub are Aviv's.** Claude can propose to add, remove or reword a
  question or goal (for example from a lead). Change them only after Aviv approves.
- Aviv's own writeup of the project is not on the hub.

**Audience:** the hub starts private, and Aviv makes it public when the project is mature.
Write every page as if it is public: the team must understand it without the chat context.

## Three levels

| Level | Notion | Owns | Conclusions |
|---|---|---|---|
| Project | Hub page | Context, goals, status, questions with current best answers and evidence, leads | Synthesis: combines the global conclusions of the sub-pages, no new claims |
| Experiment | Sub-page | One main question (or 2-3 linked ones), one setup | Global: answer the experiment question, each citing its sections |
| Step | Section in sub-page | One sub-question or check, one result (1-few figures/tables) | Local: what this result shows |

- Conclusions, unexpected findings and open questions flow up one level: step -> experiment
  ("Other findings", "Open questions") -> hub (leads, candidate questions).
- **Notebooks are not pages.** Notebooks group code for convenience. One sub-page can use
  several notebooks, and one notebook can feed several sub-pages. The notebook order can be a
  good order, but check it: the page order must be logical, each step building on the previous.
- **Page boundary:** one sub-page = one main question with one shared setup (same runs, data,
  method family). If the short-answer callout needs two unrelated paragraphs, split the page. A
  new type of question (for example "what is the gap?" vs "does an intervention close it?") is
  a new page.
- **One page per experiment, updated in place.** Iterations update the existing sub-page. Never
  make a second page for the same experiment.

The page design (hub, sub-page, step block, flags, writing rules) is in `structure.md`. Read it
before you write or restructure a page. The structure is a guideline, not a form: drop or
reshape any part that does not fit the analysis.

Notion mechanics (figure upload, markdown syntax, safe edits) are in `notion.md`.

## Repo conventions and project sources

This skill works in any analysis repo. Two inputs say where the code and outputs are:
- **Repo conventions:** the "project-hub" section of the `CLAUDE.local.md` at the root of each
  analysis repo. It gives the analysis and figure folders, the notebook format, where the runs
  are defined and how to get their metrics, which other repos to record SHAs for, extra items
  for the methods checklist (`structure.md`), and if the repo commits the figure manifests.
  The rest of `CLAUDE.local.md` (environment, notebooks) also applies.
- **Project sources:** the sources in the hub provenance line (`structure.md`): the repos and
  the analysis folders of the project, as repo names and repo-relative paths.

`CLAUDE.local.md` is in the context when its repo is the working directory. For another
analysis repo, read its `CLAUDE.local.md`. If you do not know where that repo is, ask Aviv.
If a repo has no "project-hub" section, find the conventions from the repo (its `CLAUDE.md`,
folder layout and notebooks). Tell Aviv what you found, and get his confirmation before the
first write to Notion. Then propose to add them to its `CLAUDE.local.md`.

## Keep the context small

Each model call reads the full session context again, so the context size times the number of
calls is the main cost and the main delay. Notion calls are fast. Rules:
- **One sub-agent per page when a run touches two or more sub-pages** (see `multi-page.md`).
  For one sub-page, do the work in the main agent.
- **Read large pages from a working copy,** not in full (see "Read pages from a working copy"
  in `notion.md`). Read only the sections you edit.
- **Fetch each page once per edit round.** Do not fetch again to check a write that gave no
  warnings. Fetch again only after a `replace_content`, after warnings, or before the next
  edit round (Aviv may have edited the page).
- **Look only at the figures in scope:** for an update, the new and changed figures only.
  Look at a smaller copy (see step 2).
- **Do not read the Notion markdown spec.** `notion.md` has the format. Read the spec only for
  a block type that `notion.md` does not cover.
- Read notebooks, code and Bash output in parts (grep, offset and limit), not in full, when
  they are large.

## Several pages

When a run creates or updates two or more sub-pages, or in refresh mode ("refresh the hub",
or the sub-pages changed outside this skill), read `multi-page.md` first. It runs one
sub-agent per page.

## Workflow

### 1. Find the inputs
- **Existing page first.** Fetch the hub and look for a sub-page with the same experiment
  question (also an older page in another format). If one exists, this is an update of that
  page (step 6). Make a new page only if no sub-page covers the experiment.
- **New project:** create the hub with the structure in `structure.md`. Propose the context,
  goals and questions to Aviv first, and write them only after he approves.
- **Hub in an older format** (for example a "Writeup" section, or no questions table): do not
  restructure it on your own. Tell Aviv, and restructure only when he asks.
- Sources: the sources in the hub provenance line, and the "project-hub" section of the
  `CLAUDE.local.md` of each analysis repo (see "Repo conventions and project sources").
- Project notes: read them only if Aviv points to them.
- Code: the analysis folder. Read the notebooks and the supporting modules that they import.
  If the notebooks are paired with scripts (for example jupytext), read the script for code
  and markdown, and the notebook for outputs.
- Outputs: saved figures (the conventions give the folder), printed numbers and tables in the
  notebook outputs. To get inline-only figures and printed outputs of a `.ipynb` quickly:
  `python3 -I scripts/extract_nb_outputs.py <notebook.ipynb> <out_dir>` (in this skill folder).
- Runs: the model runs that the analysis uses. The conventions say where they are defined and
  which tool gets their metrics.
- Versions: the git SHA of each repo that the analysis uses (`git -C <repo> rev-parse --short
  HEAD`), and whether the working tree has changes.
- **Check that the inputs are complete and current:**
  - notebooks with no saved outputs, or runs that cover only part of the planned cells;
  - figures older than the code that makes them (compare the file date with the last commit
    of the code), or figures that the current code no longer makes;
  - results that Aviv marked as work in progress (WIP). WIP results stay off the page, even if
    outputs exist. The page lists them as pending in "Open questions".

### 2. Understand the results
**Scope.** For a new page, read the full analysis. For an update, work on the delta only.

**Find the delta (updates):**
1. Fetch the current page: its sections, results, flag markers and the SHAs in the provenance
   line. If the page has markers, also fetch the project Review page and read the details of
   those open flags.
2. Diff the code since those SHAs: `git -C <repo> diff <sha> -- <analysis folder> <imported
   modules>`, plus uncommitted changes. Compare the figure files and notebook outputs with the
   results on the page.
3. Make a **change list**. Each item is a **new result** (not on the page), an **updated
   result** (code or output changed), or **unchanged** (keep it on the page as it is).
4. **Flag fixes.** For each open flag on the page, check if the diff addresses it: does the
   change do what the flag's suggested fix asks, in the code that the flag cites? Add each such
   flag to the change list as a **flag fix**, with one line on what changed. This is a quick
   check, not a review.
5. **Comments.** Aviv leaves comments on the page for what he wants changed. Read all open
   comments before you plan the update (see "Comments" in `notion.md`). Add each one to the
   change list as a **comment**: its anchor (section, and the text or figure it is on) and the
   change it asks for. A comment that asks a question, not a change, gets an answer in the chat
   report. A comment you cannot interpret goes to Aviv as a question before you write.
   Comments can also come with no code change: then the comments are the whole change list.

**Read:**
- Read the implementation of the items in scope, not only the notebook markdown: the notebook,
  the analysis modules, and the shared code that loads and filters the data or computes the
  metrics (in the analysis repo and in the other repos that its conventions list). The
  methods and math on the page must describe what the code does. Collect each item of the
  methods checklist (`structure.md`) for each step. Ask about unknown details in the outline
  or the chat report.
- Look at every figure in scope. Read a smaller copy in the scratchpad, not the original:
  `sips -Z 1000 "<figure>.png" --out "<scratchpad>/fig/<name>.png"` (long side 1000 px; use the
  original only if small text is not readable). Write down what it shows before you read
  Aviv's markdown about it.
- If you see an obvious problem (a number that disagrees between outputs, a broken figure),
  tell Aviv in chat. Do not do a full correctness review: that is the separate
  `project-hub-review` skill, which Aviv calls when he wants it.

### 3. Propose the outline, then wait
Before you write a new page, or restructure an existing one, send Aviv a short outline (about
40 lines). It has these parts, in this order:
1. **Question(s).** Mark any sub-question or framing that you add as "proposed".
2. **Inputs:** notebooks, runs, SHAs, and the gaps from step 1 (partial runs, stale figures,
   WIP).
3. **Sections in order:** heading, the question or check it answers, its figures/tables.
4. **Appendix:** what goes there, and what is left out (with the reason).
5. **Unexpected findings.**
6. **Hub effect:** the hub questions that this page answers or changes.
7. **Method details that are not clear** from the code.
8. **Questions for Aviv:** only decisions that change the page.

No result summaries in the outline: results go on the page. Write the page only after Aviv
approves the outline. For an update that keeps the structure, skip this step.

### 4. Prepare the outputs (small code changes are allowed)
You may change the notebook or analysis code a little, to make the outputs fit for the page:
- clearer axis labels, legends and figure titles;
- save to file a figure that is only inline in the notebook;
- collect results from several cells into one table and write it to CSV;
- make figures smaller or lower dpi so each file is below 10 MB.

Only presentation changes: never change a computation. Do not commit, unless Aviv asks. Tell
Aviv each change. If the working tree has changes, the provenance line says so. If Aviv is
working in the same files at the moment, list the changes instead of making them.

### 5. Write and publish
- Write the page with `structure.md`.
- **Make tables for results that the notebook only prints.** If the notebook gives the numbers
  but no table (for example printed values over several cells), build the table on the page.
- **Methods check before you publish:** each step has its Methods toggle, and the toggle covers
  every item of the methods checklist in `structure.md` (or says "n/a"). Each symbol is defined.
  Each equation names the function that implements it.
- **Consistency check before you publish:** each conclusion must agree with the numbers and
  figures on the page, and with the open flags of its section (flag markers). A conclusion that
  depends on an open flag is conditional or a hypothesis.
- Upload figures with `--manifest` (see `notion.md`). Create the page under the hub, or update
  the existing page.
- **Before the write call, check the content against the write checklist in `notion.md`.** A
  failed write of a full page costs a second full send.
- After a create or a `replace_content`, fetch the page once into a working copy and check it
  with grep, not by reading it in full: the outline (block order, tabs and toggles), the
  number of images, and no literal `{color=`, `` $` `` or `\{` (fix them before you report).
  After an `update_content` with no warnings, do not fetch.

### 6. Iterate
- Before each update, fetch the page and read its open comments again (step 2, item 5). Keep
  Aviv's edits.
- **Apply every comment item of the change list.** A comment that asks for a change of
  structure (move, split or merge sections, a different layout) needs the outline step (step 3)
  only if it changes the questions or the section order; a layout change of one figure or
  table does not.
- **A `replace_content` makes new blocks, and comments anchored to old blocks can be lost.**
  Before a `replace_content`, save the list of open comments (anchor and text) for the chat
  report.
- Never resolve or answer a comment in Notion. Aviv resolves them after he checks the change.
- Use the change list from step 2: edit the sections of new and updated results. Leave
  unchanged sections as they are.
- **Choose the edit mode from the change list, before the first edit:**

  | Change list has | Edit mode |
  |---|---|
  | Text and table changes only | `update_content`, targeted edits |
  | Any new or changed figure, or a new section | One `replace_content` for the whole page, built from one fresh fetch |

  Do not mix the two modes in one update: text edits made before a `replace_content` are lost
  work. `update_content` cannot change images (see `notion.md`).
- **Upload only the figures that changed:** run `notion_upload.py --check` on the figures of
  the page (see `notion.md`). Unchanged figures keep their fetched `<image source=...>` block.
- **Flag fixes from the change list:** on the Review page, set the flag status to `fix pending
  review` and add one line to its details: what changed, at which SHA. In the experiment page,
  mark the flag in its marker line as pending (format in `structure.md`). Never set a flag to
  `resolved`: only `project-hub-review` closes flags, after it checks the fix.
- A conclusion that a flag fix changes can use the new results, but it stays conditional on the
  flag until the review closes it.
- When results change, update every place that uses them: the section, the global conclusions,
  the short-answer callout, and the hub (step 7).
- Update the provenance line (SHAs, date) and add a line to the changelog (in the
  reproducibility toggle).
- **Report the change to Aviv** in chat, so he knows what to look at:
  - **Added:** new sections, figures, tables (with section names).
  - **Flag fixes:** flags set to `fix pending review`, and flags that the update touches but
    does not seem to fix.
  - **Changed:** results, conclusions or text that changed, and why.
  - **Removed:** what was removed or moved to the appendix, and why.
  - **Comments:** each open comment (anchor, text), with what you changed for it, your answer
    if it asked a question, or why you did not change it. Aviv uses this list to resolve the
    comments.
  - **Hub changes** (from step 7).

### 7. Update the hub
Do this after each new or updated sub-page. The hub must always agree with its sub-pages.
- Fetch the hub (once per run). Find the questions that the sub-page change affects: the
  questions that the page answers, and the questions whose evidence cites a changed section.
- **Source of the hub content:** the sub-page you just wrote, or, with sub-agents, their
  reports (`multi-page.md`). Use the conclusions and evidence word for word.
- For each affected question, update its table row and its details section (format in
  `structure.md`): answer, status, evidence links, evidence for and against, open flags, next
  check. Change only the affected questions.
- **Synthesis rules:**
  - No new claims on the hub. Each answer combines the global conclusions of the sub-pages,
    and links the sections that support it.
  - The strength of the words must agree with the evidence: "reduces", not "removes"; "is
    consistent with", not "shows", when other explanations are open.
  - If two pages disagree, show both, and set the status to `contradicted`. Do not choose one.
  - An answer that uses a flagged result is conditional on that flag.
- Add new leads (unexpected findings and open questions of the sub-page). A lead that could
  become a project question goes to Aviv as a proposal in the chat report, not on the hub.
- Update the status block and the sub-page list, and the provenance line of the hub (add a
  source if the sub-page uses a new repo or analysis folder).
- Edit the hub with targeted `update_content` (see "Hub edits" in `notion.md`).
- **Hub changes** for the chat report: each answer or status that changed, the old and the new
  text, and why. Also the proposed new questions or goal changes.
