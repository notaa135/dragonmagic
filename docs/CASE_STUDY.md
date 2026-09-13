# Case study: a cleanup that broke stage selection

**A documented May 2026 regression from the AI-assisted DragonMagic project.**

## Intended change

A cleanup removed scene nodes that appeared to have no remaining references. The goal was to simplify the stage-selection scene while preserving its behavior.

## What went wrong

The script assembled some node names at runtime. For example, it looked up a badge using `"Badge_" + idx` rather than writing each full name in the code.

A search for a literal name such as `Badge_5` therefore missed a real dependency. Removing the matching nodes caused a missing-node error and then an assignment on a null value when the stage-selection scene loaded. This interrupted navigation from the hub toward battle.

## Evidence and response

| Review step | Finding or action |
|---|---|
| Expected behavior | The scene loads with stage cards, badges, and entry icons. |
| Runtime observation | `Node not found: "Badge_5"`, followed by an invalid assignment on a null instance. |
| Cause analysis | Badge and stage-card nodes were referenced through dynamically assembled names. |
| Correction | Reverse the cleanup and restore the removed nodes. |
| Follow-up | The recorded smoke check passed across 14 selected scenes after the reversal. |

The historical record identifies the cleanup as `395480e` and the corrective reversal as `99bc11d`. These are original-project revision references; the development history is not included in this portfolio.

## What I carry forward

In directing and reviewing AI-assisted work, I require evidence for the claim being made. “No literal references found” supports a narrow search result; it does not establish that a scene element is safe to remove.

For a similar change, the review should include dynamic name patterns, the scene's expected entry path, and a runtime check of the affected screen. The correction should also explain why the original check missed the dependency.

This case illustrates the project's review process. It does not claim that I independently wrote every implementation change or that the historical smoke check establishes complete gameplay coverage.

## Source record

Original repository paths:

- `REPORTS/research/r_p14h/tickets/P0-SMOKE-stage_select-P14F-4-regression.md`
- `REPORTS/research/r_p14h/smoke/_REPORT.md`
- `REPORTS/research/r_p14h/regression/_REPORT.md`

This public account summarizes those records. Raw agent conversations and the complete internal report collection are not published.
