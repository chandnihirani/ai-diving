#!/usr/bin/env python3
"""
Ingest dive photos: match by date + time windows (gap = new dive), copy into
dives/[trip]/photos/dive-[#]-[site]/.

Usage (from project root):
  python scripts/ingest-dive-photos.py <source_photos_folder> [--dry-run] [--gap-minutes 60]

Requires: pip install exifread
"""

import argparse
import re
import shutil
from datetime import datetime
from pathlib import Path
from typing import List, Optional

try:
    import exifread
except ImportError:
    exifread = None

# Date format in divinglog.md: "27 Mar 2024", "07 May 2025"
LOG_DATE_FMT = "%d %b %Y"
# EXIF format: "2024:03:27 10:30:00" or similar
EXIF_DATE_FMT = "%Y:%m:%d %H:%M:%S"

# Extensions we treat as photos/videos
MEDIA_EXT = {".jpg", ".jpeg", ".heic", ".png", ".mov", ".mp4", ".avi"}


def parse_divinglog(project_root: Path) -> List[dict]:
    """Parse divinglog.md table; return list of {num, date, trip, photo_folder} in order."""
    log_path = project_root / "divinglog.md"
    if not log_path.exists():
        raise FileNotFoundError(f"Not found: {log_path}")

    text = log_path.read_text(encoding="utf-8")
    lines = text.split("\n")
    dives = []
    # Find table rows: start with | and contain dives/
    link_re = re.compile(r"\]\((dives/[^)]+\.md)\)")
    for line in lines:
        if not line.strip().startswith("|") or "dives/" not in line:
            continue
        cells = [c.strip() for c in line.split("|")]
        if len(cells) < 3:
            continue
        num_s, date_s = cells[1], cells[2]
        if not num_s.isdigit() or not date_s:
            continue
        # Detail link is last cell (before trailing empty)
        detail = cells[-2] if cells[-1] == "" else cells[-1]
        m = link_re.search(detail)
        if not m:
            continue
        rel_path = m.group(1)  # e.g. dives/antigua/dive-7-pillars-of-hercules.md
        parts = rel_path.split("/")
        if len(parts) != 3:
            continue
        trip = parts[1]
        file_stem = Path(parts[2]).stem  # dive-7-pillars-of-hercules
        try:
            dt = datetime.strptime(date_s.strip(), LOG_DATE_FMT)
            date_only = dt.date()
        except ValueError:
            continue
        dives.append({
            "num": int(num_s),
            "date": date_only,
            "trip": trip,
            "photo_folder": file_stem,
        })
    return dives


def get_photo_timestamp(path: Path) -> Optional[datetime]:
    """Get capture time from EXIF or file mtime. Returns naive datetime or None."""
    # Try EXIF first (images)
    if exifread and path.suffix.lower() in {".jpg", ".jpeg", ".heic", ".png"}:
        try:
            with open(path, "rb") as f:
                tags = exifread.process_file(f, details=False)
            dt_str = tags.get("EXIF DateTimeOriginal") or tags.get("Image DateTime")
            if dt_str:
                s = str(dt_str).strip()
                # Handle "2024:03:27 10:30:00" or with timezone
                if " " in s:
                    s = s.split(" ")[0] + " " + s.split(" ")[1][:8]
                return datetime.strptime(s, EXIF_DATE_FMT)
        except Exception:
            pass
    # Fallback: file mtime
    try:
        mtime = path.stat().st_mtime
        return datetime.fromtimestamp(mtime)
    except OSError:
        return None


def collect_photos_with_times(source: Path) -> List[tuple]:
    """List media files under source with their timestamp. Sorted by time."""
    out = []
    for path in source.rglob("*"):
        if not path.is_file() or path.suffix.lower() not in MEDIA_EXT:
            continue
        ts = get_photo_timestamp(path)
        if ts is None:
            continue
        out.append((path, ts))
    out.sort(key=lambda x: x[1])
    return out


def group_by_date_then_windows(photos: list[tuple[Path, datetime]], gap_minutes: int) -> dict:
    """Group (path, datetime) by date, then split into windows when gap >= gap_minutes.
    Returns dict: date -> list of windows, each window = list of (path, datetime).
    """
    from collections import defaultdict
    by_date = defaultdict(list)
    for path, dt in photos:
        by_date[dt.date()].append((path, dt))

    result = {}
    for date in sorted(by_date.keys()):
        day_photos = by_date[date]
        day_photos.sort(key=lambda x: x[1])
        windows = []
        current = [day_photos[0]]
        for i in range(1, len(day_photos)):
            prev_ts = day_photos[i - 1][1]
            curr_ts = day_photos[i][1]
            if (curr_ts - prev_ts).total_seconds() >= gap_minutes * 60:
                windows.append(current)
                current = [day_photos[i]]
            else:
                current.append(day_photos[i])
        if current:
            windows.append(current)
        result[date] = windows
    return result


def main():
    parser = argparse.ArgumentParser(description="Ingest dive photos into per-dive folders by date and time windows.")
    parser.add_argument("source", type=Path, help="Folder containing photos to ingest")
    parser.add_argument("--dry-run", action="store_true", help="Only print assignments, do not copy")
    parser.add_argument("--gap-minutes", type=int, default=45, help="Gap in minutes to start next dive window (default 45)")
    parser.add_argument("--project-root", type=Path, default=None, help="Project root (default: parent of scripts/)")
    args = parser.parse_args()

    if args.project_root is None:
        args.project_root = Path(__file__).resolve().parent.parent
    source = args.source if args.source.is_absolute() else (args.project_root / args.source)
    if not source.is_dir():
        print(f"Error: source is not a directory: {source}")
        return 1

    if exifread is None:
        print("Warning: exifread not installed; using file mtime only. pip install exifread")

    dives = parse_divinglog(args.project_root)
    if not dives:
        print("Error: no dives parsed from divinglog.md")
        return 1

    # Dives per date in order (as in log)
    from collections import defaultdict
    dives_by_date = defaultdict(list)
    for d in dives:
        dives_by_date[d["date"]].append(d)

    photos = collect_photos_with_times(source)
    if not photos:
        print(f"No media files with usable timestamp under {source}")
        return 0

    grouped = group_by_date_then_windows(photos, args.gap_minutes)
    unassigned = []
    assignments = []  # (path, trip, photo_folder)

    for date, windows in grouped.items():
        day_dives = dives_by_date.get(date, [])
        for wi, window in enumerate(windows):
            if wi < len(day_dives):
                dive = day_dives[wi]
                for path, _ in window:
                    assignments.append((path, dive["trip"], dive["photo_folder"]))
            else:
                for path, _ in window:
                    unassigned.append((path, date))

    # Report and copy
    print(f"Assigned: {len(assignments)} files to dives. Unassigned (no dive or extra window): {len(unassigned)}")
    if unassigned:
        for path, date in unassigned[:20]:
            print(f"  unassigned: {path.name} ({date})")
        if len(unassigned) > 20:
            print(f"  ... and {len(unassigned) - 20} more")

    for path, trip, photo_folder in assignments:
        dest_dir = args.project_root / "dives" / trip / "photos" / photo_folder
        dest_dir.mkdir(parents=True, exist_ok=True)
        dest_file = dest_dir / path.name
        if dest_file.exists() and dest_file.stat().st_size == path.stat().st_size:
            continue  # skip duplicate
        if args.dry_run:
            print(f"  would copy: {path.name} -> dives/{trip}/photos/{photo_folder}/")
        else:
            shutil.copy2(path, dest_file)
            print(f"  copied: {path.name} -> dives/{trip}/photos/{photo_folder}/")

    if unassigned and not args.dry_run:
        unassigned_dir = args.project_root / "photos" / "unassigned"
        unassigned_dir.mkdir(parents=True, exist_ok=True)
        for path, _ in unassigned:
            shutil.copy2(path, unassigned_dir / path.name)
        print(f"Copied {len(unassigned)} unassigned to photos/unassigned/")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
