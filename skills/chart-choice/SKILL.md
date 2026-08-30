---
name: chart-choice
description: Load this first, before dataviz, whenever a chart, graph, plot, sparkline or dashboard panel is about to be chosen, written or repaired and the output is visual. Triggers on the data's job, not only the word chart (compare categories, trend or change over time, share of a whole, breakdown of a total, distribution, ranking, correlation between two measures, deviation from a target) and on wording like "which chart", "best way to show this", "visualise these numbers". Decides the form (a table or a sentence are legal answers) and what must stay visible: baseline, axis range, sort order, the highlighted series, labels, aggregation level. dataviz then owns colour, marks and interaction. Not for flowcharts, sequence, architecture or org diagrams, and not for computing or tabulating numbers with no visual output; a data chart drawn through any other skill or rendering surface still counts.
---

# Chart choice

Form first, colour last. This skill decides which form shows the data and whether the important data stays visible. It never states a colour rule: `dataviz` owns colour, marks, interaction, legend presence and the table view; a palette skill, if you run one, supplies the palette values; a frontend-craft skill such as `impeccable` owns the page around the chart; `diagram-design` is a surface you use only when the user chose it, never one this skill selects.

## Procedure

1. **Profile the data.** Per column: type (quantity, category, ordered category, time), semantic type (money, rate, count, id, place), unique count, and whether it is a monotone sequence (that column is x). Per table: row count, aggregated or raw, negatives present, parts sum to a whole, target surface. Done when every column has a type and the five flags are set.
   - No data in hand: ask for it, or state the assumed shape (rows, columns, cardinality) and mark the choice provisional.
   - Query-backed surface (Lens, Grafana, ADX, Home Assistant): profile from the query instead: group-by fields, time bucket, metric, expected cardinality.
2. **Draft the finding.** One sentence that answers the question; it becomes the title. Done when it names a subject and a shape, direction, magnitude or absence of one ("no relationship between sleep and pace" counts). For an exploratory prompt the finding is provisional: confirm or rewrite it after step 5.
3. **Classify the intent**: comparison, ranking, change over time, part-to-whole, distribution, relationship, deviation, flow, spatial. Intent is the primary key; data shape switches inside it. Then the not-a-chart check: one number is a stat tile, a handful of headline numbers a KPI row, exact values for under 8 rows a table, one fact a sentence. Done when one intent is named and the not-a-chart check has a yes or no. Where this verdict and `dataviz`'s "Is it even a chart?" table differ, this verdict stands.
4. **Pick the form** from [references/taxonomy.md](references/taxonomy.md): expressiveness gate, then the channel ranking (position on a common scale beats length beats angle beats area beats colour), then the aggregation switch. On a repair, select cold: the existing form gets no vote, and open [references/anti-patterns.md](references/anti-patterns.md). If `dataviz` is already loaded, its job-table pick is provisional; this step decides. If the surface cannot draw the form, [references/surfaces.md](references/surfaces.md) names the nearest one; return here with it as a constraint and say so in the hand-off line. Done when one form is chosen and the strongest rejected alternative is named with its reason.
5. **Run the ten checks** below. Open [references/visibility-checklist.md](references/visibility-checklist.md) when any item is unclear, when the form is a histogram, scatter, pie, stacked, bullet or small multiples, or on a repair. Done when each item is satisfied with its evidence stated, or the deviation is stated.
6. **Hand off.** Load `dataviz` if it is not already loaded, for colour, marks and interaction; do not re-run its job table. Put your palette's values into `dataviz`'s palette slots at runtime (custom properties in the output; the bundled file is never edited). Load your frontend-craft skill, if you run one, when the chart lives in a page. When delegating chart code to a subagent, put the hand-off line and the ten checks in the brief. Done when this line has been emitted, so the user can overrule it:

   `Form: <form> (<intent>, <shape>). Rejected: <alternative>, because <reason>. Deviations: <none | list>.`

## The ten checks

1. **Baseline and range.** Bars, columns and areas start at zero. Lines, dots and scatters may not; then the range matches the meaningful effect size and the subtitle or axis title states it. Evidence: axis min, max and the effect size in the same units. Truncation exaggerates on bars and lines alike, and an axis-break marker does not undo it.
2. **Sort.** By value unless the category is ordinal or time. Descending to spotlight the top, ascending for the bottom. Panels in a set share one order; a fixed reference order (a league table, a questionnaire) may override.
3. **Time** on the horizontal axis, left to right.
4. **No secondary y axis.** Two units: two charts, or index both to a common base.
5. **One series or many.** Question about one series: highlight it and mute the rest (dataviz's muted slot). Question about all of them, or past 5 series, or any occlusion: small multiples on an identical scale and order, with the grid and panel order stated.
6. **Labels.** The answering series is labelled at the mark; the answering point is annotated in words.
7. **Aggregation level.** State raw or summarised, which statistic (sum, mean, median, count), N, bin width (checked at a second width) and how outliers were handled. All-categorical data is counted first.
8. **Aspect ratio.** Average slopes near 45 degrees, no extreme ratio. Evidence: width:height.
9. **Numbers reconcile.** Parts sum to the stated total, percentages to 100, derived values recomputed from source; N and the period stated.
10. **Gaps and scale.** Missing intervals stay gaps, never interpolated; a log or otherwise non-linear axis says so in its title; bars are never log-scaled.

## Where this meets dataviz

Reconciled against the `dataviz` shipped with Claude Code 2.1.251. Re-check after an upgrade.

- **Legend.** dataviz keeps a legend for 2+ series. This skill labels the answering series at the mark and never removes that legend.
- **Pie.** dataviz refuses a 2-slice pie and a pie for close values. This skill allows a pie only if all of: 5 or fewer slices, parts sum to a real whole, sorted largest first from 12 o'clock, every slice labelled, coarse reading. Narrower than dataviz, never wider.
- **Series.** dataviz's colour ladder caps at 7 to 8. This skill splits or highlights past 5.
- **Not a chart.** Both run the check; this skill's verdict stands (step 3).
