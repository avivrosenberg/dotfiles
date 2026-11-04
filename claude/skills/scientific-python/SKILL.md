---
name: scientific-python
description: Aviv's rules for writing Python code, including Jupyter notebooks - scientific code style, type hints, naming, design, docstrings, comments and asserts. Use before you write or change any Python code or notebook code, also small edits.
---

# Writing Python code

These rules apply to Python code and to Jupyter notebooks. Follow them STRICTLY.

## Technical and scientific code

- Implement scientific code in a very clean and simple way.
- Write in a way that teaches the reader how the algorithm works. This does NOT mean trivial or
  naive implementations.
- Always write vectorized code when possible.
- For algorithms with embarrassingly parallel steps, split the inner logic into a function and
  run it in parallel. Prefer `joblib` if available, otherwise `multiprocessing`.
- Add 1-2 line comments above key algorithmic steps that explain in simple terms what happens:
  filtering, calculations, reshapes, aggregations, etc.
- Add inline comments with the expected shapes of tensors and ndarrays, e.g. `# (N,D,E)`, where
  it is clear what each dimension is.
- Use meaningful variable names that map to key concepts.
- Explain parameter value choices.

## Arguments and variables

- ALWAYS use type hints for function arguments and return values.
- Also use type hints in the function body when a variable type might be unclear.
- Use informative variable names, even if they are 2-3 words. Avoid abbreviations unless they
  are very common (e.g. `df` for dataframe). E.g. `subject_mask`, not `sm`.
- Name dataframes with a `df_` prefix.

## Design

- Functions do one thing and do it well. Avoid functions that `do_this_and_that()`: break them
  into smaller composable functions with useful and robust public APIs.
- Use a composable design with general-purpose functions and classes that can be reused in
  different contexts.
- In notebooks, prefer short cells that do one thing (define a function, configure consts,
  create a plot, etc).
- Keep notebook-specific configuration and plotting code in the notebook. Implement the core
  logic in separate modules.
- When you write functions in a notebook, avoid global variables (except CONSTS). Pass all
  required data as function arguments, and return the results.

## Docstrings and comments

- Always write docstrings with ASD-STE100 guidelines.
- Docstrings are self-contained and need no external context (beyond standard project
  knowledge):
  - Don't include context from outside the code (e.g. from the chat). Docs describe the code
    only.
  - Don't explain context beyond what the code does, e.g. no planning details or previous
    approaches.
- Use Google-style docstrings. Single backticks around variable and function names are enough
  (no double backticks).
- Don't use an em or en dash, or any other non-keyboard character (code and comments).
- Include math in docstrings where appropriate, in LaTeX syntax.

## Asserts

- Proactively add `assert` statements to check invariants and sanity conditions, for example:
  array shapes, number of dimensions, non-empty data, non-constant data, NaNs, sane data ranges.

## Shell and scripts

- Put file and directory paths in bash commands in double quotes.
- Prefer `git -C "<path>"` instead of `cd "<path>" && git ...`. Check `git status --short`,
  not only `git log`.
- Ad hoc Python scripts with `multiprocessing`: always put the Pool code under
  `if __name__ == "__main__":` (macOS uses `spawn`; without the guard it is a silent
  process-spawn bomb).
- Background scripts: attach a kill-after-N-seconds safety net, and use `python -u` or
  `PYTHONUNBUFFERED=1`. No output from a buffered process does not mean no progress.
- To verify a small fix in a slow notebook or script, test the changed logic in isolation on
  existing intermediate outputs. Do a full re-run only after a batch of related changes. Ignore
  warnings that don't affect correctness.
