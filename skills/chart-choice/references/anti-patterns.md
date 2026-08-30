# Anti-patterns

Each entry: what it is, the perceptual reason, what to do instead. Colour anti-patterns (rainbow ramps, colour as the only encoding, generated hues) live in `dataviz` and are not repeated here.

| Anti-pattern | Perceptual reason | Instead |
|---|---|---|
| Truncated bar axis | Length is the encoding; cutting the baseline breaks proportionality and inflates the perceived effect. Marking the break does not undo it. [Tufte 1983] [Correll 2020] | Zero baseline, or a dot plot or line where position is the encoding |
| Dual y axes | The two scales are arbitrary, so the crossing point and relative gaps are a design choice; proximity makes readers compare incomparable marks. [Datawrapper] | Side-by-side charts, an indexed chart (both as % change from a base), one series plotted with the other annotated, or a connected scatter |
| Stacked bars used to compare a non-bottom series | Only the bottom segment rests on a common baseline. [Cleveland-McGill 1984] | Grouped bars or small multiples; keep the stack only for the total plus the bottom series |
| Pie with many slices | Angle is rank 4 of 8 for quantity and readable only near the cardinal positions. [Few 2007] | Sorted bar on a percentage scale |
| Donut | The pie's angle problem minus the centre, so the reader judges arc length on a radius. [Few 2007] | Bar, or a single 100% stacked bar |
| Two-slice pie or one-bar bar chart | One number does not need a form. | Stat tile or meter (`dataviz` specifies them) |
| Area chart for non-cumulative data | Area asserts the space under the line means something; for a rate, price or index it does not. [FT Visual Vocabulary] | Line |
| Stacked area for series that must be compared | Every band except the bottom has a wandering baseline. [Cleveland-McGill 1984] | Small multiples, or 100% stacked when only the mix matters |
| Bubble sized by radius | Differences are squared: 3x the value looks 9x. [data-to-viz] | Area-proportional bubbles, or a bar |
| Treemap for reading values | Rectangular area is markedly less accurate than length. [Heer-Bostock 2010] | Treemap for hierarchy and rough share only; bars for values |
| Spaghetti line chart | Past a handful of lines, mutual occlusion plus a large legend exceeds working memory. [data-to-viz] | One highlighted line with the rest muted, or small multiples |
| 3D anything | Volume is the last-ranked channel, and perspective renders equal values at different sizes by depth. [Cleveland-McGill 1984] [Chartability] | The 2D form of the same chart |
| Radar with unrelated axes | Different units per axis, the plotted area depends on the arbitrary axis order, and area is a weak channel. [data-to-viz] | Small-multiple bars, or parallel coordinates when the axes are commensurable |
| Radial bar chart | Outer bars sweep more arc for the same value. [data-to-viz] | Straight bars |
| Gauge or radial meter | Wastes space and reads less efficiently than a linear scale for one measure. [Few 2013] | Bullet graph |
| Word cloud | Word size conflates area with string length; no common scale; position is arbitrary. | Sorted bar of frequencies |
| Unsorted nominal bar chart | Forces the reader to sort by eye. [Few 2004] | Sort by value |
| Legend with many entries | Each mark costs a lookup; past ~14 the chart itself is wrong. [data-to-viz] | Direct labels, fewer series, an "Other" bucket |
| Choropleth of raw counts | It renders the population distribution whatever the variable. [data-to-viz] | Normalise, or a proportional symbol map |
| Boxplot alone for small or bimodal samples | The box hides sample size and shape. [data-to-viz] | Overlay the raw points, or a violin or ridgeline |
| Overplotted scatter shown as a scatter | An opaque blob shows extent but hides density and outliers. [data-to-viz] | Hexbin, 2D histogram, contours, or alpha with a stated sample |
| Mental arithmetic forced on the reader | Two overlaid series when the question is the difference; bars without their reference line. [Few 2004] | Plot the difference; draw the reference line |
| Moire from many similar-length bars | Near-equal parallel edges shimmer. [data-to-viz] | Lollipop, or fewer categories |
| Chartjunk: shadows, gradients, textures, icons, heavy frames | Non-data ink competes with data ink. [Tufte 1983] | Delete it |
| Rotated or angled category labels | Rotated text is measurably slower to read. [data-to-viz] | Horizontal bar chart |
| Map drawn because the data has place names | Geography is justified only when location or spatial pattern is the reader's question. [FT Visual Vocabulary] | Ranked bar |
| Counter-intuitive direction (time right to left, reversed axes, red for good) | Readers decode against convention before they decode the data. [data-to-viz] | Follow the convention, or annotate the deviation loudly |
| Encodings that change across a chart set | The same mark meaning different things per panel forces re-learning. [data-to-viz] | Fix the mapping once for the set |
| A line chart because the prompt said "trend" | Keyword matching, not the data shape, picked the form. Three points are not a trend. | Run the taxonomy on the shape |
| Tidying the wrong form | A neater version of an illegible form is not a fix. [dataviz-selector] | Cold selection: the existing form gets no vote |
| A chart where a table or a sentence would do | Exact values wanted, few rows, or one fact. | Table, or a sentence |
