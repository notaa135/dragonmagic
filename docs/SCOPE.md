# Public repository scope

This is a selected portfolio from Taeyoung Noh's personal DragonMagic project. It shows product thinking, AI-assisted implementation, and evidence-based review through a small, readable set of artifacts.

## Included

- Four actual prototype runtime screenshots, led by the title screen.
- A dated progress record and verification summary.
- A concrete regression case study.
- One original GDScript source sample for learner-profile rules.
- A minimal Godot project, synthetic fixtures, behavioral checks, and a CI workflow.

## Source sample

`src/profile_resolver.gd` is an unchanged copy of the original project's `godot/Scripts/Quiz/profile_resolver.gd`.

It loads learner profiles and exposes settings for hints, timing, subjects, difficulty, and penalties. It also provides a default profile when the requested profile is unavailable. This makes user-facing behavior inspectable instead of leaving it implicit in a prompt.

The file illustrates one prototype component. It is not a complete learning engine, an independently validated educational model, or the full game. The included test harness exercises it with newly authored synthetic profiles; the original profile data is not required or included.

The harness, fixtures, and workflow were added for this September 2026 portfolio publication. They are separate from the project's historical game tests.

## Image provenance

All images are unchanged Godot runtime captures from May 17–18, 2026. The title comes from the original project's UI review handoff; the other three come from the later rescue worktree:

| Public file | Original repository-relative file |
|---|---|
| `assets/title-screen-runtime.png` | `_handoff_dragonmagic_review/screenshots_all_ui/title/title_screen__runtime_direct_mcp__20260517_211000.png` |
| `assets/stage-select-runtime.png` | `REPORTS/rescue/baseline_captures/03_stage_select.png` |
| `assets/hub-runtime.png` | `REPORTS/rescue/baseline_captures/02_hub_screen.png` |
| `assets/math-practice-runtime.png` | `REPORTS/rescue/baseline_captures/06_math_question_state.png` |

The title capture is identified as runtime evidence in `_handoff_dragonmagic_review/14_UI_SCREENSHOT_AUDIT.md`. Later static UI mockups and motion studies are not presented as implemented gameplay.

## Kept outside this selection

The full game, development history, quiz dataset, third-party add-ons, reference collections, raw artwork, account integrations, and internal agent logs remain outside this repository. This selection makes no blanket redistribution claim for those materials.

The project was developed with AI assistance. Taeyoung's contribution centers on product requirements, workflow direction, review criteria, and acceptance decisions, alongside hands-on prototype testing and iteration.
