#!/usr/bin/env python
"""
Auto-import common modules into IPython with aliases.

Put this file into:
    ~/.ipython/profile_default/startup/
"""

import importlib
import sys

ALIASES = {
    "np": "numpy",
    "pd": "pandas",
    "plt": "matplotlib.pyplot",
    "sns": "seaborn",
    "torch": "torch",
    "scipy": "scipy",
    "it": "itertools",
}


def _auto_import(aliases):
    for alias, modname in aliases.items():
        try:
            module = importlib.import_module(modname)
        except Exception as exc:
            # Print but don't crash IPython startup
            print(
                f"[ipython-startup] Failed to import '{modname}' as '{alias}': {exc}",
                file=sys.stderr,
            )
            continue

        globals()[alias] = module
        print(f"[ipython-startup] Imported '{modname}' as '{alias}'")


_auto_import(ALIASES)
del _auto_import  # avoid leaving helper in the namespace
