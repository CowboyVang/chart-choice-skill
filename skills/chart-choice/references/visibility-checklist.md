# Visibility checklist

Run every item. Each has a one-line reason and a source (see [sources.md](sources.md)). Colour rules are not here: `dataviz` owns colour, CVD safety, legend presence and the table view, and its rules stand alongside these.

## Scale and axes

| # | Rule | Why | Source |
|---|---|---|---|
| S1 | Bars, columns and areas start the quantitative axis at zero. No exceptions. | Length encodes the value; a truncated baseline breaks proportionality. | [Few 2004] [Cairo 2019] [Tufte 1983] |
| S2 | Lines, dot plots and scatters may start above zero. They encode by position and slope, which a moved baseline does not distort. | | [Cairo 2019] |
| S3 | That exemption is not a licence. Truncation exaggerates the perceived effect on bars and lines alike (the types tested), and an axis-break marker does not undo it. Set the range to the effect size that is meaningful and say what the range is (subtitle or axis title). | Measured across chart types, including ones designed to warn the reader. | [Correll 2020] |
| S4 | Do not force zero when the data already spans it, or when the distance to zero dwarfs the range (a series at 10,000 +/- 50 on a zero-based line is a flat line hiding the signal); a dot or line chart with a stated range is the honest form. | Zero is a rule for length encodings, not a virtue in itself. | [Draco `includes_zero`, `zero_skew`] |
| S5 | Time on the horizontal axis, running left to right. | Convention is an encoding; violating it makes readers misread. | [Few 2004] |
| S6 | Log scale only when the question is about multiplicative change or the data spans 3+ orders of magnitude; label the axis as logarithmic. Never log-scale a bar chart. | On a log scale bar length is no longer proportional to value. | [data-to-viz] |
| S7 | Equal bin widths on any interval scale, and check the chart at a second bin width before shipping. | Unequal bins rewrite the message silently; one width can manufacture or hide a mode. | [Few 2004] [data-to-viz] |
| S8 | Aspect ratio: aim for average line slopes near 45 degrees. A target zone, not a law (shallower average slopes also test well); reject extreme ratios in either direction. | Slope judgements are most accurate near 45 degrees. | [Cleveland-McGill-McGill 1988] [Talbot 2012] |
| S9 | No secondary y axis. Two units: two charts, or index both series to a common base, or plot one and annotate the other. | Two scales make adjacent marks look comparable when they are not; the crossing point is a design choice, not a fact. | [Datawrapper] [Chartability] |
| S10 | Magnitude span over 100x in one series: log scale or split the chart. | Linear scale flattens everything but the largest value. | [Fabric] |

## Order, labelling and focus

| # | Rule | Why | Source |
|---|---|---|---|
| L1 | Sort by value, descending, unless the category is ordinal, interval or temporal, in which case keep the intrinsic order. Sort ascending only to spotlight the low end. Panels in a set share one order; a fixed reference order (a league table, a questionnaire) may override. | An unsorted nominal chart forces the reader to sort by eye; sorting is the cheapest readability gain. | [Few 2004] [data-to-viz] |
| L2 | Direct-label the series that answers the question at the mark (line end, bar end). The legend `dataviz` requires for 2+ series stays as the identity fallback. | A legend costs a lookup round trip per mark. | [Knaflic 2015] [data-to-viz] |
| L3 | Highlight the one series that answers the question and mute the rest (dataviz's muted slot), kept for context. Decide WHICH series here; `dataviz` renders the emphasis. | Salience must match importance. | [Munzner 2014] [Knaflic 2015] |
| L4 | Annotate the point, bar or crossing that answers the question, in words, on the chart. | Annotation turns a data display into an answer. | [Knaflic 2015] [data-to-viz] |
| L5 | The title states the finding ("European sales fell 12% in Q3"), not the topic ("European sales by quarter"). Topic goes in the subtitle or axis titles. | The title is the only guaranteed-read text. | [Knaflic 2015] [Cairo 2019] |
| L6 | Every chart carries a title or caption and a note on how to read it when the form is unusual. | Two of Chartability's critical failures are "no explanation of purpose" and "no title, summary or caption". | [Chartability] |
| L7 | Numbers: consistent significant figures within a series, thousands separators, units in the axis title not on every tick, percentages marked, currency and basis (nominal or real) stated. | Inconsistent precision reads as noise and invites false precision. | [Tufte 1983] [Few 2004] |
| L8 | Reference lines (target, average, zero, threshold, an event date) are drawn whenever the reading is "above or below X". | Without the line the reader does mental arithmetic. | [Few 2004] [data-to-viz] |

## Density, decluttering and splitting

| # | Rule | Why | Source |
|---|---|---|---|
| D1 | Past 5 series in one frame, or on any occlusion, split into small multiples. Every panel on an IDENTICAL scale and in the same category order, panels labelled, and state the grid (rows x columns), the panel order (by value, alphabetical, geographic) and shared-vs-free scales. | Small multiples turn an unreadable overlay into repeated common-scale comparisons; a differing panel scale destroys the point. | [Tufte 1983] [data-to-viz] [dataviz-selector] |
| D2 | Facet along the axis that makes the compared quantity align. | Horizontal versus vertical faceting changes what the reader compares. | [data-to-viz] |
| D3 | Delete non-data ink: chart borders, background fills, shadows, 3D, redundant labels, heavy ticks. | Non-data ink competes with data ink in the same visual channel. "Above all else show the data." | [Tufte 1983] |
| D4 | Gridlines: none by default; light horizontal ones only when values must be read off the axis, behind the marks. | Gridlines are decoding aids, not decoration. | [Tufte 1983] [Few 2013] |
| D5 | Ticks: as few as read cleanly (axis ends plus a small number of round values). | | [Few 2013] |
| D6 | Adjacent marks need visible separation so nothing hides another mark. | Occluded marks are invisible data. | [Chartability] |
| D7 | When density is wrong for the frame (overplotted scatter, hairball, 40 bars in 200px), change the form or the aggregation, not the styling. | A critical accessibility failure, not a cosmetic one. | [Chartability] |
| D8 | Data-volume ladder: under ~20 marks, direct labels are fine; 20 to 500, standard marks; 500 to 5000, aggregate or filter; past 5000, aggregation is mandatory. | | [convention] |
| D9 | N and the period are stated, and the source rows stay reachable. `dataviz` specifies the table view; this skill does not add a second one. | Numbers with no stated N or period cannot be checked. | [Chartability] |

## Form-specific guards

| # | Rule | Why | Source |
|---|---|---|---|
| F1 | Pie or donut, all conditions or refuse: <= 5 slices, parts exhaustive and summing to a real whole, sorted largest first from 12 o'clock, every slice labelled. If it needs the labels to be readable, it has already failed: use a bar. | Slice magnitude is readable only near 0, 25, 50, 75 and 100%. | [Few 2007] [Chartability] |
| F2 | Stacked bars: only the bottom series sits on a common baseline. If any other series must be compared across categories, unstack it, or add a total line and a separate breakdown. | Every non-bottom segment is a length judgement on an unaligned scale. | [Cleveland-McGill 1984] [dataviz-selector] |
| F3 | Grouped bars: the gap between groups is visibly larger than the gap within a group. | Proximity is the grouping cue. | [data-to-viz] |
| F4 | Bubbles and proportional symbols: AREA to value, never radius. Say so. | Radius scaling squares the apparent difference. | [data-to-viz] [Cleveland-McGill 1984] |
| F5 | Bullet graph for one metric against a target: one linear scale from zero, a featured-measure bar about a third the thickness of its track, comparative measures as perpendicular ticks, 2 to 5 muted qualitative bands. If the scale must start above zero, the featured measure becomes a dot, not a bar. | Few's specification; the replacement for a gauge. | [Few 2013] |
| F6 | Connect points only when x is ordered and continuous. | Connecting unordered points asserts a sequence that does not exist. | [data-to-viz] |
| F7 | Choropleths get normalised values (per population, per area). | An unnormalised choropleth is a population map. | [data-to-viz] |
| F8 | Check the arithmetic on screen: percentages that should sum to 100 do, stacked totals match stated totals, derived values are recomputed from source. | Numbers that do not add up destroy trust in the chart. | [data-to-viz] |
| F9 | Before aggregating, check for Simpson's paradox: if the pooled trend and the subgroup trends disagree, show both. | The aggregate can be accurate and still tell the opposite of the truth. | [data-to-viz] |
| F10 | On a multi-chart report, four or more all-line panels means the forms were not chosen per question. Re-run selection per panel. | | [convention] |
