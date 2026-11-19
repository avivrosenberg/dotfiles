---
name: self-explanatory-figures
description: >
  Rules to make a figure self-explanatory: descriptive titles, units on every axis, named
  statistics, defined CIs, and legends below the axes. Use whenever you create or change a plot
  or figure (matplotlib, seaborn, notebooks, analysis modules, reports, Notion or Slack figures),
  and before you show a figure to Aviv.
---

# Self-explanatory figures

A reader must understand a figure without the code, the notebook text or the chat. Apply all the
rules below to every figure, then render it and look at it.

## Choose the plot

- Choose the plot for the question. Compare values: bars with uncertainty. Compare
  distributions: violins, box plots or ECDFs, with points (not bars of means). Show a relation
  between two variables: scatter. This list is not complete. Do not use a scatter plot to
  compare groups. Small multiples instead of many overlaid lines.
- One topic per figure. Show the pooled value next to the groups.
- Mention the unit of analysis and data size.
- Show uncertainty (CIs) and say how it was computed.
- Show the raw data when N is small.
- Same quantity, same axis range across panels, unless stated.
- Colorblind-safe colors. One entity, one color, in all figures of a document. A difference or
  derived quantity gets its own color, not the color of one input.
- One direction for "better" or "closer" on all axes of a document. If the raw quantity runs the
  other way (distance and similarity), convert it, and say so.
- Mark reference values (chance, null, pooled) with labeled lines.

## Rules

1. **Descriptive title.** Give the metric, the data and the model (or method).
   - Good: "task decoding accuracy per recording device (test segments)".
   - Bad: "t", "scores", "game_id".
   - Format: the figure title is bold, left-aligned, in a larger font (about 14 pt), and says what
     is shown. Panel titles stay small.
   - Below it, 1-2 short plain (not bold) lines say how to read the figure (what the number
     is, which direction is better, what a marker position, a color or 0 means). The title and these lines have no conclusions and no
     observations. Never use the words "how to interpret". Keep them concise.

2. **Units on every axis.** Every axis label gives the quantity and its unit or range.
   - Examples: "age (years)", "share of sessions (0-1)", "Cohen's d (pooled SD units)",
     "cosine similarity of 2 segment embeddings", "ROC AUC (0.5 = chance)",
     "adjusted balanced accuracy (0 = chance, 1 = perfect)".
   - Categorical axes also get a label, e.g. "headset (serial)", "true class (decoder label)".

3. **No bare symbols.** Never label an axis, color bar or legend entry only "t", "z", "d", "T"
   or "p". Name the statistic in words and define it once in the figure (axis label, title or
   suptitle).
   - Example: axis "z (T in null SDs)"; suptitle "z = (T - null mean) / null SD, T =
     score(headset) - score(all other headsets); null from permutations of the headset labels over
     subjects".

4. **Name every interval.** Say what an error bar, band or interval is, and how it was computed.
   - Example: "95% CI (bootstrap over the subjects of the headset)", "95% range of the
     permutation null".

5. **Label the reference lines with their values.** A pooled, chance or threshold line gets a
   legend entry with its value, e.g. "all headsets pooled (0.796)", "|z| = 3 (effect-size gate)",
   "chance (0.5)".

6. **Legend below the axes, in one horizontal row.** Do not put the legend on top of the data.
   The legend explains every mark: points, error bars, dashed lines, colors, highlighted points,
   bold tick labels, box plots ("box: median and quartiles; whiskers: 1.5 IQR"). For small
   multiples, use one legend for the figure, not one per panel. Name colors in the legend, not
   in text below the figure.

7. **Explain encodings that are not marks.** If tick labels are bold, starred or colored, say
   why (in the legend or the title), e.g. "bold: QC-flagged headset".

8. **Color bars have a label** with the quantity and unit, and say what the center or sign
   means for a diverging map, e.g. "recall difference (> 0: better than pooled)".

9. **Render and look.** Save the figure with `bbox_inches="tight"` (so legends below the axes
   are kept), open the image, and check for overlap, cut labels, empty panels, unreadable tick
   labels and legends that hide data.

## Matplotlib patterns

Legend below one axes (all entries in one row):

```python
ax.legend(
    loc="upper center",
    bbox_to_anchor=(0.5, -0.1),  # below the x label; lower it if the x label has 2 lines
    ncol=len(handles),
    frameon=False,
    fontsize=8,
)
```

Legend below all panels of a figure (call after `fig.tight_layout()`):

```python
fig.legend(handles, labels, loc="upper center", bbox_to_anchor=(0.5, 0.0),
           ncol=len(handles), frameon=False, fontsize=8)
fig.savefig(path, dpi=110, bbox_inches="tight")
```

Legend entries for marks that have no label (proxy artists):

```python
from matplotlib.lines import Line2D
from matplotlib.patches import Patch

handles = [
    Line2D([], [], marker="o", linestyle="", color="#2a78d6"),  # a point
    Line2D([], [], color="#52514e", linewidth=1),  # an error bar
    Line2D([], [], color="#52514e", linestyle="--"),  # a reference line
    Patch(fill=False, edgecolor="black"),  # an outlined cell
]
```

Bold left title and 1-2 reading lines above all axes (call after `fig.tight_layout()`):

```python
inv = fig.transFigure.inverted()
x0 = min(ax.get_position().x0 for ax in fig.axes)  # leftmost axes edge
y1 = max(ax.get_tightbbox().transformed(inv).y1 for ax in fig.axes)  # top, with panel titles
sub = fig.text(x0, y1 + 0.02, "How the marks read.\nSecond line.", ha="left", va="bottom", fontsize=9)
sub_top = sub.get_window_extent().transformed(inv).y1
fig.text(x0, sub_top + 0.01, "What is shown", ha="left", va="bottom", fontsize=14,
         fontweight="bold")
fig.savefig(path, dpi=110, bbox_inches="tight")
```

When a module draws many figures, keep the shared texts (the definition of a statistic, the CI
text, the meaning of bold labels) as constants, so all figures use the same words.

## Checklist (before you show a figure)

- Title: metric, data, model or method.
- Title bold, left, about 14 pt; 1-2 plain lines below say how to read the figure; no conclusions.
- Each axis: quantity and unit (or range); categorical axes labeled.
- No bare symbol; each statistic named and defined.
- Each interval named, with its method.
- Reference lines in the legend, with values.
- Legend below the axes, one row, explains every mark and encoding.
- Chart type fits the question; same color for the same entity as in the other figures; same
  direction of "better" on all axes.
- Color bars labeled.
- Rendered and looked at.
