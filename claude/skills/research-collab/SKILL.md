---
name: research-collab
description: The main research collaboration loop with Aviv, from a question or idea to agreed results, at the level of data, figures and methods, not code. Use when Aviv brings a research question, a problem, or an idea for an experiment (large or small); asks to brainstorm, explore or visualize data for a question; asks for a spec; approves a spec or plan for implementation; or asks to see, discuss or iterate on results. Not for a final written report.
---

# Research collaboration

Aviv works like a PI. We iterate on data, figures, tables and methods until the results make
sense. He does not review code. A final written report is a separate, later step, not part of
this loop.

**Mandatory:** use the `presenting-results` skill for everything you show in this loop.

**Project setup:** the project instructions (AGENTS.md, CLAUDE.md) say where specs, analysis
code, scripts and run configs go, and which project skills to use for them. Follow them. If
they don't say, ask.

## The loop

```
question or idea -> brainstorm + explore -> spec -> implement -> results review
                        ^                                              |
                        +----------------------------------------------+
```

Repeat brainstorm, spec, implementation and results review until the results make sense. Any
step can go back to an earlier step. A question can be a large project or a quick experiment:
scale each step to it.

## 1. Brainstorm and explore

Goal: converge on the idea with Aviv. He decides; you suggest and challenge.

- Start with the strongest non-obvious reason not to do it (or say you found none).
- Discuss ideas. Ask questions that help him think; don't think for him.
- **Explore visually, early and often.** Make plots of anything that can inform the decision:
  data coverage, counts per group, distributions, confounds, balance, missing data, a quick
  first look at the effect.
  - Suggest a short list of candidate plots (one line each). Aviv picks and adds his own. Make
    obvious, cheap plots directly; ask first for plots that need long jobs.
  - Exploration scripts go in an analysis or scripts folder in the project repo. Aviv
    names the analysis; ask if he did not.
- Explain how a method works with a diagram or a small synthetic example, not only text.
- Do not write the spec until Aviv says we converged.

## 2. Spec

Write the spec as a markdown file with the template in `spec.md`, in the place the project
instructions give.

- It must be self-contained: a new session with no access to this chat must be able to
  implement it from the spec alone.
- It describes what and why (data, methods, math, outputs), not how (no code design).
- Iterate with Aviv until he approves it. Record the approval in the spec frontmatter
  (`status: approved YYYY-MM-DD`).
- **Socratic option.** If the spec has a core method that is interesting to implement, offer
  Aviv the Socratic collaboration of the global CLAUDE.md in one line. Default in this loop: skip.

## 3. Implement

Can run in a new session from the spec.

1. Before you write code in a repo (including the exploration scripts), read its
   `CLAUDE.md` and `CLAUDE.local.md` files in full with the Read tool. Every session.
2. Write a short implementation plan (steps, which repo, which outputs first). Get Aviv's OK.
3. Branch `aviv/<name>` in each repo you change. If the branch exists, use it. Commit in small
   logical commits and push. Separate analysis from general purpose methods/tools code
   in the commits.
4. Method explainers: where the method allows it and it is not trivial, add synthetic
   data or theoretical results that show how the method works and how it fails. Put them
   in separate method notebooks, not in the main analysis. These should produce visuals.
5. Implementation should write all result figures and tables to files, even when they
   are generated in notebooks.

Never open a PR unless explicitly asked.

## 4. Results review

- Present results one at a time, or in small groups, in the order of the spec
  (`presenting-results`).
- Look at the figures yourself and present observations.
- Do not present conclusions. Ask Aviv for his conclusion, discuss it, challenge it, and
  find a consensus.
- Aviv's feedback decides the next step: another figure, a change to the method, back to the
  spec, or more exploration.
- When a set of results looks good to Aviv, he may ask for an audit to ensure the code
  is correct (`analysis-audit`). Don't run it unasked.
- When a decision changes the spec, update the spec, with a dated line under "Changes".
