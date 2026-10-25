"""Convert a saved Notion MCP fetch result into a markdown working copy.

Claude Code saves an MCP result that is too large for the context to a file. That file holds
the fetch result as JSON on one line. This script writes the page markdown to a file with one
line per markdown line, and prints a short outline, so that the agent can read only the
sections it needs (with grep, or Read with offset and limit).

The working copy is ephemeral: write it outside any git repository (for example the session
scratchpad), use it for one edit, and fetch again before the next edit.

Usage:
    python3 -I notion_fetch_to_md.py <saved_fetch_file> <out_dir>
"""

import json
import re
import sys
from pathlib import Path

# Lines that start a section or a layout block that the outline lists.
OUTLINE_PATTERN: re.Pattern = re.compile(r"^(#{1,4} |<toggle|<details|<tabs|<callout|<page )")
PAGE_ID_PATTERN: re.Pattern = re.compile(r"([0-9a-f]{32})")


def load_fetch_result(path: Path) -> dict:
    """Load a fetch result, as the raw JSON object or as a list of MCP text items.

    Args:
        path: The file that Claude Code saved for the fetch result.

    Returns:
        The fetch result object, with the keys `title`, `url`, `text` and the page metadata.
    """
    data = json.loads(path.read_text(encoding="utf-8"))
    if isinstance(data, list):
        texts = [item["text"] for item in data if isinstance(item, dict) and item.get("type") == "text"]
        assert len(texts) == 1, f"expected one text item, found {len(texts)}"
        data = json.loads(texts[0])
    assert isinstance(data, dict) and "text" in data, "not a Notion fetch result"
    return data


def outline(lines: list[str]) -> list[str]:
    """List the headings and layout blocks of the page, with 1-based line numbers.

    Args:
        lines: The lines of the page markdown.

    Returns:
        One entry per heading or layout block, as `<line>: <text>`. For a toggle, tab set or
        callout, the entry also has the next line, which is its title.
    """
    entries = []
    for index, line in enumerate(lines):
        if not OUTLINE_PATTERN.match(line):
            continue
        title = line.strip()
        if line.startswith(("<toggle", "<details", "<callout")) and index + 1 < len(lines):
            title += " " + lines[index + 1].strip()[:80]
        entries.append(f"{index + 1}: {title[:120]}")
    return entries


def main() -> None:
    assert len(sys.argv) == 3, __doc__
    fetch_path, out_dir = Path(sys.argv[1]), Path(sys.argv[2])
    result = load_fetch_result(fetch_path)

    page_id_match = PAGE_ID_PATTERN.search(result.get("url", "").replace("-", ""))
    assert page_id_match, f"no page id in url {result.get('url')!r}"
    page_id = page_id_match.group(1)

    markdown: str = result["text"]
    lines = markdown.split("\n")
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / f"{page_id}.md"
    out_path.write_text(markdown, encoding="utf-8")

    print(f"title: {result.get('title')}")
    print(f"url: {result.get('url')}")
    print(f"page_last_edited_at: {result.get('page_last_edited_at')}")
    for key in ("truncated", "unknown_block_count", "unknown_block_ids"):
        if result.get(key):
            print(f"{key}: {result[key]}")
    print(f"written: {out_path} ({len(lines)} lines, {markdown.count('<image ') + markdown.count('![')} images)")
    print("outline:")
    for entry in outline(lines):
        print(f"  {entry}")


if __name__ == "__main__":
    main()
