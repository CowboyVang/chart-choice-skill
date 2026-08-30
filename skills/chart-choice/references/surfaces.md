# Surfaces

Pick the form first, then check the surface. When the surface cannot draw the form, take the nearest form listed here and say so in the hand-off line.

This file is inherently environment-specific. The product facts below (what each surface can draw, the nearest-form substitutions) are portable; the conventions came from a survey of one environment. After installing, re-survey your own surfaces, delete the sections you do not use and add the ones you do. The pattern to copy: per surface, what it can draw, what governs it and the nearest form for each intent it cannot draw.

## Artifact HTML (the `Artifact` tool, Claude Code)

- Draws anything. Two routes: hand-built inline SVG following `dataviz` (its mark specs assume this), or a library from the CDN allowlist (cdnjs, jsdelivr `/npm/`): Chart.js, ECharts, Plotly, Vega-Lite (`vega`, `vega-lite`, `vega-embed`), D3, Observable Plot. Pin exact versions; UMD builds.
- Mermaid renders natively (```mermaid fence or `<pre class="mermaid">`), so `xychart-beta` and `pie` need no library.
- Light and dark theme tokens are required; load `dataviz` for the palette scoping and your frontend-craft skill for the page around the chart.
- Nearest forms: everything is available, so no substitutions.

## `diagram-design` plugin

- Editorial illustration on a fixed 1000x500 canvas, one focal element, hand-placed SVG. chart-choice never selects this surface; it is used only when the user chose it or the deliverable is explicitly an editorial diagram, never for analysis output or live data.
- Data forms and hard caps: bar (8 bars; horizontal past 8 or with long labels), dumbbell, line (5 series, 4 to 12 points), slope, ridgeline, scatter (5 to 30 points; more -> density contour), bubble, treemap (8 cells), radar (5 axes, 5 series), polar lollipop (8 categories, 1 series), Sankey (3 stages, 8 nodes, 12 flows), Gantt (12 tasks), pyramid or funnel (6 layers), quadrant (12 items).
- Missing: pie, histogram, box, violin, map, stacked bar, area, waterfall, numeric heatmap, bullet.
- Offered but refused by the taxonomy: radar (unrelated axes), polar lollipop (radial magnitude), pyramid or funnel when tapered. Do not pick them because the surface has them.
- Nearest forms: part-to-whole -> treemap (share only) or a bar of shares; distribution -> ridgeline; deviation -> dumbbell; a target -> bar with an annotation callout.
- Its own colour system (paper, ink, muted, accent) replaces `dataviz`'s palette; do not mix the two.

## Kibana Lens

- By-value panel JSON is practical for: metric (`lnsMetric`), XY with `preferredSeriesType: bar_stacked` (`lnsXY`), pie shaped as donut and as treemap (`lnsPie`). Lens itself also offers line, area, horizontal and unstacked bars, heatmap and datatable; build those from the Lens UI or adapt the XY JSON.
- Nearest forms: distribution -> a date histogram or a terms-bucket bar; relationship -> not available (no scatter in Lens by-value JSON), use a table or a Vega visualisation; ranking -> horizontal bar, terms agg sorted by metric; single value -> metric.

## Home Assistant cards

- Widely available custom cards: `mini-graph-card` (line, and bar via `chart_type: bar`) and `apexcharts-card` (`line`, `column`, `area`; also pie, donut, scatter and radialBar). radialBar is a gauge and the taxonomy refuses it.
- Set explicit series colours per card; avoid `shades` mode, which invents colours the palette does not own.
- Nearest forms: ranking or comparison -> apexcharts column, sorted in the query; part-to-whole -> stacked column or a table; distribution -> not available, aggregate to a line of percentiles; a single value -> a stat card, not a chart.

## Grafana

- Core panels: `timeseries`, `table`, `stat`, `xychart`, `state-timeline`, barchart, bargauge, histogram, heatmap, piechart, candlestick.
- Nearest forms: ranking -> barchart (horizontal, sorted in SQL); part-to-whole -> stacked barchart, not piechart; deviation -> timeseries with a threshold line; distribution -> histogram panel; scatter -> xychart.

## Azure Data Explorer dashboards

- 16 native `visualType`s: table, markdownCard, timechart, card, bar, column, multistat, pie, heatmap, map, stackedarea, stackedcolumn, anomalychart, scatter, area, stackedbar, plotly.
- Nearest forms: distribution -> `plotly` (histogram or box via the plotly visual), or a `column` over binned buckets; ranking -> `bar` sorted in KQL (`| order by`); a single value -> `card` or `multistat`; deviation over time -> `anomalychart`; bullet -> not available, use `card` with conditional formatting.

## Mermaid (wiki pages, READMEs, Artifacts)

- Data forms: `xychart-beta` (bar and line, optionally both in one chart; no scatter, no stacking, no per-bar colour), `pie` (values only, no ordering control beyond input order; the pie gate still applies), `quadrantChart`, `sankey-beta`.
- A data chart must survive every renderer the page passes through (an editor's bundled Mermaid, a static site build); `xychart-beta` needs Mermaid 10.6+, so verify on the weakest renderer before relying on it.
- Nearest forms: anything beyond bar, line, pie or quadrant -> a Markdown table in the page, or an SVG file committed alongside.

## Python

- Check what is installed before choosing (matplotlib, plotly, seaborn, altair, bokeh, plotext). Installing matplotlib is fine when a script needs it; say so, and keep the same visibility checklist.
- With no library, hand-rolled SVG helpers cover line, scatter and bar only. A histogram is a bar over bins computed in Python; a highlighted series is a second call with the muted series first.

## Terminal

- With no TUI plotting tool installed, the form is a text table, sorted; a column of `#` characters is acceptable for a quick ranking. Do not install a plotter for a one-off.

## `design` canvas skill

- Mockups and layouts, not data charts. A chart inside an artboard is placeholder SVG; if the numbers matter, build the chart in an Artifact instead.
