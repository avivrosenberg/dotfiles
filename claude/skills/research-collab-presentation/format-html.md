# Format: local HTML slides (reveal.js)

One HTML file that uses **reveal.js** (a standard library, loaded from cdnjs, pinned to
6.0.2). No custom slide code: navigation, overview, PDF export and math are the library's. Start
from `deck-template.html` (this folder). Publish only when Aviv asks.

Do not write navigation or toggle code. If a need is not met, use a reveal.js option or plugin
(check the reveal.js docs for the pinned version), and tell Aviv.

## Files

- Location: `<repo_out_dir>/<analysis_name>/decks/<deck name>.html` (project instructions can override). Not in
  git (`<repo_out_dir>` is ignored).
- Figures and diagrams: relative links to the saved files (`../figures/...`,
  `../diagrams/...`). Do not copy them.
- **Share as one file:** `python3 -I "<skill dir>/scripts/bundle_html.py" deck.html deck-standalone.html`
  inlines every local image as a data URI (refuses a result above 16 MB). The libraries still
  load from cdnjs, so the viewer needs internet.
- PDF: open `deck.html?print-pdf` in Chrome, print, "Save as PDF". Methods sub-slides print as
  pages after their slide.

## Slides and Methods

- One `<section>` per slide, in the order of `slides.md`.
- **Methods are vertical sub-slides.** A slide with Methods is an outer `<section>` that holds the
  slide, then one or more `<section class="methods">` (press **Down** to open them, **Up** to go
  back). Methods stay out of sight until the presenter goes down. The template has an example.
- **Long Methods: split into several sub-slides**, each with a title "Methods (1/3): <part>".
  One part per slide: for example data and filters, the math, the statistics and code pointers.
  A sub-slide must fit without scrolling.
- Depth of Methods follows the detail level (`slides.md`).
- Fixed slides and method slides have Methods sub-slides too (a method slide gets its full math
  there).

Parts of a result slide: `<h2>` (the finding), `<p class="read">` (how to read it), `<figure>`
(`<img>` and `<figcaption>`), `<ul>` (observations).

- Math: `$...$` inline for small expressions and symbols, `$$...$$` blocks for larger equations
  (reveal.js math plugin, MathJax 3, pinned). Method content: `slides.md`, "Layout of method
  content" (bullets, not dense, consistent with the figure).
- Two figures to compare: `<div class="columns">` with two `<figure>`.
- Callouts: `<div class="callout">` (blue) or `<div class="callout warn">` (caveat).
- "Preliminary": `<span class="tag">Preliminary</span>` in the `<h2>`, reason in the `read` line.
- Tables only where `slides.md` allows. Diagrams: the SVG file as `<img src="...svg">`.
- Backup: a slide `<h2>Backup</h2>`, then its slides. Provenance (reports, SHAs, runs, date,
  status) is the last slide.
- Theme: only the CSS variables in the template (light and dark follow the system). Do not
  change them per deck. System fonts only.

## Keys (reveal.js)

Arrows: move (Down opens Methods). `Esc` or `O`: overview of all slides. `F`: full screen.
`S`: speaker view (needs the notes plugin; not loaded). `?`: help. The URL hash holds the position.

## Create and update

- Create: copy the template, replace the title, write the slides, delete the example slide.
- Update: edit the file in place. Slides are independent, so a change list maps to slide edits.
  Keep Aviv's edits (compare with the file on disk).

## Checks after you write

Open the deck in the browser pane (one pass of fixes, no loop). Check:
- every image loads and math renders;
- the Down arrow shows on every slide that has Methods; every slide has Methods (or "n/a");
- at slide size, no figure text is unreadable and no slide or Methods sub-slide overflows;
- slide count matches the outline.
