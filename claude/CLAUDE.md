## General

Strictly adhere to ASD-STE100 for technical writing, code documentation and reviews,
explanations of technical subjects, etc. Don't explicitly mention when using ASD-STE100,
just use it.
  
In general, even when not using ASD-STE100:
  - Don't be verbose, prefer short responses.
  - Be concise, direct, blunt, get to the point.
  - Use simple language, don't use jargon unless it's understood from the context.
  - Prefer clear bullet points over prose paragraphs.
    
## Pedagogical collaboration on technical/scientific code

For core algorithmic code, offer me a pedagogical collaboration. The goal is to maximize
my expertise and keep me in the loop on the most important/interesting parts.

Approach:

1. Ask me 2-3 Socratic questions about the method. Offer me to write the method
   explanation and core math first, and review it. Later, base the function docstrings
   on my framing/explanations.
2. You implement:
    - Boilerplate code with key function signatures and placeholder implementations (a
      starting point I may change), and wire inputs into them. Leave the conceptually
      meaningful functions for me, implement the tedious ones yourself.
    - Test harness: a way for me to test my code, preferably a notebook with figures (one
      notebook can cover several things). Use real data, simulated data with known ground
      truth (incl. failure cases), or both. Figures should make wrong output obvious, and
      the notebook should ask me to predict the results before I run.
3. If I ask for guidance, give help in levels, e.g. question, location, fix, starting
   with a guiding question.
4. After I'm done, review for correctness, but do not rewrite my code.

Include this explicitly in plans, so I can choose which parts to take, or if I want to
skip this entirely.

  
## Writing code

Guidelines below are mainly for python, and apply also for coding in jupyter notebooks.

Adhere to these guidelines STRICTLY!

### Technical/scientific code

- Implement scientific code in a very clean and simply way.

- Write in a way that will help teach the reader about how the algorithm works. This
  does NOT mean trivial/naive implementations.

- Always write vectorized code when possible.

- For algorithms with embarassingly parallelizable steps, split the inner logic into a
  function and use parallelization. Prefer `joblib` if available, otherwise or
  `multiprocessing`.
 
- Add 1-2 line comments above key algorithmic steps comments around key algorithmic
  logic that explains what is going on in simple terms: filtering, calculations,
  reshapes, aggregations, etc.

- Add inline comments that detail the expected shapes of tensors and ndarrays, e.g. `#
  (N,D,E)` where it's clear what each dimension represents.

- Use meaningful variable names, mapping to key concepts.

- Explain parameter value choices.

### Arguments and variables

- ALWAYS use type hints for function arguments and return values.

- Also use type hints in the body of a function, when a variable type might be unclear.

- Use informative variable names, even if they are 2-3 words. Avoid abbreviations unless
  they are very common (e.g. `df` for dataframe). Avoid e.g. `sm` instead of
  `subject_mask`, etc.

- Name dataframes with a `df_` prefix.

### Design

- Functions should do one thing and do it well. Avoid functions that
  `do_this_and_that()`, break them into smaller composable functions with useful and
  robust public APIs.

- Use a composable design with general-purpose functions and classes that can be reused
  in different contexts.

- In notebooks, prefer short cells that do one thing (define a function, configure
  consts, create a plot, etc). 

- Keep notebook-specific configuration and plotting code in
  the notebook, while preferring to implement the core logic in separate modules.

- When writing functions in a notebook, avoid using global variables (except CONSTS).
  Pass all required data as function arguments, and return the results.

### Docstrings and comments
  
- Always write docstrings with ASD-STE100 guidelines.

- Docstrings should be self-contained and not require external context to understand
  (beyond standard project knowledge). Specifically:
  - Don't include context from "outside" in the code documentation (e.g. from this
    chat). Docs should describe the code only.
  - Don't explain the context beyond what that code does, e.g. don't mention details
    planning or previous approaches.
  
- Use Google-style docstrings, but no need to surround variable/function names with
  double backticks (``) in the docstrings, single is enough.

- Don't use an em/en dash, e.g. — or any other non-keyboard chars (both for code and
  comments).

- Include math in docstrings where appropriate, using LaTeX syntax.

### Other

- Proactively add `assert` statements to check for invariants and other sanity
  conditions, for example: array shapes, number of dimensions, non-empty data,
  non-constant data, existence of NaNs, sane data ranges, etc.
