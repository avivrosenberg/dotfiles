# Format: Notion

A Notion page that works as a deck. Notion mechanics (working copy, figure upload, markdown
format, safe edits, comments): `../project-hub/notion.md`. Read it before you write. Figure
upload permissions are the same as for `project-hub`.

## Page

- Created as a private draft (`creation_mode: "draft"`) unless Aviv names a parent. Tell him it
  is private. Do not move or publish it. Title: the deck name, short. Icon: 🎤 (optional).
- Slides are separated by `---` on its own line, with a blank line before and after.
- Order: title block (gray `<p color="gray">`: audience, date, author, status), then the slides of
  `slides.md`, then a heading `# Backup` and its toggles.
- Slide title = `# <title>` (heading 1), so the page outline lists the deck.
- Optional table of contents after the title block: only for decks of more than 12 slides.

## Slide block

```
# <Main finding>

<p color="gray">How to read it: ...</p>

![One-line caption.](file-upload://<id>)

- Observation, 2 to 4 bullets.

<toggle>
Methods

...
</toggle>

---
```

- Methods = `<toggle>` titled "Methods", with bullets and short sub-headings (one per part for
  long Methods). Math: `$...$` for small expressions and symbols, `$$` blocks for larger
  equations (format in `notion.md`). Layout rules: `slides.md`, "Layout of method content".
- Two figures to compare: `<columns>`. Variants of one figure: `<tabs>`.
- Callouts: yellow `<callout icon="⚠️" color="yellow_bg">` for a caveat on a slide, blue for the
  one-line message of a method slide.
- Diagrams are PNG images, uploaded like figures. Keep each SVG source in `out/diagrams/`.
- Tables only where `slides.md` allows them, as Notion tables with rich text cells.

## Create and update

- Figure manifest: `.notion-figures/<page id without dashes>.json` at the repo root.
- New deck: write the content first, then create the uploads and the page without other work in
  between (upload URLs expire in about 10 minutes). Follow the write checklist in `notion.md`.
- Update: fetch the page, read open comments (`notion-get-comments`, `include_all_blocks`).
  Text-only changes: `update_content`. Any new or changed image, or a new or moved slide: one
  `replace_content` from one fresh fetch (`project-hub/SKILL.md`, step 6). Save open comments
  (anchor, text) before a `replace_content`. Never resolve or answer comments in Notion.
- Provenance toggle in Backup: reports and SHAs, runs, snapshot date, deck status, changelog.

## Checks after you write

Fetch once. Check:
- the `---` separators: one between each pair of slides, none inside a slide;
- image count = figures + diagrams;
- each slide has a toggle titled "Methods";
- the order of blocks is unchanged;
- no literal `{color=`, `` $` `` or `\{`.
