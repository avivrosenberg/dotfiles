---
name: research-collab-presentation
description: Build or update a presentation (slide deck) for a team or other audience from the results of a research project, finished or work in progress. Asks Aviv for the audience, the detail level and the main message first, then picks the subset of results from the project's local reports and hub, and writes slides with a finding as title, a figure or diagram, and a hidden Methods section. Output format is a separate part: Notion (page with "---" slides) or local HTML slides. Use when Aviv asks for a presentation, deck, slides or talk about a project or analysis, asks to update a deck, or asks how to present results.
---

# Research-collab presentation

A deck that leads one audience from a question to the results of a project.

- It holds a selected subset of the results.
- The reports hold everything. The deck holds only what the message needs.
- This core is format-agnostic. Each output format has its own file.

Files:

- Audience, detail level, message, sections, choice of results: `planning.md`.
- Slide types, layout, Methods, diagrams, writing, checks: `slides.md`.
- Formats: `format-notion.md`, `format-html.md` (with `deck-template.html`).
- Methods and method diagrams: `research-methods`.
- Figures: `self-explanatory-figures`.
- Writing: Adhere to main `CLAUDE.md`.

## Ownership

- Aviv owns the framing, the conclusions and the interpretations.
  - He writes the first 2-3 sentences of the message.
  - Claude challenges and refines them with him.

- Claude or Aviv draft the outline and the deck. Aviv approves.
  - Slide titles are factual observations from the results shown.
  - Aviv OKs the outline, the titles and sections, at the strength written there.
  - Do not write a title that is not in the approved outline, or stronger than the reports support.

- State facts only.
  - Add conclusions and interpretations only after Aviv states them.

- A WIP result goes in the deck only tagged "WIP", if agreed in the outline.
  - WIP = Aviv's mark, or a report that is not checked.

- The deck is stand-alone.
  - No reference to the chat that produced it.
  - No planning words ("narrative", "story", "storyline", "arc").

## Inputs

- The analysis index (`<repo_out_dir>/<analysis_name>/reports/index.html`) and the reports it links.
  - First source for results, figures, methods, diagrams and agreed conclusions.
  - Each report has provenance SHAs.
- The Notion hub and its sub-pages, if they exist (`project-hub`).
- The spec and the project note in the agent vault (motivation, decisions, who asked).
- Method diagrams: `<repo_out_dir>/<analysis_name>/diagrams/*.svg`.
  - Reuse them. Make a missing one (`research-methods`, `slides.md` "Diagrams").
- Repo conventions: "Analysis reports" in the repo `CLAUDE.local.md`.

The project need not be finished.

- For work in progress, the deck says what is known, what is not, and the next step.
- Never invent an ending.

## Workflow

```
1 inventory -> 2 audience, level, format -> 3 Aviv writes the message -> 4 refine
-> 5 outline with sections (wait for OK) -> 6 visuals + review page -> 7 write -> 8 update
```

1. **Inventory.**
   - Read the index, then each report. Check each against its code (provenance SHAs, `git diff`).
   - Stale reports and WIP results stay out until Aviv decides.
   - Make a table in the scratchpad, one row per candidate result: report, step, finding
     in one sentence, figure, diagram, maturity (agreed / discussed / not discussed /
     WIP).
   - Look at the figures. Collect the data counts.
   - Do not propose a message or an order yet.

2. **Ask** in one message (`AskUserQuestion`; options in `planning.md`):
   - audience, and what they know;
   - detail level (Aviv can override);
   - output format (Notion or local HTML);
   - time, and purpose (inform, get feedback, get a decision).

3. **Ask Aviv to write 2-3 sentences:**
   - the main message;
   - why it matters to this audience;
   - what he wants them to decide or think.

   Show the inventory as a compact table (no ranking, no order). Do not suggest a message.

4. **Refine together.**
   - Challenge his sentences: supported by the inventory? What would the audience ask? One message or two?
   - Show where the inventory does not support a sentence.
   - Show strong results that his sentences leave out.
   - Iterate until he says the framing is right.

5. **Outline:** use the format of `planning.md` (sections, then slides).
   - Send only the outline.
   - Wait for approval before you write the deck.

6. **Visuals.**
   - Reuse report figures and diagrams.
   - Make a slide variant only if a figure cannot be read at slide size.
   - Draw missing diagrams. Look at every image at slide size.
   - Show all planned visuals on one numbered review page (`planning.md`, "Visual review").

7. **Write** with `slides.md` and the format file. Run both checks.
   - Tell Aviv: where the deck is, the slide list, what was left out, open questions.
   - Record the deck in the project note (`agent-vault`).

8. **Update** when Aviv asks, or after new reports.
   - Read the current deck and its comments. Keep Aviv's edits.
   - Make a change list: add, update, move, cut.
   - If a new result changes the message, go back to step 4.
   - A slide whose result changed: update title, figure, observations and Methods together.
   - Then update the findings and summary slides, the provenance and the status line.

## Formats

| Format | File | Notes |
|---|---|---|
| Notion | `format-notion.md` | Default when Aviv says Notion. Mechanics: `../project-hub/notion.md`. |
| Local HTML | `format-html.md`, `deck-template.html` | reveal.js. Methods are vertical sub-slides. |

For a format with no file (e.g. Google Slides): tell Aviv, and offer to add the file.

- Prepare the content with this core, so that only the last step is missing.
- A new format file defines:
  - how slides are separated, and how images are placed;
  - how Methods stay out of sight, and how a long one is split;
  - where the deck lives, how it is created and updated, and what carries over on an update;
  - the format-specific checks.
