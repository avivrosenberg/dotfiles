# Notion mechanics

## Pages

- **New sub-page:** `notion-create-pages` with `parent: {type: "page_id", page_id: <hub id>}`.
  Set the title in `properties.title`, not in the content. The title is the experiment question
  or topic, short. No date, no notebook number (they go in the provenance line).
- **New hub:** if Aviv names no destination, create it with `creation_mode: "draft"` (private).
  Tell him it is private.
- Icons: hub 🗂️, sub-pages one emoji that fits the content (📊 metrics, 🔬 analysis, 🧪
  intervention runs). Optional.
- Do not make pages public or move them. Aviv does that.

## Read pages from a working copy

A page fetch can be 10-60k characters. In the context, it is read again on every later call.
- **Large fetch (Claude Code saved it to a file):** the result says "Output has been saved to
  `<file>`". Convert it to a working copy:
  ```bash
  python3 -I "<skill dir>/scripts/notion_fetch_to_md.py" "<saved file>" "<scratchpad>/notion-pages"
  ```
  It writes `<page id>.md` (one line per markdown line) and prints the title,
  `page_last_edited_at`, the image count, and an outline of headings, toggles, tabs, callouts
  and child pages with line numbers. Read only the sections you need (Read with offset and
  limit, or grep). Do not Read the saved file or the working copy in full.
- **Small fetch (in the context):** use it as it is.
- **The working copy is ephemeral.** Put it in the session scratchpad, never in a git
  repository. Use it for one edit round only.
- Comments do not come with the fetch: get them with `notion-get-comments` (see "Comments").

## Figures

**Permissions.** Uploads need two allow rules in the user settings (`~/.claude/settings.json`),
so that they apply in every repo (Aviv adds them; an agent must not edit its own permissions):
- the MCP tool `notion-create-file-upload`;
- the Bash command that runs `scripts/notion_upload.py`.

If an upload is blocked, stop and tell Aviv. Do not work around it (no other upload commands).

**Figure manifest.** Each page has a manifest in the repo that holds its figures:
`<repo root>/.notion-figures/<page id without dashes>.json`. It records the hash and the Notion
file name of each figure on the page, keyed by the path relative to the repo root. Pass it
with its path from the repo root. The repo conventions (`CLAUDE.local.md`) say if the repo commits
it.

**Find the figures to upload** (new page: all; update: only new and changed):
```bash
python3 -I "<skill dir>/scripts/notion_upload.py" --check "<manifest>" <figure files...>
```
It prints `new`, `changed` or `unchanged` for each file. An `unchanged` figure keeps its
`<image source="notion-file-block://...&name=<notion name>">` block from the page fetch: find
it by its `name=`. A page with no manifest: treat every figure that
the code makes again after the page date as changed, then record the rest with `--record`.

**Upload a figure:**
1. `notion-create-file-upload` with `{"filename": "<prefix>-<name>.png"}`. Use a prefix that
   makes the name unique, for example the notebook number (`021-mmd.png`). Send the calls for
   all figures of the page in parallel, in one message.
2. Send the files with the script in this skill (it accepts only Notion upload URLs), all in one
   shell call:
   ```bash
   python3 -I "<skill dir>/scripts/notion_upload.py" "<upload_url>" "<file>" --header "<Name>: <value>" --manifest "<manifest>"
   ```
   Pass every header from `upload_headers` with its own `--header`.
3. Put the image in the page as `![<one-line caption>](file-upload://<id>)`.

- Keep each file below 10 MB (the script refuses larger files). If a figure is larger, lower its
  dpi or size in the notebook.
- Upload URLs expire about 10 minutes after `notion-create-file-upload`. Write the page
  content before you create the uploads, then create, send and write without other work in
  between.

**Change figures on an existing page:** `update_content` cannot match image blocks (every image
`old_str` gives `no_match`). All figure changes go in one `replace_content` (SKILL.md, step 6).

## Format to write (check it before you write)

The Notion server's parser can differ from `notion://docs/notion-flavored-markdown-spec`. It
reads (and `notion-fetch` returns) an HTML-like format:
- **Gray or colored paragraph:** `<p color="gray">` on its own line, the text, `</p>`. A trailing
  `{color="gray"}` is stored as literal text.
- **Inline math:** `$x_i = I Z_i + c$`. The `` $`...`$ `` form is stored as literal text.
- **Block math:** `$$` on its own line, the equation, `$$` on its own line.
- **Bold, code:** `**...**` and `` `...` `` still work in new content (fetch shows `<b>`, `<code>`).
- Outside code and math, escape these characters with a backslash: `\ * ~ ` $ [ ] < > { } | ^`.

**Rule:** write colored blocks and math in the format above (or copy it from the page you
already fetched; do not fetch another page for it).

## Layout blocks

This is the format that `notion-fetch` returns and that writes accept.
Each image is its own block, with a blank line before it and a blank line or a closing tag
after it.

```
<tabs>
<tab>
train

![Caption.](file-upload://<id>)
</tab>
<tab>
held\_out

<image source="notion-file-block://...&name=021-x.png">
Caption of an unchanged figure, copied from the fetch.
</image>
</tab>
</tabs>

<columns>
<column>

![Caption.](file-upload://<id>)

</column>
<column>

![Caption.](file-upload://<id>)

</column>
</columns>

<toggle>
Metric definitions

- ...
</toggle>

<callout icon="⚠️" color="yellow_bg">
	**Strongest case against:** ...
</callout>
```

- The first line of a `<tab>` or `<toggle>` is its title, then a blank line.
- Use `<toggle>`, not `<details>`/`<summary>` (legacy, converted with a warning).
- Table cells hold rich text only (no images, lists or math blocks). Inline math is fine.

## Write checklist

Check the content against this list before each `notion-create-pages` or `replace_content`:
1. Every `![...](...)` line has a blank line before it, and a blank line or a closing tag
   (`</tab>`, `</column>`, `</toggle>`) after it. Also after a tab or toggle title line, and
   between two images.
2. Every `file-upload://<id>` is from an upload of this session that the script reported as
   `uploaded`.
3. Every unchanged figure is its `<image source=...>` block, copied whole from the latest fetch.
4. Colored paragraphs use `<p color="...">`, inline math uses `$...$` (not `` $`...`$ ``).
5. For `replace_content` on a hub: every `<page>` tag is kept.

## Safe edits

- Copy each `old_str` from the latest fetch (the working copy), not from the content you wrote.
  The fetch format can differ from the input format (for example `<b>`, `<code>`, `$x$` instead
  of `**`, `` ` ``, `` $`x`$ ``), and `update_content` matches the fetched text. Use the
  smallest unique `old_str`.
- `update_content` reports an `old_str` that does not match as a `no_match` warning, not as an
  error. Read the warnings after each call.
- After `replace_content`, fetch the page and check the block order: Notion can move unchanged
  blocks (for example a table to the top of the page). Fix the order with `update_content`.
- If an edit would delete content that Aviv wrote, ask first.

## Hub edits

- Edit the hub with `update_content` only: one edit per changed table row, per changed
  question section, plus the status block and the provenance line. The hub holds the
  `<page>` tags of all sub-pages, and a `replace_content` that misses one removes that page.
- Use `replace_content` on the hub only to create or restructure it, and only with the write
  checklist (item 5).
- Table rows: copy the `old_str` of a row from the latest fetch (the fetch can return the
  table as `<table>` HTML). Links in cells use the sub-page URL, with `#<block id>` for a
  section when the id is known.

## Comments

- **Get all open comments:** `notion-get-comments` with `{"page_id": <id>, "include_all_blocks":
  true}`. The default call returns only page-level comments, and most comments are anchored to
  a block or to selected text, so the default call misses them.
- Each `<discussion>` has `context="block"` or `context="inline"` (then `text-context` has the
  selected text) and a `discussion://<page>/<block>/<id>` URL. To find the anchor block, fetch
  the page with `include_discussions: true`: the fetch shows the same `discussion://` URLs in
  place. Read only the comments that are not resolved (the default).
- **`by-you="true"` does not mean Claude wrote it.** The Notion connection runs as Aviv's
  account, so his own comments show `by-you="true"`. Treat every open comment as Aviv's.
