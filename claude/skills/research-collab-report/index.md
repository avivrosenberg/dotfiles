# Index page structure (one analysis)

The index holds the parts at question level, and links the reports of the analysis. Same
principles, HTML layout and writing rules as `report.md`.

## Outline

1. **Provenance** (gray, first line): "Maintained by Claude from the reports below. Analysis
   folder `<repo>:<path>`. Last update `<date>`."
2. **Short-answer callout** (blue): each question of the analysis with a short answer, 1-3
   lines, only as agreed with Aviv (else "not yet discussed"). Add a line for an important
   unexpected finding.
3. **Motivation:** why the question matters, and the sub-questions. From the spec, if one
   exists (link it).
4. **Reports table:** one row per report, in the order of the argument.

   | # | Report | Question(s) it addresses | Main steps | Last update |
   |---|---|---|---|---|
   | 1 | [020 DCX decoders](020-dcx_decoders.html) | Q1 | [2. Gap per headset](020-dcx_decoders.html#s2) | 2026-11-04 |

5. **Conclusions** (global): numbered, only as agreed with Aviv. Each one answers (part of) a
   question and links the report steps that support it (`report.html#s2`). If none is agreed
   yet: "not yet discussed".
6. **Other findings:** the unexpected findings from the reports, one line each, with links.
7. **Caveats and limitations,** with the strongest case against the main conclusion in a
   yellow callout.
8. **Open questions and next checks,** ordered by value, collected from the reports.

## Rules

- No new results on the index: each claim links the report step that holds it.
- When a report changes, update its row, and every conclusion, finding or caveat that cites a
  changed step.
- Each report links back to the index (its provenance line).
- A project with several analysis folders can have one more index that links the analysis
  indexes, with relative links between folders.
