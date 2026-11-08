"""Inline the local images of an HTML deck as data URIs, so the file can be shared alone.

Usage: python3 -I bundle_html.py <deck.html> <out.html>
Relative `src="..."` of <img> tags are resolved against the folder of the deck.
Remote and data URIs are left as they are. Refuses an output above 16 MB.
"""
import base64
import mimetypes
import re
import sys
from pathlib import Path

MAX_BYTES = 16 * 1024 * 1024
IMG_SRC = re.compile(r'(<img\b[^>]*?\bsrc=")([^"]+)(")', re.IGNORECASE)


def to_data_uri(path: Path) -> str:
    mime = mimetypes.guess_type(path.name)[0] or "application/octet-stream"
    data = base64.b64encode(path.read_bytes()).decode("ascii")
    return f"data:{mime};base64,{data}"


def bundle(deck: Path) -> str:
    html = deck.read_text(encoding="utf-8")
    missing: list[str] = []

    def replace(match: re.Match) -> str:
        src = match.group(2)
        if src.startswith(("http:", "https:", "data:", "#")):
            return match.group(0)
        path = (deck.parent / src).resolve()
        if not path.is_file():
            missing.append(src)
            return match.group(0)
        return match.group(1) + to_data_uri(path) + match.group(3)

    out = IMG_SRC.sub(replace, html)
    if missing:
        sys.exit("Missing image files: " + ", ".join(missing))
    return out


def main() -> None:
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    deck, out_path = Path(sys.argv[1]), Path(sys.argv[2])
    out = bundle(deck)
    size = len(out.encode("utf-8"))
    if size > MAX_BYTES:
        sys.exit(f"Output is {size / 1e6:.1f} MB, above the 16 MB limit. Lower the image sizes.")
    out_path.write_text(out, encoding="utf-8")
    print(f"Wrote {out_path} ({size / 1e6:.1f} MB)")


if __name__ == "__main__":
    main()
