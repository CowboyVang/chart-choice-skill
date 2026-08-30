# Taxonomy: intent x data shape -> form

Read top to bottom, stop at the first refusal. The nine intents are derived from the Financial Times Visual Vocabulary and Few's message types, with two renamed (magnitude -> comparison, correlation -> relationship). Every row carries a source tag; `[convention]` marks a threshold with no primary source, which you may override with a stated reason. Sources are listed in [sources.md](sources.md).

## Two gates, in order

1. **Expressiveness**: the form must show all the facts in the data and nothing the data does not contain (a line implies continuity, a stack implies a total, a map implies location matters). Reject inexpressive forms first. [Mackinlay 1986] [Munzner 2014]
2. **Effectiveness**: among the survivors, take the form that uses the higher-ranked channel. [Cleveland-McGill 1984]

Channel ranking for quantities, most accurate first: position on a common scale (bar, dot, line, scatter) > position on non-aligned scales (small multiples, non-bottom stacked segments) > length > angle or slope (pie, slope chart) > area (bubble, treemap) > colour luminance (heatmap) > volume (never). [Cleveland-McGill 1984] [Heer-Bostock 2010] [Munzner 2014]

Fill x and y before reaching for colour, size or shape. Quantities go on position, then size, then colour, never on shape. Categories go on position, then colour or shape, then a facet, never on size. [Draco] [CompassQL]

## Data-shape qualifiers

| Qualifier | Values that change the answer |
|---|---|
| `series` | 1 / 2 / 3 to 5 / 6+ |
| `cardinality` | categories on the discrete axis: <= 5 / 6 to 12 / 13 to 30 / 30+ |
| `scale` | nominal (no order) / ordinal (intrinsic order) / interval (bins of a quantity) / temporal [Few 2004] |
| `aggregated` | one row per category (summarised) / many raw rows per category |
| `negatives` | present / absent |
| `sums to whole` | parts are exclusive and exhaustive / they are not |
| `n` | < 8 / 8 to 30 / 30 to ~2000 / overplotted |

## The aggregation switch

Decide this before the form. The mark follows the axis-type pair and whether rows are aggregated. [CompassQL] [ChartGPT priors]

| x by y | Aggregated | Raw rows |
|---|---|---|
| quantity by category | bar | strip or tick plot (each row a mark) |
| quantity by quantity | scatter | scatter; hexbin or density past ~2000 points |
| quantity by time | line | points, or a line through aggregated periods |
| quantity by bins of itself | histogram (bar over an interval scale) | |
| category by category | heatmap of counts | aggregate first: raw rows occlude |

If every column is categorical, count or otherwise aggregate before charting. [Draco `only_discrete`]

## Power gates

Below these the form does not have enough data to carry its reading. [convention, re-derived from openai/plugins and Fabric numbers]

| Form | Wants at least | Below that use |
|---|---|---|
| line (trend) | 8 time points | columns, or points joined by a line (regular periods such as quarters may keep the line with markers: state why), or a table |
| scatter | 12 points | a labelled dot plot or a table |
| histogram or density | 30 values | strip plot showing every value |
| boxplot | 20 values per group, with raw points overlaid | strip plot |
| Sankey | 3 nodes per side | a bar |

"Trend" in the prompt does not pick a line; the shape does. Three points over time is a column chart.

## Cardinality ceilings and the behaviour when exceeded

| Where | Ceiling | Past it |
|---|---|---|
| nominal categories on an axis | 12 for columns or anything colour-coded; 30 for a sorted horizontal bar (this ceiling wins for a sorted bar) | top N plus "Other" with N under the ceiling, or a distribution chart instead [Draco] [Fabric] |
| ordinal categories | 30 | bin or aggregate [Draco] |
| categories on x | 50 | flip to horizontal, or aggregate [Draco] |
| series in one frame | 5 | highlight one and mute the rest, or small multiples [Tufte 1983] [dataviz ladder] |
| facet columns | 5 | facet rows instead, or drop panels [Draco] |
| histogram bins | 12 | wider bins; always check a second width [Draco] [data-to-viz] |
| pie slices | 5 | sorted bar [Few 2007] [Chartability] |
| legend entries | ~14 | the chart itself is wrong; fewer series [data-to-viz] |

Escalate inside a family before changing family: line -> highlighted line -> small multiples; bar -> dot or lollipop; scatter -> hexbin or density (where the surface has no hexbin: alpha blending, a stated sample and N shown). [convention]

## The table

USE is the default. ALT is acceptable when its condition holds. REFUSE is a hard stop with the perceptual reason.

### Not a chart

| Shape | USE | REFUSE |
|---|---|---|
| one number, maybe with a delta | stat tile (dataviz owns the tile spec) | a one-bar bar chart, a two-slice pie |
| a handful of headline numbers | KPI row of stat tiles | a grouped bar |
| exact values wanted, < 8 rows | a table | a chart the reader must read values off |
| a fact that fits a sentence | a sentence | any chart |
| more than ~7 classes that all carry meaning | a table, or table plus chart | more colours |

A well-formatted table is a form, a candidate on every pass, not a fallback. [dataviz "Is it even a chart?"] [dataviz-selector] [Fabric]

### Comparison (magnitude across nominal categories, one point in time)

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| `cardinality <= 12`, short labels | vertical column, zero baseline, sorted by value | lollipop when many similar-length bars shimmer; dot plot | line (implies continuity between unrelated categories); pie (angle judgement where position is available) [Few 2004] |
| `cardinality 13 to 30`, or long labels | horizontal bar, sorted descending | dot strip plot | rotated axis labels (flip the chart instead) [data-to-viz] |
| `cardinality 30+` | sorted horizontal bar of the top N with the rest grouped, or a distribution chart | treemap only when share, not value, is the question | every category shown unsorted (nothing legible) |
| `series = 2`, same measure | paired columns, or a dot plot with two dots per row | slope chart when the two are before and after; dumbbell | dual y axes |
| `series 3 to 5` | grouped columns, gap between groups larger than the gap inside a group | small multiples of single-series bars | grouped columns past 5 series (comparison across groups needs unaligned-scale judgements) [Cleveland-McGill 1984] |
| `negatives present` | bars from a zero rule line extending both ways | diverging bar | stacked bar (positive and negative segments stack incoherently) |

### Ranking (position in the order is the point)

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| any `cardinality` | ordered bar or column; descending to spotlight the top, ascending for the bottom | lollipop, dot strip, ordered proportional symbol | anything unsorted [Few 2004] |
| rank changes across periods | slope chart (2 periods) or bump chart (3+) | paired bar | a line of the values when the question is about position |

### Change over time

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| `series = 1`, `n >= 8` | line | area only when the value is cumulative or a stock | bars for a long dense series (bar-to-bar comparison fights the trend reading) [Few 2004] |
| `series = 1`, `n < 8` | column | points joined by a line | a line through 3 points (over-implies a trend) |
| `series 2 to 5` | multi-line, each line labelled at its end | small multiples | stacked area for non-cumulative series |
| `series 6+` | one highlighted line, the rest muted, or small multiples on an identical scale | | spaghetti (all lines in different colours: nothing traceable, legend exceeds working memory) [data-to-viz] |
| irregular or missing intervals | line with visible point markers, gaps left as gaps | step line for step-change quantities (a price, a rate) | interpolating across a gap without saying so |
| projection or uncertainty | line plus a shaded interval band | fan chart | a bare line implying the forecast is measured |
| cyclical, high volume | calendar heatmap or horizon chart | small multiples per cycle | |

### Part-to-whole

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| `sums to whole`, `cardinality <= 5`, coarse reading ("about half") | stacked bar on a percentage scale, or a single 100% bar | pie or donut only if ALL of: <= 5 slices, sorted largest first from 12 o'clock, every slice labelled, parts exhaustive [Few 2007] | pie for exact comparison (a 3% gap is visible in a bar and invisible in a pie) [Datawrapper]; a 2-slice pie (that is a stat tile or meter) |
| `sums to whole`, `cardinality 6+` | sorted bar of the shares | treemap when the data is hierarchical | pie, donut, any radial part-to-whole [Chartability] |
| parts do NOT sum to a whole | plain bar of the values | grouped bar | any part-to-whole form: stacking or slicing asserts a total that does not exist [data-to-viz] |
| composition over time | stacked column per period (few periods) or stacked area (many); add a total line if the total matters | 100% stacked when only the mix matters | comparing any series except the bottom one across periods (unaligned baseline) [Cleveland-McGill 1984] |
| build-up or bridge from start to end | waterfall | stacked bar with the running total annotated | |
| hierarchy, 2+ levels | treemap | sunburst or icicle for shape only | treemap for reading values (rectangular area is markedly less accurate than length) [Heer-Bostock 2010] |

### Distribution

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| `series = 1`, `n >= 30` | histogram, equal bins, checked at a second bin width | density curve, cumulative curve | unequal bins (rewrite the message silently) [Few 2004] |
| `series = 1`, `n < 30` | strip plot, every point shown | beeswarm | boxplot (hides sample size and shape) [data-to-viz] |
| `series 2 to 8` | boxplot or violin WITH the raw points overlaid | ridgeline, overlaid densities | boxplot alone when the data may be bimodal (identical boxes for very different data) [data-to-viz] |
| `series 9+` | ridgeline, or small-multiple histograms | heatmap of binned counts | overlaid translucent densities past a handful (mutual occlusion) |
| two groups, mirrored | population pyramid | paired bar | |

### Relationship

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| 2 quantities, `n < 2000` | scatter, both axes quantitative, no connecting line | fitted line only when a model is intended and stated | bar or line (categorical forms for non-categorical data) [Few 2004] |
| 2 quantities, overplotted | hexbin, 2D histogram or density contours | alpha blending plus a stated sample | an opaque blob presented as a scatter |
| a 3rd quantity | bubble, AREA proportional to the value | colour luminance for the third variable | radius proportional to value (squares the apparent difference) [data-to-viz] |
| 2 quantities plus time | connected scatter, start and end labelled | two small-multiple lines | two lines on dual axes |
| many variables | scatterplot matrix, or a correlation heatmap | parallel coordinates | radar with unrelated axes |
| 2 categories plus a count | heatmap, both axes sorted meaningfully | grouped bar when cardinality is small | |

### Deviation

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| vs a target or baseline | diverging bar from a zero rule, reference line drawn | bullet graph for one metric against a target with qualitative bands [Few 2013] | bars without the reference line (mental arithmetic forced on the reader) |
| over time | surplus/deficit line, filled above and below the reference | columns of the differences | two overlaid lines leaving the reader to subtract |
| ordered categories, opposing sentiment (Likert) | diverging stacked bar anchored at a neutral centre | | 100% stacked from the left edge (kills the negative-side comparison) |

### Flow

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| between states, volumes matter | Sankey | chord for symmetric flows | Sankey under ~3 nodes per side (a bar is clearer) [convention] |
| sequential with drop-off | waterfall, or a funnel with a common baseline | stacked bar with stage labels | a tapered funnel (width, area and perspective all vary at once) |
| network structure, not volume | node-link diagram | adjacency matrix when dense | node-link for a dense graph (hairball) |

### Spatial

| Shape switch | USE | ALT | REFUSE, and why |
|---|---|---|---|
| rates or densities by area | choropleth of a NORMALISED value | hex or tile cartogram when area sizes distort | choropleth of raw counts (it redraws the population map) [data-to-viz] |
| counts at points | proportional symbol map, area to value | dot density | choropleth for counts |
| geography incidental | a bar chart; do not draw a map | | a map drawn because the data has place names [FT Visual Vocabulary] |

## Selecting on a repair job

When asked to fix, tidy or improve an existing chart, run the selection cold: the current form gets no vote. A neater version of the wrong form is not a fix. If the cold pick differs from what exists, say so and let the user choose. [dataviz-selector]
