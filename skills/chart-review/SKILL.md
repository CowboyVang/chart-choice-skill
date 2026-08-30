---
name: chart-review
description: Review, audit or critique an existing chart against the chart-choice taxonomy and ten visibility checks. Reports findings; rebuilds nothing unless asked. /chart-review <file, image, URL or pasted spec>
disable-model-invocation: true
argument-hint: [chart file, screenshot, URL or spec]
---

# Chart review

Findings, not a rebuild. Run the same decision the `chart-choice` skill makes when building, but against a chart that already exists, and report where it falls short. If the user then wants it fixed, that is a repair job for `chart-choice` (cold selection).

## Procedure

1. **Load the rules.** Invoke the `chart-choice` skill (Skill tool) for the procedure, the ten checks and the reference links. Its references hold the taxonomy, the full checklist and the anti-pattern list; open them as its steps say.
2. **Read the chart.** Accept any of: code (Python, HTML, JS), a spec (Grafana, ADX or Lens JSON, Mermaid, Vega-Lite), a screenshot (Read the image), a URL (fetch or open it), or a pasted description. Record: the form as drawn, the data it encodes (exact values from code or a spec; read off the marks from an image, marked approximate), axis ranges, sort order, series count, labels, title, annotations. From an image alone, mark every check that needs the numbers as provisional.
3. **Name the question.** What is the chart trying to answer? Take it from the title, caption or surrounding text; if none, infer it and say so. Draft the finding sentence the chart should carry.
4. **Cold selection.** Run chart-choice steps 1 to 4 with the drawn form given no vote. Verdict: keep, or change to a named form with the reason. A neater version of the wrong form is not a keep.
5. **The ten checks.** Score each pass, fail or cannot tell, with the evidence (axis min and max, sort order, N, width:height, the title text). Then match against the anti-pattern list.
6. **Colour.** Not this skill's domain (`dataviz` owns it). Flag only the two failures a reviewer cannot pass over: colour as the sole encoding, and a rainbow ramp on ordered data. Point at `dataviz` for the rest.
7. **Report** in this shape, then stop. Do not rebuild, restyle or write files unless the user asks.

```
Question the chart answers: <one sentence, or "unclear: inferred as ...">
Verdict: keep <form> | change to <form>, because <reason>
Checks:
  1 baseline and range: pass | fail | cannot tell (<evidence>)
  2 sort: ...
  ... 10 gaps and scale: ...
Anti-patterns: <names, or none>
Colour flags: <none | colour-only encoding | rainbow ramp>
Fixes, by effect:
  1. <the change that most improves what the reader can see>
  2. ...
  3. ...
```

Order the fixes by effect on the reader: wrong form first, then invisible data (baseline, sort, highlight, labels), then polish. Three fixes at most; if the form is wrong, that is fix 1 and the rest are conditional on it.
