"""Extract the image and text outputs of a Jupyter notebook to a folder.

Usage:
    python3 -I extract_nb_outputs.py <notebook.ipynb> <out_dir>

Writes:
    <out_dir>/cell<NNN>_<k>.png   one file per PNG output
    <out_dir>/outputs.md          per cell: the first source line, then its text outputs

Uses only the standard library, so any python3 can run it.
"""

import base64
import json
import sys
from pathlib import Path

# Text outputs longer than this are cut, so that outputs.md stays readable.
MAX_TEXT_CHARS = 4000


def output_text(output: dict) -> str:
    """Return the plain text of one cell output, or an empty string if it has none."""
    if output.get("output_type") == "stream":
        return "".join(output.get("text", []))
    if output.get("output_type") == "error":
        return f"{output.get('ename')}: {output.get('evalue')}"
    text_plain = output.get("data", {}).get("text/plain", [])
    return "".join(text_plain) if isinstance(text_plain, list) else str(text_plain)


def extract_outputs(notebook_path: Path, out_dir: Path) -> tuple[int, int]:
    """Write the PNG outputs and a text summary of a notebook to out_dir.

    Args:
        notebook_path: Path to the .ipynb file.
        out_dir: Output folder. It is created if it does not exist.

    Returns:
        The number of PNG files and the number of cells with text output.
    """
    notebook = json.loads(notebook_path.read_text())
    assert "cells" in notebook, f"{notebook_path} is not a notebook"
    out_dir.mkdir(parents=True, exist_ok=True)

    n_images = 0
    n_text_cells = 0
    summary_lines: list[str] = [f"# Outputs of {notebook_path.name}\n"]

    for cell_index, cell in enumerate(notebook["cells"]):
        if cell.get("cell_type") != "code" or not cell.get("outputs"):
            continue
        source = "".join(cell.get("source", []))
        first_line = source.strip().splitlines()[0] if source.strip() else ""
        cell_texts: list[str] = []

        for output_index, output in enumerate(cell["outputs"]):
            # Save each PNG output with a name that gives its cell position.
            png_b64 = output.get("data", {}).get("image/png")
            if png_b64:
                image_path = out_dir / f"cell{cell_index:03d}_{output_index}.png"
                image_path.write_bytes(base64.b64decode(png_b64))
                cell_texts.append(f"[image: {image_path.name}]")
                n_images += 1
            text = output_text(output).strip()
            if text and not png_b64:
                cell_texts.append(text[:MAX_TEXT_CHARS])

        if cell_texts:
            n_text_cells += 1
            summary_lines.append(f"## cell {cell_index}: `{first_line}`\n")
            summary_lines.append("```\n" + "\n".join(cell_texts) + "\n```\n")

    (out_dir / "outputs.md").write_text("\n".join(summary_lines))
    return n_images, n_text_cells


if __name__ == "__main__":
    assert len(sys.argv) == 3, __doc__
    n_images, n_text_cells = extract_outputs(Path(sys.argv[1]), Path(sys.argv[2]))
    print(f"{n_images} images, {n_text_cells} cells with output -> {sys.argv[2]}")
