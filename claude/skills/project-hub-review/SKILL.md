---
name: project-hub-review
description: Use when Aviv asks to review a project hub in Notion (the hub page and its experiment sub-pages), or one experiment of a project, for correctness, conceptual issues, bugs and wrong conclusions. Trigger on "review the project", "review the project reports", "run a review on the embedding gap experiment", "check the analysis for issues", or "update the review page".
---

# Project hub review

Claude reviews the analysis of a whole research project: the Notion report pages, the code
that makes their results, and the figures. The flags go to one Review page under the project
hub, with markers in the experiment pages. Aviv calls this skill when he has enough results.
It is separate from writing the reports, so that report updates stay fast.

**REQUIRED BACKGROUND:** read the `project-hub` skill first (`SKILL.md` and
`structure.md`, and `notion.md` for the Notion mechanics). It defines the project structure
that this review works on: hub (project), sub-pages (experiments), sections (steps), and the
local and global conclusions.

## Full-project context is the point

Review the scope that Aviv names (default: all experiments), but always load the full project.
The most valuable flags are the ones that no single page shows:
- contradictions between experiments;
- hub questions or goals that no experiment answers, or answers with weak evidence;
- confounds that cut across pages (headset, site, protocol, a single seed, data overlap);
- conclusions that rest on a result that is flagged or contradicted in another page;
- a chain of evidence across pages that has a missing link;
- hub answers that are stronger than the sub-page conclusions they link, that make claims no
  sub-page supports, or that ignore a contradiction or an open flag.

## What to flag

| Flag | Do not flag |
|---|---|
| Conceptual: the analysis does not answer its question; confounds; alternative explanations; a wrong null or control | Code style, docs, naming, conventions, refactors |
| Correctness: math that disagrees with the code; wrong statistics (weights, leakage, pseudo-replication, multiple comparisons, CIs) | Performance, unless it changes a result |
| Bugs that change a result | "Nice to have" analyses, unless a conclusion needs them |
| Conclusions that the results do not support, or that contradict another page | Wording and presentation, unless it misleads |
| Methods that disagree with the code, or that miss a detail a result depends on (data subset, filter, estimator, parameter) | Methods detail that does not change how to read a result |
| Figures or tables that mislead (clipped axes, wrong labels, wrong whisker rule) | |

**Severity:** `breaks` (a conclusion is wrong or unsupported), `weakens` (a conclusion stands,
but with less evidence or a smaller effect), `minor` (no conclusion changes).

## Workflow

### 1. Load the project
- Fetch the hub and every sub-page (all of them, also outside the scope).
- Fetch the Review page if the hub has one. Load its open flags, closed flags and the code
  version of the last run.
- Read the sources in the hub provenance line, and the `.claude/project-hub.md` of each
  analysis repo (see "Repo conventions and project sources" in the `project-hub` skill).
- From each sub-page provenance line, get the notebooks and the repos with their SHAs. Map each
  section to its code: notebooks, analysis modules, shared modules of the analysis repo, and
  the code in the other repos that defines the metrics, data and runs that the results use.
- Record the current SHA of each repo and any uncommitted changes. The review is of this code
  version.

### 2. Check the existing flags
Start with the flags in status `fix pending review`: `project-hub` set them when an update
addressed them, and their details say what changed and at which SHA. Then check the other open
flags. For each open flag of the last run:
- Look at the code since the last-run SHAs (`git -C <repo> diff <sha>`) and at the page.
- **Resolved:** the fix is in the code and the page results come from the fixed code. Move the
  flag to the closed table with how it was resolved (SHA, one line), and remove its marker from
  the experiment pages.
- **Partly addressed:** set it back to `open`, update its text, and remove "fix pending review"
  from its markers.
- **Not addressed:** keep it as it is.
- Flags that Aviv waived stay closed. Do not raise them again, unless new evidence changes
  them (then make a new flag that refers to the old one).

### 3. Review in parallel
Start the subagents at the same time:
- **One subagent per experiment in scope.** Brief:
  - the project context: hub goals and questions, and for each sub-page its question, its
    conclusions and its link (a short summary, not the full pages);
  - the experiment page (URL, or its content), the section-to-code map from step 1, the repo
    paths and SHAs, and the figure files;
  - the open and closed flags of this experiment, so it does not report them again;
  - the "What to flag" table and the severity scale from this skill;
  - small synthetic simulations in the scratchpad are allowed, to size an effect.
- **One cross-cutting subagent.** Brief: the full project context (all pages, all flags), and
  the task to find the project-level issues in "Full-project context is the point". It reads
  code only when it must check a claim.
- **Output of each subagent:** a file in the scratchpad, one entry per issue: title, CONFIRMED or
  PLAUSIBLE, severity, category, location (page and section), evidence (file:line, figure,
  number), effect size, which conclusions change, and a suggested check or fix. Plus a short
  list of what it checked and found correct.

### 4. Merge
- Remove duplicates between subagents and against existing flags.
- Read the cited lines of each flag yourself, to make sure the evidence is real. Drop an item
  only if the evidence is wrong. Do not run a second review.
- **Flag IDs are stable:** new flags get the next free number (F11, F12, ...). Never renumber.

### 5. Write the Review page
Create it under the hub if it does not exist (title "Review", icon ⚑). Content, in order:

1. **Code version** (gray first line): "Reviewed `<repo>@<sha>`, ... (+ local changes, if any)
   on `<date>`. Scope: `<all | experiments>`."
2. **Open flags** table, one row per flag, short cells:

   | ID | Sev. | Category | Where | Issue | Status |
   |---|---|---|---|---|---|
   | F3 | weakens | correctness | Embedding gap, 2 | Null weights differ from IL view | open |

   "Where" links the page (and the section, see below). "Status": `open`, `fix next iteration`,
   `waived` (set by Aviv), or `fix pending review` (set by `project-hub` after an update).
   A new flag starts as `open`.
3. **Closed flags** table: ID, issue, `resolved` or `waived`, how (SHA and one line, or Aviv's
   reason).
4. **Flag details:** one H3 per open flag, `F3. <title>`, with: the evidence (file:line), the
   effect size, the conclusions it changes (with links), and the suggested check or fix.
   CONFIRMED or PLAUSIBLE in the first line.
5. **Run log** (toggle): one line per run: date, SHAs, scope, flags added / resolved.

Keep resolved flag details in a toggle under the closed table, not in the main details.

### 6. Update the markers in the experiment pages
- For each open flag, add or update the marker line at the end of each affected section (format
  in `project-hub/structure.md`, "Flag markers"). One marker line per section, which lists
  all its flags.
- Link each flag ID to its H3 on the Review page. Use a block link (`<page url>#<block id>`)
  when the block id is known; otherwise link the Review page.
- Remove the markers of resolved and waived flags.
- Change only the marker lines. Do not edit the report content: if a conclusion must change,
  that is a flag, and Aviv decides.
- A flag on a hub answer has "Where" = `Hub, Q<n>`. Do not edit the hub: the `project-hub`
  skill updates the "Open flags" of each question on its next hub update. Tell Aviv in the
  report that the hub needs a refresh when flags changed.

### 7. Report, ask about open flags, and propagate
- Tell Aviv in chat: new flags (by severity, `breaks` first), flags resolved, and the most
  important project-level finding.
- **Ask Aviv about each flag that is still open or partly addressed from earlier runs** (not the
  new ones, unless he wants). One line per flag: ID, issue, what is still missing. For each, he
  can keep it `open`, set `fix next iteration`, or **waive** it with a reason.
- Apply his answers: a waived flag moves to the closed table as `waived` with his reason, its
  markers are removed, and future reviews do not raise it again (see step 2).
