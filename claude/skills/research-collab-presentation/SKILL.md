---
name: research-collab-presentation
description: Build or update a presentation (slide deck) for a team or other audience from the results of a research project, finished or work in progress. Asks Aviv for the audience, the detail level and the main message first, then picks the subset of results from the project's local reports and hub, and writes slides with a finding as title, a figure or diagram, and a hidden Methods section. Output format is a separate part: Notion (page with "---" slides) or local HTML slides. Use when Aviv asks for a presentation, deck, slides or talk about a project or analysis, asks to update a deck, or asks how to present results.
---

# Research-collab presentation

A deck that leads one audience from a question to the results of a project, with a selected
subset of its results. The reports hold everything; the deck holds only what the message needs.

**This core is format-agnostic.** Each output format has its own file (see "Formats").

- Audience, detail level, the message, choice of results: `planning.md`.
- Slide types, layout rules, Methods section, diagrams, writing, checks: `slides.md`.
- Formats: `format-notion.md`, `format-html.md` (with `deck-template.html`).
- Methods checklist: `../research-collab-report/report.md` ("Methods").
- Figures: `self-explanatory-figures`.
- Writing: Adhere to main `CLAUDE.md`.

## Ownership

- Aviv owns the framing and the conclusions. He writes the first 2-3 sentences of the
  message. Claude challenges and refines them with him.
- Claude drafts the outline and the deck. Aviv approves. Slide titles are claims, and
  his OK of the outline is his OK of those claims, at the strength written there.
  Do not write a claim that is not in the approved outline, or stronger than the reports
  support.
- A result that Aviv marked WIP, or that the reports mark as not checked, goes in the deck only
  tagged "WIP", if agreed in the outline.
- The deck should have no reference to the chat that produced it - it should be stand-alone.
- Planning words stay out of the deck. "Narrative", "story", "storyline", "arc" are for
  planning only. The deck uses plain scientific wording (`slides.md`, "Writing").

## Inputs

- The analysis index (`<repo_out_dir>/<analysis_name>/reports/index.html`) and the reports it links: first source for results,
  figures, methods, diagrams and agreed conclusions. Each report has provenance SHAs.
- The hub in Notion and its sub-pages, if they exist (`project-hub`).
- The spec and the project note in the agent vault (motivation, decisions, who asked).
- Method diagrams: `<repo_out_dir>/<analysis_name>/diagrams/*.svg`, made in the `research-collab` or
  `research-collab-report` stage. Reuse them.
  - A method that needs a diagram and has none: make it now (`slides.md`, "Diagrams").
- Repo conventions: "Analysis reports" in the repo `CLAUDE.local.md`.

The project does not need to be completed before it is presented. For work in progress
the deck says what is known, what is not, and the next step. Never invent an ending.

## Workflow

```
1 inventory -> 2 audience + detail level + format -> 3 Aviv writes the message
-> 4 refine together -> 5 outline (wait for OK) -> 6 visuals -> 7 write -> 8 update
```

### 1. Inventory
- Read the index, then each report. Check each against its code (provenance SHAs, `git diff`).
  Stale reports and WIP results stay out until Aviv decides.
- Make an inventory table in the scratchpad: one row per candidate result (report, step, the
  finding in one sentence, figure, diagram if any, maturity: agreed / discussed / not discussed
  / WIP). Look at the figures you may use. Collect the data counts for the data slide.
- Do not propose a message or an order yet.

### 2. Ask: audience, detail level, format
Before any planning, ask in one message (use `AskUserQuestion`; the options are in
`planning.md`, "Audience and detail level"):
- **Audience** and what they know already.
- **Detail level** (follows from the audience, Aviv can override): high-level, technical,
  or research team.
- **Output format:** Notion, local HTML. 
- Time, and the purpose (inform, get feedback, get a decision).

### 3. Ask: define the message
Ask Aviv to write 2-3 sentences: the main message, why it matters to this audience, and what he
wants them to decide or think. To support this, show the inventory as a compact table (one line
per result, no ranking, no proposed order). Do not suggest a message.

### 4. Refine together
Work from his sentences. Challenge them (is it supported by the inventory, what would the
audience ask, is it one message or two). Check
which results are key evidence. Show where the inventory has no support for a sentence,
and where it has strong results that his sentences leave out. Iterate until he says the
framing is right.

### 5. Propose the outline
Use the outline format in `planning.md`. Send only the outline.
Wait for approval before writing the actual deck.

### 6. Prepare the visuals
- Reuse report figures and diagrams. Make a presentation variant only if a figure cannot be read
  at slide size (`slides.md`, "Figures").
- Draw missing diagrams. Look at every image at slide size.

### 7. Write
- Write the slides with `slides.md` and the format file. Run the checks of both.
- Tell Aviv: where the deck is, the slide list, what was left out, open questions. Record the
  deck in the project note (`agent-vault`).

### 8. Update
The deck changes with the project. When Aviv asks, or after new reports:
- Read the current deck and its comments (if the format has them). Keep Aviv's edits.
- Make a change list: slides to add, update, move, cut. If a new result changes the message,
  go back to step 4 with Aviv.
- A slide whose result changed: update title, figure, observations and Methods together, then
  the findings slide and the summary slide.
- Update the provenance (reports and SHAs) and the status line.

## Formats

| Format | File | Notes |
|---|---|---|
| Notion | `format-notion.md` | Default when Aviv says Notion. Uses `../project-hub/notion.md` for mechanics. |
| Local HTML | `format-html.md`, `deck-template.html` | reveal.js (library). Methods are vertical sub-slides. |

Aviv names the format, or the skill asks (step 2). For a format with no file (for example Google
Slides): tell Aviv, and offer to add the file. Prepare the content with this core (outline,
slides as title, visual, bullets, Methods text, diagram files), so that only the last step is
missing. A new format file must define:
- how slides are separated, and how images and diagrams are placed;
- the Methods: how they stay out of sight until needed, and how a long one is split;
- where the deck lives, how it is created and updated, and what carries over on an update;
- the format-specific checks.
