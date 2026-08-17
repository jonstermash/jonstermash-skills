# mims-public

A public collection of [Agent Skills](https://code.claude.com/docs/en/skills) — reusable instruction sets that extend what an AI assistant can do well — packaged as an installable **Claude Code plugin marketplace**.

## Install

Add this repo as a marketplace, then install the plugin (in a Claude Code session or via the **`/plugin`** GUI):

```bash
/plugin marketplace add jonstermash/mims-public
/plugin install make-it-make-sense@mims-public
```

Or from your terminal:

```bash
claude plugin marketplace add jonstermash/mims-public
```

Once installed, invoke a skill by its short name — `/make-it-make-sense` or `/syco-killer`. The namespaced form, `/make-it-make-sense:make-it-make-sense`, also works and is the unambiguous fallback if two plugins ever share a skill name. New skills added to the repo arrive automatically on `/plugin marketplace update`.

**Naming**, since the repo and the plugin differ:

| | |
|---|---|
| Repo / marketplace | `mims-public` — a container that can hold more over time |
| Plugin | `make-it-make-sense`, displayed as **Make It Make Sense** |
| Skills | `/make-it-make-sense`, `/syco-killer` |

> **Renamed in v1.0.0** from `jonstermash-skills`. The marketplace and plugin IDs changed, so existing installs must remove the old marketplace and re-add it with the command above. The skills themselves keep their names.

## Skills

| Skill | What it does |
|-------|--------------|
| [make-it-make-sense](./plugins/make-it-make-sense/skills/make-it-make-sense/) | Zoom out and simplify any written or presented output so it's understandable on the first pass. |
| [syco-killer](./plugins/make-it-make-sense/skills/syco-killer/) | Sycophancy as an accuracy failure, not a tone problem. Four gates on the drafted response: the Open, the Judgment, the Challenge, the Close. Calibration, not contrarianism. |

### Arming syco-killer

`syco-killer` is the one skill that shouldn't wait to be summoned — a sycophantic response never feels sycophantic from the inside, so a skill that fires only when the model thinks it's relevant fires exactly never. It ships with a `UserPromptSubmit` hook that injects a compressed version of the rule ahead of **every** prompt in **every** session, regardless of where — or whether — you mention it.

The hook loads the rule early so it's *available*; the gates themselves run *last*, on the drafted response, because you can't filter a response you haven't written yet.

**Hooks are Claude Code CLI only.** The Claude apps don't run them, so there the always-on rule is delivered through **Settings → Instructions for Claude** instead. Same content, different mechanism:

| Surface | Skills work? | Always-on mechanism |
|---|---|---|
| Claude Code (CLI) | yes | the bundled hook — `/syco-killer` arms it |
| Claude apps (chat, desktop) | yes | Instructions for Claude — `/syco-killer --standing` prints the block |
| Claude Code in the desktop app | yes | neither reliably ([parity issue](https://github.com/anthropics/claude-code/issues/45514)) |

Both skills work when invoked in every surface. Only the *standing* behavior depends on the mechanism. Full text and testing procedure: [`references/standing-rule.md`](./plugins/make-it-make-sense/skills/syco-killer/references/standing-rule.md).

The hook is **opt-in**. Installing a writing plugin shouldn't silently rewrite how your assistant talks, so it emits nothing until you arm it:

```bash
/syco-killer          # arm it (all sessions, until disarmed)
/syco-killer off      # disarm
/syco-killer --audit  # review the recent turns of this conversation for tells
```

Arming and disarming just create and remove `~/.claude/syco-killer.on`, so you can also `touch` or `rm` that file yourself. The full procedure and tell-lists stay in the skill; the hook carries a ~35-line compression of it, which costs roughly 500 tokens on every turn — the price of a standing rule rather than an occasional one.

## Layout

This repo is **both the marketplace and the plugin**. The marketplace catalog points at one bundled plugin that ships all the skills:

```
mims-public/
├── .claude-plugin/
│   └── marketplace.json              # marketplace catalog (read by /plugin GUI)
├── plugins/
│   └── make-it-make-sense/
│       ├── .claude-plugin/
│       │   └── plugin.json           # plugin manifest
│       ├── hooks/
│       │   ├── hooks.json            # auto-discovered; registers the UserPromptSubmit hook
│       │   └── syco-killer.sh        # emits the kill switch, only while armed
│       └── skills/
│           ├── make-it-make-sense/
│           │   ├── SKILL.md
│           │   └── references/       # loaded on demand, per pass
│           └── syco-killer/
│               ├── SKILL.md
│               └── references/
└── README.md
```

## Adding a new skill

1. Create a new folder under `plugins/make-it-make-sense/skills/` named after the skill (kebab-case).
2. Add a `SKILL.md` with YAML frontmatter (`name`, `description`) followed by the instructions. Set `name` explicitly — without it, the invocation name falls back to the install directory, which for marketplace installs is a version string that changes on every update.
3. Bump `version` in both `.claude-plugin/marketplace.json` and `plugins/make-it-make-sense/.claude-plugin/plugin.json` so installs receive the update.
4. Add a row to the table above.
