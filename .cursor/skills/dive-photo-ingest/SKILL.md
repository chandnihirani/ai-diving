---
name: dive-photo-ingest
description: Ingests photos from DJI Osmo Action (or other cameras), stores them in per-dive folders, and tags them to dives by matching timestamps. Use when the user wants to import dive photos, ingest Osmo/Action camera photos, or tag photos to dives.
---

# Dive photo ingestion

Ingest photos from a source folder (e.g. DJI Osmo Action 5 Pro export), store them in **one folder per dive** under each trip, and **assign photos to dives automatically** using file/EXIF timestamps and a time-window rule for same-day dives.

## When to use

- User says they want to ingest/import dive photos, Osmo/Action photos, or tag photos to dives.
- User provides a path to a folder of dive photos and wants them organized and linked to dives.
- **Short trigger:** User says the default folder has new photos and to run ingest (e.g. "new photos in the folder, run the skill" or "ingest the new photos from my last 1/2/3 days of dives"). Use the saved default path—no need for them to paste the path again.

## Default source folder (saved path)

- **File:** `config/dive-photo-source.txt` — first non-empty line that is not a comment (`#`) is the default source folder path.
- When the user says "run photo ingest" / "new photos in the folder" / "ingest the new photos" **without** giving a path, use this path. If the file is missing or empty, ask for the path.
- User can give the path once; you save it to this file. After that, one short message from them ("new photos, run it") is enough—cheapest flow.

## Where photos are stored

- **Path:** `dives/[trip]/photos/dive-[#]-[site]/`
- Example: `dives/antigua/photos/dive-7-pillars-of-hercules/`
- One folder per dive; the dive’s `## Media` section in its `.md` file can link to this folder or list the photos.

## How photos are matched to dives

1. **Date:** Photo date (EXIF `DateTimeOriginal` or file modification time) is matched to the dive **date** from `divinglog.md` (and thus to a trip and dive number).
2. **Same day, multiple dives:** We do *not* have dive start/end clock times in the log. So for a given day we use a **gap-based rule**:
   - Sort all photos from that day by time.
   - Consecutive photos within **45 minutes** of each other are treated as one “window” (one dive).
   - A **gap of 60 minutes or more** between two photos starts the next window → next dive that day.
   - Assign window 1 → first dive on that date, window 2 → second dive, etc. (order from `divinglog.md`).
3. **Single dive on a date:** All photos from that date go to that dive (no window splitting needed).
4. **Photos with no matching dive date:** Keep in an `unassigned/` folder (e.g. under a staging path) or report for manual review; do not delete.

## How to give the source path (including Google Drive)

- **In chat:** User pastes or types the **full folder path** in the same message as the ingest request. No upload of files needed.
- **Getting the path on Mac (Google Drive):**
  1. In Finder, open **Google Drive → My Drive** and go to the folder that contains that day’s photos (e.g. `Dive photos/March 2025` or a folder you created for this trip).
  2. **Copy the path:** select the folder, then hold **Option (⌥)** and right‑click (or **Control+click**) the folder → choose **“Copy … as Pathname”** (path is now on the clipboard). If that menu item is missing, drag the folder into Terminal or a text field to get the path, or use **Get Info** and copy the path from the “Where” line.
  3. Paste that path into the chat, e.g. *“Ingest my dive photos from `/Users/user/Library/CloudStorage/GoogleDrive-xxx/My Drive/Dive photos/March_2025_trip`”*.
- **Typical Google Drive path shape:**  
  `/Users/<you>/Library/CloudStorage/GoogleDrive-<email>/My Drive/<folder>/<subfolder>`  
  or, if using the symlink:  
  `/Users/<you>/Google Drive/<folder>/<subfolder>`.

## Workflow

1. **Source:** User provides (or you assume) a single folder containing all photos to ingest (e.g. from Osmo Action export). Supported: JPEG, HEIC, PNG; videos (e.g. MP4) can use file mtime if EXIF is missing.
2. **Run the ingestion script** (see below) with that source path. It reads `divinglog.md`, groups photos by date and time windows, and copies files into `dives/[trip]/photos/dive-[#]-[site]/`.
3. **After the script:** Update each affected dive file’s **## Media** section with a short note and link to the photo folder (e.g. `Photos: [dive-7-pillars-of-hercules/](photos/dive-7-pillars-of-hercules/)` or list file count). Do not paste full file lists unless the user asks.

## Script

Run from the **project root**:

```bash
python scripts/ingest-dive-photos.py <source_photos_folder> [--dry-run] [--gap-minutes 45]
```

- **`source_photos_folder`:** Path to the folder containing the camera photos (absolute or relative to project root).
- **`--dry-run`:** Print which photos would be assigned to which dive; do not copy files.
- **`--gap-minutes`:** Minutes of gap between photos to start a new “dive window” on the same day (default 45).

The script:
- Parses `divinglog.md` for dive number, date, trip, and site (from the Detail link).
- Scans the source folder for image/video files; gets timestamp from EXIF or mtime.
- Groups by date, then by time windows (gap ≥ `gap_minutes`).
- Creates `dives/[trip]/photos/dive-[#]-[site]/` and copies (or in dry-run, only reports) files.
- Writes unassigned photos (no matching date) to a list or `photos/unassigned/` for review.

## Dependencies

Script requires Python 3 and:

- **exifread** (or Pillow for EXIF): `pip install exifread`
- Optional: **Pillow** for more formats: `pip install Pillow`

## Edge cases

- **No EXIF and no usable mtime:** Skip or put in unassigned; do not guess.
- **More time windows than dives that day:** Assign first N windows to the N dives; put the rest in unassigned and report.
- **Fewer windows than dives that day:** Some dives get no photos; that’s acceptable.
- **Different timezones:** Script uses naive local date/time from EXIF or file system; user should ingest from a machine in the same timezone as the dive location if possible.
