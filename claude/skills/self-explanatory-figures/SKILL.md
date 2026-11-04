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

- Choose the plot for the comparison: positions on a common scale to compare values;
  distributions (histogram, ECDF, box or violin with points) instead of bar charts of means;
  small multiples instead of many overlaid lines.
- Mention the unit of analysis and data size.
- Show uncertainty (CIs) and say how it was computed.
- Show the raw data when N is small.
- Same quantity, same axis range across panels, unless stated.
- Colorblind-safe colors; one meaning per color in a figure.
- Mark reference values (chance, null, pooled) with labeled lines.

## Rules

1. **Descriptive title.** Give the metric, the data and the model (or method).
   - Good: "task decoding accuracy per recording device (test segments)".
   - Bad: "t", "scores", "game_id".
   - Put method details that do not fit in the title in a second title line or a suptitle.

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
   multiples, use one legend for the figure, not one per panel.

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

When a module draws many figures, keep the shared texts (the definition of a statistic, the CI
text, the meaning of bold labels) as constants, so all figures use the same words.

## Checklist (before you show a figure)

- Title: metric, data, model or method.
- Each axis: quantity and unit (or range); categorical axes labeled.
- No bare symbol; each statistic named and defined.
- Each interval named, with its method.
- Reference lines in the legend, with values.
- Legend below the axes, one row, explains every mark and encoding.
- Color bars labeled.
- Rendered and looked at.
