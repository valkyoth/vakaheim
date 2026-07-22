#!/usr/bin/env python3
"""Compare SPDX JSON after removing cargo-sbom run-specific metadata."""

from __future__ import annotations

import json
import sys
from pathlib import Path


def canonical(value: object) -> object:
    """Recursively canonicalize objects and list ordering."""
    if isinstance(value, dict):
        return {key: canonical(item) for key, item in sorted(value.items())}
    if isinstance(value, list):
        items = [canonical(item) for item in value]
        return sorted(items, key=encoded)
    return value


def encoded(value: object) -> str:
    """Encode one canonical JSON value."""
    return json.dumps(value, ensure_ascii=True, separators=(",", ":"), sort_keys=True)


def normalized(path: Path) -> object:
    """Read one SPDX document and discard per-run identity fields."""
    with path.open(encoding="utf-8") as handle:
        document = json.load(handle)
    if not isinstance(document, dict):
        raise ValueError(f"{path} must contain a JSON object")
    document.pop("documentNamespace", None)
    creation_info = document.get("creationInfo")
    if isinstance(creation_info, dict):
        creation_info.pop("created", None)
    return canonical(document)


def main(arguments: list[str]) -> int:
    """Compare two normalized SPDX documents."""
    if len(arguments) != 3:
        print("usage: compare_sbom.py EXPECTED GENERATED", file=sys.stderr)
        return 2
    if normalized(Path(arguments[1])) == normalized(Path(arguments[2])):
        print("committed SBOM matches the current dependency graph")
        return 0
    print("SBOM is stale; run scripts/generate-sbom.sh --write", file=sys.stderr)
    return 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
