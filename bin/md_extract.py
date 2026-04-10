#!/usr/bin/env python3
"""Extract sections from markdown files by heading name."""

import argparse
import re
import sys
from datetime import datetime
from pathlib import Path


def try_parse_datetime(s: str) -> datetime | str:
    try:
        return datetime.fromisoformat(s)
    except ValueError:
        return s


def apply_comment_stripping(
    body_lines: list[str],
    strip_comments: str | None,
    strip_comments_multiline: str | None,
) -> list[str]:
    if strip_comments:
        body_lines = [l for l in body_lines if not l.startswith(strip_comments)]
    if strip_comments_multiline:
        body_text = re.sub(
            re.escape(strip_comments_multiline) + r'.*?' + re.escape(strip_comments_multiline),
            '',
            ''.join(body_lines),
            flags=re.DOTALL,
        )
        body_lines = body_text.splitlines(keepends=True)
    return body_lines


def parse_heading(line: str) -> tuple[int, str] | None:
    """Return (level, text) if line is an ATX heading, else None."""
    m = re.match(r'^(#{1,6})\s+(.+?)(?:\s+#+)?\s*$', line.rstrip('\n\r'))
    if m:
        return len(m.group(1)), m.group(2).strip()
    return None


def find_sections(
    lines: list[str],
    heading_names: set[str],
    heading_levels: list[int],
    ignore_case: bool,
) -> list[tuple[int, str, int, int]]:
    """Find all sections matching heading names and levels.

    Returns list of (level, text, start_idx, end_idx) where end_idx is
    exclusive — points to the next heading at the same or higher level, or EOF.
    """
    compare_names = {n.lower() for n in heading_names} if ignore_case else heading_names
    any_level = 0 in heading_levels
    sections = []

    for i, line in enumerate(lines):
        parsed = parse_heading(line)
        if parsed is None:
            continue
        level, text = parsed
        compare_text = text.lower() if ignore_case else text
        if compare_text not in compare_names:
            continue
        if not any_level and level not in heading_levels:
            continue
        # Find end: next heading at same or higher level (lower number)
        end = i + 1
        while end < len(lines):
            p = parse_heading(lines[end])
            if p is not None and p[0] <= level:
                break
            end += 1
        sections.append((level, text, i, end))

    return sections


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract sections from markdown files by heading name.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s notes.md --heading="TODO"
  %(prog)s *.md --heading="Notes" --heading="Summary" --sort-inputs --output=out.md
  %(prog)s file.md --heading="Done" --strip-input --no-keep-heading
""",
    )
    parser.add_argument("files", nargs="+", help="Markdown files to process")
    parser.add_argument(
        "--heading",
        action="append",
        dest="headings",
        default=[],
        metavar="NAME",
        help="Heading name to extract (repeatable)",
    )
    parser.add_argument(
        "--input-heading-level",
        default="0",
        metavar="LEVELS",
        help="Heading level(s) to match: 0 for any (default), or comma-separated (e.g. 2,3)",
    )
    parser.add_argument(
        "--output-filename-level",
        type=int,
        default=0,
        metavar="LEVEL",
        help="Heading level for the filename heading in output; "
             "0 means auto (input level - 1, or same level if --no-keep-heading)",
    )
    parser.add_argument(
        "--output-heading-level",
        type=int,
        default=0,
        metavar="LEVEL",
        help="Heading level for the extracted section heading in output; "
             "0 means auto (same as input level)",
    )
    parser.add_argument(
        "--sort-inputs",
        action="store_true",
        help="Sort input files alphabetically before processing",
    )
    parser.add_argument(
        "--sort-order",
        choices=["asc", "desc"],
        default="asc",
        help="Sort order when --sort-inputs is set: asc (default) or desc",
    )
    parser.add_argument(
        "--output",
        default="-",
        metavar="PATH",
        help="Output file path, or '-' for stdout (default: stdout)",
    )
    parser.add_argument(
        "--keep-heading",
        dest="keep_heading",
        action="store_true",
        default=True,
        help="Include matched heading in output (default)",
    )
    parser.add_argument(
        "--no-keep-heading",
        dest="keep_heading",
        action="store_false",
        help="Exclude matched heading from output",
    )
    parser.add_argument(
        "--strip-input",
        dest="strip_input",
        action="store_true",
        default=False,
        help="Remove extracted sections from input files",
    )
    parser.add_argument(
        "--no-strip-input",
        dest="strip_input",
        action="store_false",
        help="Keep input files unchanged (default)",
    )
    parser.add_argument(
        "--ignore-case",
        "-i",
        action="store_true",
        default=False,
        help="Case-insensitive heading name matching",
    )
    parser.add_argument(
        "--keep-filename",
        dest="keep_filename",
        action="store_true",
        default=True,
        help="Write a filename heading above each extracted section (default)",
    )
    parser.add_argument(
        "--no-keep-filename",
        dest="keep_filename",
        action="store_false",
        help="Omit the filename heading above each extracted section",
    )
    parser.add_argument(
        "--filename-format",
        default="{filename}",
        metavar="FMT",
        help="Format string for the filename heading text. "
             "Available variables: {filename}, {header}. Default: '{filename}'",
    )
    parser.add_argument(
        "--heading-format",
        default="{header}",
        metavar="FMT",
        help="Format string for the extracted heading text (only with --keep-heading). "
             "Available variables: {filename}, {header}. Default: '{header}'",
    )
    parser.add_argument(
        "--parse-datetimes",
        dest="parse_datetimes",
        action="store_true",
        default=False,
        help="Try to parse filename and header as ISO datetimes via datetime.fromisoformat(); "
             "if successful, datetime objects are passed to format strings instead of raw strings",
    )
    parser.add_argument(
        "--no-parse-datetimes",
        dest="parse_datetimes",
        action="store_false",
        help="Do not attempt datetime parsing (default)",
    )
    parser.add_argument(
        "--drop-empty",
        dest="drop_empty",
        action="store_true",
        default=False,
        help="Skip sections whose body is empty (whitespace-only) after comment stripping",
    )
    parser.add_argument(
        "--no-drop-empty",
        dest="drop_empty",
        action="store_false",
        help="Keep empty sections (default)",
    )
    parser.add_argument(
        "--strip-comments",
        default=None,
        metavar="PREFIX",
        help="Remove lines starting with PREFIX (e.g. --strip-comments=%%)",
    )
    parser.add_argument(
        "--strip-comments-multiline",
        default=None,
        metavar="DELIM",
        help="Remove blocks delimited by DELIM (e.g. --strip-comments-multiline=%%%%)",
    )

    args = parser.parse_args()

    if not args.headings:
        parser.error("at least one --heading is required")

    # Parse heading levels; 0 means any level
    level_str = args.input_heading_level.strip()
    try:
        heading_levels = [int(x.strip()) for x in level_str.split(",")]
    except ValueError:
        parser.error(f"invalid --input-heading-level value: {level_str!r}")

    files = [Path(f) for f in args.files]
    if args.sort_inputs:
        files.sort(key=lambda p: p.name, reverse=(args.sort_order == "desc"))

    out = sys.stdout if args.output == "-" else open(args.output, "w", encoding="utf-8")

    try:
        heading_names = set(args.headings)
        first_section = True

        for filepath in files:
            try:
                content = filepath.read_text(encoding="utf-8")
            except OSError as e:
                print(f"error: {e}", file=sys.stderr)
                continue

            lines = content.splitlines(keepends=True)
            sections = find_sections(lines, heading_names, heading_levels, args.ignore_case)
            if not sections:
                continue

            stem = filepath.stem

            for level, text, start, end in sections:
                body_lines = apply_comment_stripping(
                    list(lines[start + 1:end]),
                    args.strip_comments,
                    args.strip_comments_multiline,
                )

                if args.drop_empty and not "".join(body_lines).strip():
                    continue

                if not first_section:
                    out.write("\n")
                first_section = False

                if args.parse_datetimes:
                    fmt_vars = {
                        "filename": try_parse_datetime(stem),
                        "header": try_parse_datetime(text),
                    }
                else:
                    fmt_vars = {"filename": stem, "header": text}

                if args.output_filename_level != 0:
                    filename_level = args.output_filename_level
                elif args.keep_heading:
                    filename_level = max(1, level - 1)
                else:
                    filename_level = level

                heading_level = args.output_heading_level if args.output_heading_level != 0 else level

                if args.keep_filename:
                    try:
                        filename_text = args.filename_format.format(**fmt_vars)
                    except KeyError as e:
                        parser.error(f"unknown variable {e} in --filename-format; "
                                     f"available: {{filename}}, {{header}}")
                    out.write(f"{'#' * filename_level} {filename_text}\n")

                if args.keep_heading:
                    try:
                        heading_text = args.heading_format.format(**fmt_vars)
                    except KeyError as e:
                        parser.error(f"unknown variable {e} in --heading-format; "
                                     f"available: {{filename}}, {{header}}")
                    out.write(f"{'#' * heading_level} {heading_text}\n")
                    for l in body_lines:
                        out.write(l)
                else:
                    for l in body_lines:
                        out.write(l)

            if args.strip_input and sections:
                stripped = list(lines)
                for _, _, start, end in reversed(sections):
                    del stripped[start:end]
                filepath.write_text("".join(stripped), encoding="utf-8")

    finally:
        if out is not sys.stdout:
            out.close()


if __name__ == "__main__":
    main()
