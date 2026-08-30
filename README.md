# chart-choice-skill

A skill for coding agents (Claude Code and Codex) that decides what a chart should be before any chart code is written.

## The problem

Ask an agent to visualise something and it reaches for chart code immediately. It never checks what the data actually supports: how many rows, what type each column is, whether the values are raw or already aggregated, where the thresholds sit. The result looks like a chart and answers nothing, and you spend longer adjusting it than it took to draw: the axis starts in the wrong place, the series you care about is buried among five others, the aggregation is a mean of a mean nobody stated, and the threshold the whole reading depends on is not drawn.

This repo packages the fix as two agent skills: profile the data first, decide the form from what the data supports (a table or a sentence are legal answers), and run ten visibility checks before handing off to whatever renders the chart.

## What is in here

| Path | What |
|------|------|
| `skills/chart-choice/` | The main skill: data profiling, form selection, the ten checks. References hold the full taxonomy, an anti-pattern list, a visibility checklist, per-surface notes and sources. |
| `skills/chart-review/` | Companion skill: audit an existing chart (code, spec, screenshot or URL) against the same rules. Findings only; it rebuilds nothing unless asked. |
| `hooks/chart-nudge.sh` | Optional Claude Code hook: denies a session's first chart-code write if chart-choice was never loaded, once, with a reason. Fails open. |
| `case-study/` | Three real Home Assistant dashboard views reviewed and reworked under the skill, with before and after screenshots and every rule that fired named. |
| `research/` | The raw notes the skill was built from: best practice, prior art, an environment survey and invocation design. |

## How it works

The skill runs six steps before any rendering decision:

1. Profile the data: per column, type and cardinality; per table, row count, aggregation state, negatives, whether parts sum to a whole.
2. Draft the finding as one sentence. It becomes the title.
3. Classify the intent (comparison, ranking, change over time, part-to-whole, distribution, relationship, deviation, flow, spatial), then check whether this is a chart at all. One number is a stat tile; under eight exact values is a table; one fact is a sentence.
4. Pick the form from the taxonomy: expressiveness first, then the channel ranking (position beats length beats angle beats area beats colour).
5. Run the ten checks: baseline and range, sort, time on x, no secondary y axis, series count, labels, aggregation stated, aspect ratio, numbers reconcile, gaps stay gaps.
6. Hand off with one line the user can overrule:

   `Form: <form> (<intent>, <shape>). Rejected: <alternative>, because <reason>. Deviations: <none | list>.`

On a repair the existing chart gets no vote: the form is selected cold, as if the chart did not exist.

## Install

Clone, then copy the two skill folders into your agent's skills directory.

Claude Code:

```sh
git clone https://github.com/CowboyVang/chart-choice-skill.git
cp -R chart-choice-skill/skills/chart-choice ~/.claude/skills/
cp -R chart-choice-skill/skills/chart-review ~/.claude/skills/
```

Codex (CLI 0.149 or later reads the same SKILL.md format):

```sh
cp -R chart-choice-skill/skills/chart-choice ~/.codex/skills/
cp -R chart-choice-skill/skills/chart-review ~/.codex/skills/
```

chart-choice loads on its description when a chart is about to be chosen or written. chart-review is marked manual-invoke for Claude Code (`/chart-review <file, image, URL or spec>`); Codex may surface it differently.

### The hook (Claude Code only)

The skills fire on wording. When a prompt never says "chart" and the agent goes straight to plotting code, nothing triggers. The hook covers that gap: it greps the text about to be written for chart code, checks the session transcript for a chart-choice load, and denies the write once with instructions to load the skill and retry. Opt out with `CHART_NUDGE=0` in the environment or a `.chart-nudge-off` file in the working directory.

```sh
cp chart-choice-skill/hooks/chart-nudge.sh ~/.claude/hooks/
```

Then register it in `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit|NotebookEdit",
        "hooks": [
          {
            "type": "command",
            "command": "bash \"$HOME/.claude/hooks/chart-nudge.sh\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

The script depends on `jq` and on Claude Code's transcript layout; it is not portable to Codex.

## Does it work?

The case study answers with one real rework: three Home Assistant dashboard views, reviewed with chart-review and rebuilt with chart-choice driving every decision. Selected results:

- 11 threshold lines drawn where there had been none, on dashboards whose entire vocabulary is thresholds.
- One view went from five charts to three; its height dropped from 3,441 px to 1,580 px, with nothing lost.
- Two recently built, carefully made charts failed cold selection outright: hours running down the page instead of left to right, and 336 columns doing the job of two lines.
- Ten placeholder hours were being drawn as real data; check 10 (gaps stay gaps) caught what a visual polish never would have.
- The skill also got 13 things wrong or missed them; they are listed in the case study against file and line.

## Adapting it to your environment

Two files are meant to be edited after install:

- `skills/chart-choice/references/surfaces.md` maps forms to rendering surfaces (Artifact HTML, Grafana, Home Assistant cards, ADX dashboards, Mermaid, Python, the terminal). The product facts are portable; the conventions came from one environment. Re-survey yours, delete the surfaces you do not use and add the ones you do.
- The hand-off step assumes a palette and a page-craft skill may exist. In Claude Code, colour and marks go to the bundled `dataviz` skill. Codex has no equivalent; the form decision and the ten checks still run, and colour is then yours.

## Licence

MIT. The research notes and case study describe one specific environment; the numbers in them are real.
