# Several pages: one sub-agent per page

Read this file when a run creates or updates two or more sub-pages, or in refresh mode. The
main agent coordinates, and each sub-page gets its own sub-agent with a clean context.

## Main agent

- Fetches the hub once. It does not fetch the sub-pages: each sub-page is fetched only by its
  sub-agent.
- Makes the page list from Aviv's request and the code diff (step 1).
- Briefs one sub-agent per page. Use the same model as the main agent (writing exact methods
  and conclusions is the hard part; do not use a cheaper model). The brief has:
  - the instruction to follow this skill (`SKILL.md`, `structure.md`, `notion.md`) for one
    page, steps 1 to 6, and not to edit the hub;
  - the page URL (or "new page under the hub", with the hub id), the analysis folder, the
    notebooks, the repos and the SHAs to diff from, and the repo conventions (the
    "project-hub" section of each `CLAUDE.local.md`, word for word);
  - the hub questions that this page answers (their text and current answer), and the
    Review page URL if it exists;
  - Aviv's request for this page, word for word;
  - the report format below.
- **Serial or parallel:** serial is the default. Run sub-agents in parallel only if their pages
  share no notebooks or analysis files (step 4 can change them), and no page cites a result
  that another page in the run changes. Writes to different Notion pages do not conflict.
- **Outline step:** a sub-agent cannot ask Aviv. It stops after step 3 and returns its outline
  and questions. The main agent shows them to Aviv, then continues the same sub-agent
  (`SendMessage`) with his answer, word for word.
- After all sub-agents return: update the hub (step 7) from their reports only. If a report
  does not give the evidence for a conclusion, ask that sub-agent (`SendMessage`), do not fill
  it in yourself. Then relay each page report to Aviv without shortening it, plus the hub
  changes.

## Sub-agent report

The main agent updates the hub from this report alone, so it must be complete; the main agent
cannot see the page.
1. **Page:** title, URL, provenance line (SHAs, date).
2. **All global conclusions, word for word as on the page,** each with:
   - its evidence: the sections that support it (section number, heading and block link if
     known), and the key numbers with their noise floor or null;
   - the evidence against it or the open alternatives, as the page states them;
   - the flags it depends on ("conditional on F3"), and whether it is a hypothesis;
   - the hub question(s) it bears on, and whether it changed in this run (old text if so).
3. **The short-answer callout,** word for word.
4. **Other findings and open questions** (candidate leads), with their section links.
5. **The change report** from step 6: added, flag fixes, changed, removed, and every comment
   (anchor, text, what changed or the answer).
6. **Checks:** the post-write checks and their results (image count, outline, grep for
   literal format errors), the method details that are still unknown, and any problem seen.

Do not summarize or soften the conclusions in the report: the hub must keep the exact claim
strength of the page.

## Refresh mode

"Refresh the hub", or when the sub-pages changed outside this skill: rebuild the questions
table and the details from the current conclusions and flags of all sub-pages. Use one
read-only sub-agent per sub-page: it fetches its page and returns items 1-4 of the sub-agent
report, and does not edit the page. The main agent fetches the hub and the Review page. Report
the hub changes as in step 7.
