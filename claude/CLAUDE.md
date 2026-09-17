## Writing code

These guidelines are mainly for python.

### Comments

- ABOVE ALL:
  - Don't be verbose. Prefer concise language.
  - Don't explain the context beyond what that code does, e.g. don't mention details 
    planning or previous approaches.
  - Avoid long prose paragraphs in docstrings. Use bullet points or numbered lists
    for clarity, especially for arguments.

- Docstrings should be self-contained and not require external context to understand
  (beyond standard project knowledge).
  
- Use Google-style docstrings, but no need to surround variable/function names with
  double backticks (``) in the docstrings, single is enough.

- Don't use an em/en dash, e.g. — or any other non-keyboard chars (both for code and
  comments).

- Add inline comments around key algorithmic logic (calculations, reshapes,
  aggregations, etc) that explains what is going on in simple terms.

- Add comments that detail the expected shapes of tensors and ndarrays, e.g. `# (N,D,E)`
  where it's clear what each dimension represents.

- Add docstrings to functions explaining all arguments.

- In docstrings, keep the description about the function, what it does and how. Don't
  explain the external context, e.g. why it's there, unless it's very specific to a
  certain analysis.

- Include math in docstrings where appropriate, using LaTeX syntax.


### Arguments and variables

- Always use type hints for function arguments and return values.

- Also use type hints in the body of a function, when a variable type might be unclear.

- Use informative variable names, and avoid abbreviations unless they are very common
  (e.g. `df` for dataframe). Avoid e.g. `sm` instead of `subject_mask`, etc.

### Design

- Functions should do one thing and do it well. Avoid functions that
  `do_this_and_that()`, break them into smaller composable functions with useful and
  robust public APIs.

- Use a composable design with general-purpose functions and classes that can be reused
  in different contexts.

- In notebooks, prefer short cells that do one thing (define a function, configure
  consts, create a plot, etc). Keep notebook-specific configuration and plotting code in
  the notebook, while preferring to implement the core logic in separate modules.

- When writing functions in a notebook, avoid using global variables (except CONSTS).
  Pass all required data as function arguments, and return the results.

### Other

- Proactively add `assert` statements to check for invariants and other sanity
  conditions, for example: array shapes, number of dimensions, non-empty data,
  non-constant data, existence of NaNs, sane data ranges, etc.
