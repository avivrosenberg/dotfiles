# Format: local HTML slides (reveal.js)

One HTML file that uses **reveal.js** (loaded from cdnjs, pinned to 6.0.2).

- No custom slide code: navigation, overview, PDF export and math are the library's.
- Start from `deck-template.html`.
- Publish only when Aviv asks.
- If a need is not met, use a reveal.js option or plugin (check the docs for the pinned version), and tell Aviv.
- Do not write navigation or toggle code.

## Files

- Location: `<repo_out_dir>/<analysis_name>/decks/<deck name>.html` (project instructions can override), git-ignored.
- Figures and diagrams: relative links to the saved files (`../figures/...`, `../diagrams/...`), not copies.
- **One file to share:** `python3 -I "<skill dir>/scripts/bundle_html.py" deck.html deck-standalone.html`
  - It inlines every local image as a data URI (refuses above 16 MB).
  - The libraries still load from cdnjs, so the viewer needs internet.
- PDF: open `deck.html?print-pdf` in Chrome, print, "Save as PDF".
  - Methods sub-slides print as pages after their slide.

## Slides, sections and Methods

- One `<section>` per slide, in the order of `slides.md`.
- Parts of a result slide:
  - `<h2>`: the observation;
  - `<p class="read">`: how to read it;
  - `<figure>` with `<img>` and `<figcaption>`;
  - `<ul>`: the observations.

- **Sections of the deck:** reveal.js has two levels, and Methods use the vertical one.
  - So a section is a divider slide: `<section class="divider">` with `<h1>` (the section title) and `<p class="read">` (the question it covers).
  - Its slides follow.
  - Each slide of the section has `<p class="crumb">Section title</p>` above its `<h2>`.
  - `Esc` (overview) shows the dividers.

- **Methods are vertical sub-slides.**
  - An outer `<section>` holds the slide, then one or more `<section class="methods">` (Down opens, Up goes back).
  - A long Methods part is split in sub-slides titled "Methods (1/3): <part>", each fitting without scrolling.
  - Fixed and method slides have them too.
  - Depth follows the level (`slides.md`).

- Math: `$...$` inline, `$$...$$` blocks (reveal.js math plugin, MathJax 3, pinned).
  - Layout rules: `slides.md`, "Layout of method content".
- Two figures to compare: `<div class="columns">` with two `<figure>`.
- Callouts: `<div class="callout">` (blue) or `<div class="callout warn">` (caveat).
- "Preliminary": `<span class="tag">Preliminary</span>` in the `<h2>`, reason in the `read` line.
- Tables only where `slides.md` allows.
- Diagrams: the SVG file as `<img src="...svg">`.
- Backup: a slide `<h2>Backup</h2>`, then its slides.
  - Provenance (reports, SHAs, runs, date, status) is the last slide.
- Theme: only the CSS variables in the template (light and dark follow the system).
  - Do not change them per deck. System fonts only.

## Zoom (Viewer.js, in the template)

A click on a figure opens it in an overlay.

- Wheel or toolbar to zoom, drag to pan, click outside the image or `Esc` to close.
- While it is open, the arrow keys do not move slides (`keyboardCondition`).
- Off in PDF print mode.
- Keep the `<figure><img>` markup so the script finds the images.

## Keys (reveal.js)

- Arrows move. Down opens Methods.
- `Esc` or `O`: overview. `F`: full screen. `?`: help.
- The URL hash holds the position.
- Speaker view is not loaded.

## Create and update

- Create: copy the template, replace the title, write the slides, delete the example slides.
- Update: edit the file in place.
  - Slides are independent, so a change list maps to slide edits.
  - Keep Aviv's edits (compare with the file on disk).

## Checks after you write

Open the deck in the browser pane (one pass of fixes, no loop). Check:
- every image loads and math renders;
- a click on a figure opens the zoom, and `Esc` closes it;
- the arrows do not move slides while the zoom is open;
- each section has a divider slide, and each slide has its `crumb`;
- the Down arrow shows on every slide with Methods; every slide has Methods (or "n/a");
- at slide size, no figure text is unreadable and nothing overflows;
- the slide count matches the outline.
