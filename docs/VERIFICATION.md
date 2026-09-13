# Verification record

Checks are listed with their dates and scope so a reviewer can tell what was actually demonstrated.

## Public source checks — September 13, 2026

The unchanged `src/profile_resolver.gd` was run in Godot 4.6.1 with two synthetic learner profiles:

```bash
godot --headless --path . --script res://tests/profile_resolver_test.gd
```

Local result: **31 passed, 0 failed; exit code 0**.

The checks cover an unloaded fallback, a configured default, an unknown profile ID, an explicit profile, timer and hint policies, difficulty limits, subject restrictions, zero-valued settings, and missing-setting defaults. The fixture contains no personal or original quiz data.

These are fresh component-level checks, not a new complete-game test. The original source was not changed to make the checks pass.

The public workflow downloads the official Godot 4.6.1 Linux release, verifies its SHA-256 digest, and runs the same command on Ubuntu. A workflow file establishes the repeatable process; its run status is visible in GitHub Actions after publication.

## Original-project data check — September 13, 2026

The original project was checked with:

```bash
python3 scripts/validate_quiz_data.py --clean-only
```

Recorded output:

```text
Items validated: 1324
Errors: 0
Warnings: 0
PASS
```

The validator checks required fields, unique IDs, answer-key consistency, duplicate question conflicts, review states, and source metadata. Approved items also require student and parent explanations. The command excludes files marked as quarantine or archive by their leading underscore.

This result establishes structural consistency. It does not establish that every question is factually correct, educationally effective, or cleared for redistribution. The original dataset and validator are outside this public selection.

## Historical runtime evidence

| Date | Check | Recorded outcome |
|---|---|---|
| May 2, 2026 | Instantiate 14 selected scenes after reversing a broken cleanup | 14/14 passed the recorded smoke check |
| May 2, 2026 | Headless parse check for that reviewed revision | Exit 0; no parse errors reported |
| May 17, 2026 | Direct Godot runtime title capture in the UI review handoff | Title screen selected as the main portfolio image |
| May 18, 2026 | Capture prototype scenes through Godot MCP | 11 runtime images collected; three selected for this repository |

These checks were not rerun as a full-game test for the September portfolio publication.

## Why rendered evidence matters

The May 18 capture report records a failed headless screenshot attempt: a null viewport image prevented a usable capture. The reviewer switched to runtime capture and obtained the requested evidence. A successful parse check would not have answered the visual question.

## Original evidence locations

Paths below are relative to the original development repository, not links to files bundled here:

- `scripts/validate_quiz_data.py`
- `_handoff_dragonmagic_review/14_UI_SCREENSHOT_AUDIT.md`
- `REPORTS/research/r_p14h/smoke/_REPORT.md`
- `REPORTS/research/r_p14h/regression/_REPORT.md`
- `REPORTS/rescue/baseline_capture_report.md` in the later rescue worktree

## Acceptance approach

Define the expected behavior, choose the check that can establish it, inspect the result, and record remaining limitations. Keep code checks, runtime observations, and design approval as separate decisions.
