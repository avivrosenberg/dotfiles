"""Send local figures to Notion MCP file-upload URLs, and track what each page has.

Usage:
    # Upload one file; with --manifest, record it in the figure manifest of the page
    python3 -I notion_upload.py <upload_url> <file_path> [--header "Name: value" ...] \
        [--manifest <manifest.json>]

    # Which files are new or changed since the last upload to the page?
    python3 -I notion_upload.py --check <manifest.json> <file_path> ...

    # Record a file that is already on the page (no upload), e.g. for an old page
    python3 -I notion_upload.py --record <manifest.json> <notion_filename> <file_path>

The upload URL and headers come from the Notion MCP tool `notion-create-file-upload`.
Only URLs that start with ALLOWED_URL_PREFIX are accepted, so this script cannot send
files anywhere else. An upload prints the JSON response (it has `suggested_markdown`).

The figure manifest of a page is `<repo root>/.notion-figures/<page id>.json`. It is a JSON
object: file path relative to the repo root -> {"notion_name", "sha256", "file_upload_id",
"recorded"}. The repo root is the parent of the manifest folder, so the manifest has no
machine-specific paths. `notion_name` is the file name in Notion, which also appears as
`name=` in the `<image source=...>` blocks of a page fetch.

Uses only the standard library, so any python3 can run it.
"""

import datetime
import hashlib
import json
import mimetypes
import sys
import urllib.request
import uuid
from pathlib import Path

ALLOWED_URL_PREFIX = "https://api.notion.com/v1/mcp/file_uploads/"
# Notion allows 20 MiB per single-part upload; the report skill keeps figures below 10 MB.
MAX_FILE_BYTES = 10 * 1024 * 1024


def parse_upload_args(argv: list[str]) -> tuple[str, Path, dict[str, str], Path | None]:
    """Return the upload URL, file path, extra headers and manifest path of an upload."""
    assert len(argv) >= 2, __doc__
    upload_url, file_path = argv[0], Path(argv[1])
    headers: dict[str, str] = {}
    manifest_path: Path | None = None
    rest = argv[2:]
    assert len(rest) % 2 == 0, "each --header and --manifest needs a value"
    for flag, value in zip(rest[::2], rest[1::2]):
        if flag == "--manifest":
            manifest_path = Path(value)
            continue
        assert flag == "--header", f"unknown argument {flag}"
        name, _, header_value = value.partition(":")
        headers[name.strip()] = header_value.strip()
    return upload_url, file_path, headers, manifest_path


def build_multipart_body(file_path: Path) -> tuple[bytes, str]:
    """Return a multipart/form-data body with the file in the `file` field, and its content type."""
    boundary = uuid.uuid4().hex
    mime_type = mimetypes.guess_type(file_path.name)[0] or "application/octet-stream"
    head = (
        f"--{boundary}\r\n"
        f'Content-Disposition: form-data; name="file"; filename="{file_path.name}"\r\n'
        f"Content-Type: {mime_type}\r\n\r\n"
    ).encode()
    tail = f"\r\n--{boundary}--\r\n".encode()
    return head + file_path.read_bytes() + tail, f"multipart/form-data; boundary={boundary}"


def upload_file(upload_url: str, file_path: Path, headers: dict[str, str]) -> str:
    """Send file_path to upload_url with one POST and return the response body."""
    assert upload_url.startswith(ALLOWED_URL_PREFIX), f"URL must start with {ALLOWED_URL_PREFIX}"
    assert file_path.is_file(), f"{file_path} does not exist"
    assert file_path.stat().st_size <= MAX_FILE_BYTES, f"{file_path} is larger than 10 MB"

    body, content_type = build_multipart_body(file_path)
    request = urllib.request.Request(upload_url, data=body, method="POST")
    for name, value in headers.items():
        request.add_header(name, value)
    request.add_header("Content-Type", content_type)
    with urllib.request.urlopen(request, timeout=60) as response:
        return response.read().decode()


def file_sha256(file_path: Path) -> str:
    """Return the SHA-256 hex digest of the file content."""
    assert file_path.is_file(), f"{file_path} does not exist"
    return hashlib.sha256(file_path.read_bytes()).hexdigest()


def load_manifest(manifest_path: Path) -> dict[str, dict[str, str | None]]:
    """Return the figure manifest, or an empty one if the file does not exist."""
    if not manifest_path.exists():
        return {}
    manifest = json.loads(manifest_path.read_text())
    assert isinstance(manifest, dict), f"{manifest_path} is not a JSON object"
    return manifest


def manifest_key(manifest_path: Path, file_path: Path) -> str:
    """Return the manifest key of file_path: its path relative to the repo root of the manifest."""
    repo_root = manifest_path.resolve().parent.parent
    resolved_file = file_path.resolve()
    assert resolved_file.is_relative_to(repo_root), f"{file_path} is not inside {repo_root}"
    return resolved_file.relative_to(repo_root).as_posix()


def record_figure(
    manifest_path: Path, file_path: Path, notion_name: str, file_upload_id: str | None
) -> None:
    """Write the current hash of file_path and its Notion name to the manifest."""
    manifest = load_manifest(manifest_path)
    manifest[manifest_key(manifest_path, file_path)] = {
        "notion_name": notion_name,
        "sha256": file_sha256(file_path),
        "file_upload_id": file_upload_id,
        "recorded": datetime.date.today().isoformat(),
    }
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    manifest_path.write_text(json.dumps(manifest, indent=1, sort_keys=True) + "\n")


def figure_status(entry: dict[str, str | None] | None, file_path: Path) -> str:
    """Return "new", "changed" or "unchanged" for file_path against its manifest entry."""
    if entry is None:
        return "new"
    return "unchanged" if entry["sha256"] == file_sha256(file_path) else "changed"


def main(argv: list[str]) -> None:
    """Run one of the three modes (see the module docstring)."""
    assert argv, __doc__
    if argv[0] == "--check":
        assert len(argv) >= 3, "--check needs a manifest and at least one file"
        manifest_path = Path(argv[1])
        manifest = load_manifest(manifest_path)
        for file_name in argv[2:]:
            file_path = Path(file_name)
            entry = manifest.get(manifest_key(manifest_path, file_path))
            notion_name = entry["notion_name"] if entry else ""
            print(f"{figure_status(entry, file_path):9s} {file_path}  {notion_name}")
        return
    if argv[0] == "--record":
        assert len(argv) == 4, "--record needs a manifest, a Notion file name and a file"
        record_figure(Path(argv[1]), Path(argv[3]), argv[2], None)
        print(f"recorded {argv[3]} as {argv[2]}")
        return

    upload_url, file_path, headers, manifest_path = parse_upload_args(argv)
    response_text = upload_file(upload_url, file_path, headers)
    print(response_text)
    if manifest_path is not None:
        response = json.loads(response_text)
        assert response.get("status") == "uploaded", f"upload failed: {response_text}"
        # The upload id is in `markdown_source` ("file-upload://<id>")
        file_upload_id = response.get("id") or response["markdown_source"].removeprefix(
            "file-upload://"
        )
        record_figure(manifest_path, file_path, response["filename"], file_upload_id)


if __name__ == "__main__":
    main(sys.argv[1:])
