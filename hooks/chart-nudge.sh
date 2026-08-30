#!/usr/bin/env bash
# PreToolUse hook (Write|Edit|NotebookEdit): when the text being written contains
# chart code and the chart-choice skill has not been loaded in this session, deny
# the write ONCE per session and agent with a reason that tells the model to load
# the skill and re-issue. Belt and braces for the case where the prompt never
# said "chart" and the description-driven trigger did not fire.
#
# "Loaded this session" means a Skill tool_use record for chart-choice in the
# session transcript or, for a subagent, in its own transcript
# (<session>/subagents/agent-<agent_id>.jsonl). Subagent hook input carries the
# parent's session_id and transcript_path plus its own agent_id.
#
# Fails open: any error exits 0 with no output, so a broken hook never blocks a
# write. Opt out with CHART_NUDGE=0 in the environment or a .chart-nudge-off
# file in the working directory. Markers self-clean after 14 days.
set +e
[ "${CHART_NUDGE:-1}" = "0" ] && exit 0

STATE="$HOME/.claude/state"
payload="$(cat)" || exit 0
[ -n "$payload" ] || exit 0
command -v jq >/dev/null 2>&1 || exit 0

field() { printf '%s' "$payload" | jq -r "$1" 2>/dev/null; }

cwd="$(field '.cwd // empty')"
[ -n "$cwd" ] && [ -f "$cwd/.chart-nudge-off" ] && exit 0

session_id="$(field '.session_id // "nosession"')"
agent_id="$(field '.agent_id // empty')"
marker="$STATE/chart-nudged-${session_id}-${agent_id:-main}"
[ -f "$marker" ] && exit 0

# Only the text being written: never file paths, cwd or old_string.
text="$(field '.tool_input | [(.content // ""), (.new_string // ""), (.new_source // "")] | join("\n")')"
[ -n "$text" ] || exit 0

# Code-shaped tokens only; bare library names in prose do not count.
PATTERN='import (matplotlib|seaborn|plotly|altair|bokeh|plotnine)|from (matplotlib|seaborn|plotly|altair|bokeh|plotnine)|matplotlib\.pyplot|\bplt\.(plot|bar|barh|scatter|hist|pie|subplots)\(|alt\.Chart\(|\.plot\((kind|x=|y=)|from ["'"'"'](recharts|react-chartjs-2|echarts|apexcharts|highcharts|@observablehq/plot|@nivo|victory|@visx)|require\(["'"'"'](recharts|chart\.js|echarts|apexcharts|highcharts)|new Chart\(|echarts\.init\(|ApexCharts\(|Highcharts\.chart\(|Plot\.plot\(|vegaEmbed\(|vega-lite/v|vega\.github\.io/schema|d3\.scale|scale(Linear|Band|Time|Log)\(|xychart-beta|quadrantChart|^\s*pie\b|visualType|lns(XY|Pie|Metric|Datatable|Heatmap)|"type": *"(timeseries|barchart|piechart|xychart|histogram|bargauge)"|mini-graph-card|apexcharts-card|health_utils|svg_(line_chart|bar_chart|scatter_plot)\('
printf '%s' "$text" | grep -qiE "$PATTERN" 2>/dev/null || exit 0

# Already loaded per the transcript? Match the Skill tool_use record, not a mention.
loaded_in() { [ -n "$1" ] && [ -r "$1" ] && grep -qE '"name":\s*"Skill".{0,60}"skill":\s*"chart-choice"' "$1" 2>/dev/null; }
transcript="$(field '.transcript_path // empty')"
loaded_in "$transcript" && exit 0
if [ -n "$agent_id" ] && [ -n "$transcript" ]; then
  loaded_in "${transcript%.jsonl}/subagents/agent-${agent_id}.jsonl" && exit 0
fi

mkdir -p "$STATE" 2>/dev/null || exit 0
find "$STATE" -maxdepth 1 -name 'chart-nudged-*' -mtime +14 -delete 2>/dev/null
: > "$marker" 2>/dev/null

cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"[chart-choice] This write contains chart code and the chart-choice skill has not been loaded in this session. Invoke the chart-choice skill (Skill tool, skill: chart-choice), decide the form and run its ten visibility checks, then re-issue this write; it will not be blocked again this session. If you cannot load skills, re-issue the write as is."}}
JSON
exit 0
