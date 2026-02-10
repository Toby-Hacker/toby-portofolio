#!/usr/bin/env python3
"""Rename all PNGs in this folder to explotel-mobile-app-<num>.png."""

from __future__ import annotations

from pathlib import Path


def main() -> None:
    folder = Path(__file__).resolve().parent
    pngs = sorted([p for p in folder.iterdir() if p.is_file() and p.suffix.lower() == ".png"])

    if not pngs:
        print("No PNG files found.")
        return

    # Step 1: rename to temp to avoid collisions
    temp_files = []
    for idx, p in enumerate(pngs, start=1):
        tmp = p.with_name(f"__tmp_{idx:03d}.png")
        p.rename(tmp)
        temp_files.append(tmp)

    # Step 2: rename to final pattern
    for idx, p in enumerate(temp_files, start=1):
        target = p.with_name(f"explotel-mobile-app-{idx}.png")
        p.rename(target)

    print(f"Renamed {len(temp_files)} file(s).")


if __name__ == "__main__":
    main()
