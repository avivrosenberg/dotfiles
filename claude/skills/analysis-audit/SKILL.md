---
name: analysis-audit
description: Independent audit, by sub-agents, of the code that produced a set of analysis results - bugs, data leaks, code that does not match the math, and conceptual errors. Use only when Aviv asks for an audit or a check of an analysis or its results. Do not run it automatically after code changes.
---

# Analysis audit

Aviv checks results, not code. When a set of results looks good to him, he asks for this audit
to confirm that they were produced by correct code.

## Scope

Check that:
- the code has no bugs, for example: shapes and axes, index and join errors, misaligned
  labels, silent NaN drops, off-by-one, wrong run, checkpoint or seed.
- there are no data leaks, for example: overlap of subjects or sessions between train
  and test, fits on all data, repeated samples, wrong filters or groups.
- the implementation exactly matches math of the spec: estimator, `ddof`, weighting,
  resampling unit, null, CI method, multiple comparisons.
- there are no conceptual errors, such as wrong unit of analysis, selection on the
  outcome, a comparison that does not answer the question.

## How

1. Collect the inputs: the spec (with its "Audit focus" section), the code that produced the
   results (`git diff main...<branch>` and the files it imports), run configs, and the figures
   and tables Aviv approved.
2. Split the work by **analysis topic** (one result or one group of results leaning on
   related methods). Start one sub-agent per topic, in parallel. A small analysis needs
   jut one sub-agent.
3. Give each sub-agent: the spec sections for its topic, the code paths, the scope above, and
   the audit focus. **Do not give your own conclusions or a summary of the results**: the
   sub-agent must form its own view.
4. Each sub-agent reports findings as: file:line, the problem, a concrete failure scenario, the
   effect on the results (changes results / cosmetic), and confidence.
5. Verify each finding yourself before you report it: read the code, and run a small check if
   possible. Drop false positives.

## Report

- Per topic: confirmed findings that change results (with the expected effect), then minor ones.
- What the audit covered, in one line per topic.
- Don't fix anything before Aviv decides. Then re-run the affected results and show the before
  and after.
