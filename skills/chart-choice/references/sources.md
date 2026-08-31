# Sources

Tags used across the references. Reachability checked 29 August 2026.

## Perception and theory

| Tag | Source | Used for | Status |
|---|---|---|---|
| [Cleveland-McGill 1984] | Cleveland and McGill, "Graphical Perception", JASA 79(387) | the channel ranking | paywalled; ranking taken from Munzner's chapter 5 slides |
| [Heer-Bostock 2010] | Heer and Bostock, "Crowdsourcing Graphical Perception", CHI 2010, https://idl.uw.edu/papers/crowdsourcing-graphical-perception | replication of the ranking; rectangular area measured worse than length | live (paper page; canonical PDF hosts down) |
| [Cleveland-McGill-McGill 1988] | banking to 45 degrees; Talbot et al. 2012 critique via https://homes.cs.washington.edu/~jheer/files/2006-Banking-InfoVis.pdf | aspect ratio zone | live |
| [Mackinlay 1986] | Mackinlay, "Automating the Design of Graphical Presentations", ACM TOG | expressiveness then effectiveness | paywalled; restated widely |
| [Munzner 2014] | Munzner, Visualization Analysis and Design, ch. 5; https://www.cs.ubc.ca/~tmm/courses/547-17/slides/marks-4x4.pdf | channel rankings, expressiveness and effectiveness principles | live |
| [Tufte 1983] | Tufte, The Visual Display of Quantitative Information; https://www.edwardtufte.com/notebook/ | data-ink, chartjunk, small multiples, lie factor | live |
| [Few 2004] | Few, "The Right Graph", https://www.perceptualedge.com/articles/ie/the_right_graph.pdf | seven message types, scale types, time on x, equal bins | live |
| [Few 2007] | Few, "Save the Pies for Dessert", https://www.perceptualedge.com/articles/visual_business_intelligence/save_the_pies_for_dessert.pdf | pie limits | live |
| [Few 2013] | Few, Bullet Graph Design Specification, https://www.perceptualedge.com/articles/misc/Bullet_Graph_Design_Spec.pdf | bullet graph, gridline and tick defaults | live |
| [Cairo 2019] | Cairo, How Charts Lie | zero baseline for length encodings, lines exempt | book; quoted second-hand |
| [Knaflic 2015] | Nussbaumer Knaflic, Storytelling with Data; https://www.storytellingwithdata.com/blog | declutter, focus attention, title as finding | live (blog) |
| [Correll 2020] | Correll, Bertini and Franconeri, "Truncating the Y-Axis: Threat or Menace?", CHI 2020, https://arxiv.org/pdf/1907.02035 | truncation exaggerates on every chart type; break cues do not help | live |
| [Berinato 2016] | Berinato, Good Charts | declarative versus exploratory | book |

## Choosers and taxonomies

| Tag | Source | Used for | Status |
|---|---|---|---|
| [Highcharts Chooser] | https://www.highcharts.com/chartchooser/ | objective x data type framing (the user's seed) | live |
| [FT Visual Vocabulary] | https://github.com/Financial-Times/chart-doctor/tree/main/visual-vocabulary | the nine intents (names referenced with attribution; FT's wording and artwork are not reproduced, the directory is FT all rights reserved) | live |
| [data-to-viz] | https://www.data-to-viz.com/ and /caveats.html | decision tree and 37 caveats; the single richest source for the checklist and anti-patterns | live |
| [Datawrapper] | https://www.datawrapper.de/blog/chart-types-guide and /blog/dualaxis/ | pie precision argument, dual-axis alternatives | live (old academy/blog subdomains redirect) |
| [Abela] | Abela's Chart Chooser | four-branch structure; subsumed by FT and Highcharts | original site dead |
| [Chartability] | https://chartability.fizz.studio/ and https://chartability.github.io/POUR-CAF/ | critical tests: single axis, no 3D, 5 categories, table present, title present, density | live |
| [WCAG 1.4.1] [WCAG 1.4.11] | https://www.w3.org/WAI/WCAG22/Understanding/use-of-color.html and non-text-contrast.html | colour never alone; 3:1 on marks (applied by `dataviz`) | live |

## Automated recommendation research (heuristics ported, code not copied)

| Tag | Source | Licence | Used for |
|---|---|---|---|
| [Draco] | uwdata/draco `asp/soft.lp`, `asp/weights.lp`, https://github.com/uwdata/draco | BSD-3-Clause | cardinality ceilings, `only_discrete`, `non_positional_pref`, `includes_zero` and `zero_skew` |
| [CompassQL] | vega/compassql `src/ranking/effectiveness/`, https://github.com/vega/compassql | BSD-3-Clause | the mark-by-axis-type-pair table and the aggregation switch |
| [VizML] | Hu et al., CHI 2019, arXiv:1808.04819 | paper (code unlicensed) | the column-profiling step |
| [LIDA] | Dibia 2023, https://github.com/microsoft/lida | MIT | semantic type per field; self-evaluation with a hard gate on "is this the right type" |
| [ChartGPT priors] | Tian et al., IEEE TVCG 2024, arXiv:2311.01920 | paper | one category plus a count -> bar; two raw quantities -> scatter; selection as its own visible step |
| [LLM4Vis] | arXiv:2310.07652 | paper | every recommendation ships with its reason and rejected alternatives |
| [VisEval] | arXiv | paper | readability is measured from geometry, not by looking at a render |

## Agent skills (ideas adapted, text not copied)

| Tag | Source | Licence | Used for |
|---|---|---|---|
| [Fabric] | microsoft/skills-for-fabric `powerbi-report-design/references/chart-selection.md`, https://github.com/microsoft/skills-for-fabric | MIT | cardinality table with behaviour-when-exceeded; precision-vs-pattern; >100x -> log |
| [dataviz-selector] | skthewimp, https://github.com/skthewimp/karthik-data-visualization-skill | MIT | cold selection on repair; table as a candidate form; total line plus breakdown; small multiples fully specified |
| [Alto-R] | Alto-R `chart-type-chooser` in nature-figure-craft, https://github.com/Alto-R/nature-figure-craft | CC-BY-4.0 | credit for the ideas of profiling the data before recommending, naming the rejected alternative and testing claims at two bin widths (no text reproduced) |
| [dataviz] | bundled Claude Code skill (first-party, compiled into the binary; references materialise under `/private/tmp/claude-501/bundled-skills/<version>/`) | no grant; quoted for boundaries only | "Is it even a chart?" and the series ladder, referenced not copied. Reconciled against the copy shipped with Claude Code 2.1.251; re-read `choosing-a-form.md`, `marks-and-anatomy.md` and `anti-patterns.md` after an upgrade (a `maintain` item) |

Unlicensed artefacts (openai/plugins, NTCoding, indi256s, inference-sh) were read for comparison; their numbers were re-derived from the licensed sources above or marked `[convention]`.
