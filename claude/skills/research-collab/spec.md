# Spec template

Concise: bullets, short sentences, math where it defines the method. No code design.

```markdown
---
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [spec, <topic>]
project: <link to the project record>
analysis: <name>            # analysis folder and branch aviv/<name>
status: draft | approved YYYY-MM-DD
---

# <Name>: spec

## Question
- The research question, in 1-3 lines. Why it matters (which decision it informs).

## Background
- Only what an implementer needs: prior results (with links), known facts about the data.

## Hypotheses and predictions
- Each hypothesis, and what each planned output shows if it is true or false.
- "No effect" outcomes that are valid results.

## Data
- Models and runs (names, ids, checkpoints), inputs and representations.
- Groups and inclusion criteria, filters.
- Units of analysis and expected counts.
- New runs needed (what they must produce).

## Methods
- Each step: what is computed, on which data, with the math.
- Statistics: the test, the null, the CI method, resampling unit, multiple-comparison handling.
- Leakage controls: what must stay separate (subjects, sessions, train and test).

## Validation
- Known-answer checks (synthetic data with ground truth, positive and negative controls).
- Method explainer figures, if the method is not trivial.

## Outputs
Numbered list, in the order of the results review. For each:
- The figure or table, and what it shows.
- Expected look if the hypothesis holds, and what a wrong or buggy result would look like.

## Audit focus
- The specific risks an audit must check for this analysis.

## Open questions

## Changes
- YYYY-MM-DD: what changed and why.
```
