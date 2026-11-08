---
name: socratic-collab
description: Socratic collaboration on core algorithmic code. Aviv writes the conceptually key functions, Claude writes the rest plus a test notebook. Use when Aviv asks for a plan to implement research or scientific code (a method, algorithm, model or analysis with core math). Include the offer in the plan. Skip if Aviv says "no Socratic". Works together with scientific-python and research-collab.
---

# Socratic collaboration on technical or scientific code

Goal: maximize Aviv's expertise and keep him in the loop on the most important and
interesting parts of the code.

## When to use

- Aviv asks you to make a plan to implement research or scientific code.
- The plan has a core algorithmic part: a method, a model, a metric, a transform with
  non-trivial math.
- Do not use for plumbing only: data loading, config, plotting, file I/O, CLI wrappers.
- If Aviv says "no Socratic": do not offer it, and leave it out of the plan.

## Related skills

- `scientific-python`: load it before you write ANY Python or notebook code, including the
  boilerplate, placeholders and the test notebook. Aviv's own code follows the same rules
  when you review it.
- `research-collab`: the spec says what and why. This skill changes who writes the core code
  in the implement step. Do not repeat spec work here.
- `presenting-results` and `self-explanatory-figures`: use them for the test notebook figures.

## In the plan

Add a section "Socratic collaboration" to the plan, so Aviv can choose which parts to take,
or skip it completely. In it:

- List the functions that are core (candidates for Aviv).
- List the functions that are tedious (you write them).
- List the steps below, each marked as optional.

```
plan -> Socratic questions -> Aviv's method notes -> you: boilerplate + test notebook
                                                         |
     review <- Aviv writes core functions <- guidance on request (levels)
```

## Steps

### 1. Socratic questions

- Ask 2-3 questions about the method.
  - Questions designed to make Aviv think clearly about the method, not a quiz.
  - Example topics: what the method assumes, what happens in a limit or edge case,
    what a wrong result looks like, why this step and not an alternative.
- Offer Aviv to write the method explanation and the core math first. Then review it:
  check the math, ask about gaps, challenge it.
- Later, base the function docstrings on his framing and explanations, not on yours.

### 2. You implement

- **Boilerplate**: key function signatures with placeholder implementations (a starting
  point Aviv can change). Wire the inputs into them.
- **Split of work**: leave the conceptually meaningful functions for Aviv. Implement the
  tedious ones yourself.
- **Test harness**: a way for Aviv to test his code. Prefer a notebook with figures. One
  notebook can cover several things.
  - Use real data, simulated data with known ground truth (including failure cases), or both.
  - Figures must make wrong output obvious.
  - The notebook tells Aviv what it does and suggests which results to predict before he runs
    it, with useful hints and guides.

### 3. Guidance on request

Give help in levels. Start with the lowest level. Go to the next level only if Aviv asks
again or says he is stuck.

1. Guiding question.
2. Location: where the problem is.
3. Fix.

### 4. Review

- After Aviv is done, review for correctness: math vs code, shapes, edge cases, the failure
  cases in the test notebook.
- Do not rewrite his code unless asked explicitly: by default, point to issues and suggest changes.
