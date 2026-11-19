---
name: research-methods
description: How to describe a research method - the method text (numbered steps from data to result, with a checklist), the method diagram(s), and method explainers (synthetic examples, method notebooks). Use whenever you write, update or review a description of a method or a method diagram, in a spec, a chat answer, a report, a deck, a hub page or a notebook. It does not decide where the description goes or how that place formats it.
---

# Research methods

A method has two descriptions, and they work together:

- the **text** lets a reader repeat the result;
- the **diagram** lets a reader understand the idea.

The caller decides where the description goes (a spec section, a report toggle, a hub page, a chat answer, a deck), its depth, and its format. This skill says what the description contains.

## Method text

Write it from the code, not from memory or from notebook markdown.

- If the code does not show a detail, write "unknown" and ask Aviv. Never guess.

**Write numbered steps, from the data to the table or figure shown.**

- Each step has an input, an operation and an output.
- The last step makes the result that is shown.
- State each quantity where it is used, with its equation, units and direction (higher = better or closer).
  - Convert if two quantities run in opposite directions (distance and similarity), and say so.

**Checklist.** Cover each item, or write "n/a". The repo's `CLAUDE.local.md` ("Analysis reports") can add items.

- **Data:**
  - the runs (ids, checkpoint or epoch);
  - the split;
  - the cohorts or subsets, with inclusion criteria and filters;
  - the unit of analysis, and the counts at that unit;
  - the representation (e.g. embedding view) and its dimension.

- **Processing:**
  - each filter, rejection rule, normalization, aggregation and matching step, in order;
  - the counts before and after each rejection.

- **Math:**
  - block equations for key quantities, inline math for small ones;
  - each symbol defined where it first appears: what it is, its shape, its index sets
    (e.g. "$X \in \mathbb{R}^{n \times d}$: the test-set sample embeddings, one row per sample");
  - the estimator, not only the quantity (e.g. unbiased MMD, kernel, bandwidth rule);
  - the statistics: the test, the CI method, resamples or folds, seeds.

- **Math to code and data:**
  - the function that implements each equation (`module.py:function`);
  - implementation choices that can change the result (what data a transform is fitted on, how pairs are drawn, how data is weighted);
  - where the code differs from the textbook form, and why;
  - each parameter value, with the reason.

- No copied code blocks.

**Depth.** The caller picks one:

- *Full:* the whole checklist.
- *Brief:* the method in a few lines, the key equation, the data subset and counts, the test and CI method.
- *Plain:* plain words: which data, what was compared with what, how sure we are.

**Layout.**

- One idea per block. If a description is long, split it in parts, each short.
- Bullets, one fact each. A small table only for parameter values or counts.
- A block equation (`$$...$$`) for every equation of more than a few symbols.
  - Define the symbols in short bullets right below it.
  - Inline math only for small expressions and single symbols.
- Explain the math in words too. An example helps.

## Method diagram

The diagram shows how the method works.

- Show the real objects (data, matrices, sets) changing step by step.
- Test: remove the text. The structure must remain. Text in boxes is not a diagram.
- Show the inputs, the steps, the output, and what the key quantity measures.
- A tiny synthetic example helps when it makes the idea clear.
- Each mark and arrow has one meaning. No arrows between everything.
- Use only terms the team uses. Do not invent labels.
- Show the key idea only, so it can be less detailed than the text. It is not a code flowchart.

**More than one diagram** is fine when the method, or one of its steps, is complex or does not fit in one.

- One idea per diagram.
- Split a complex method into 2-3 diagrams, or an overview plus one per complex step.
- Say how they connect.

**Consistent with the text:**

- same symbols, names and wording as the text;
- each step of the diagram appears in the text (the text can have more steps);
- an equation that the diagram shows maps to its box or arrow (say which, e.g. "step 2");
- if they disagree, fix the diagram or the text, and tell Aviv if a saved diagram is wrong.

**Files:**

- Save each diagram of a non-trivial method, once Aviv accepts it:
  - `<repo_out_dir>/<analysis_name>/diagrams/<name>.svg`, and a PNG (`rsvg-convert -w 1800 in.svg -o out.png`);
  - `<repo_out_dir>` is the output root of the repo.
- Reuse a saved diagram. Make a missing one, save it, and tell Aviv.
- A caller that needs a simpler version makes a copy with a prefix that names its use. Keep the original.
- Style: white rounded background (reads on any page background), dark text, at least 14 px at 900 px width.
- Drawing: `artifact-diagramming` (SVG). In the chat: `presenting-results` (`show_widget`).

## Method explainers

Where the method allows it and it is not trivial, show how it works and how it fails.

- Use synthetic data with known ground truth, or theoretical results.
- Produce visuals (figures that go with the method diagram).
- Put them in separate method notebooks, not in the main analysis. The notebook workflow is in `research-collab`.
