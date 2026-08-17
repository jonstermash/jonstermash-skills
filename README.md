# make-it-make-sense

A personal collection of [Agent Skills](https://code.claude.com/docs/en/skills) — reusable instruction sets that extend what an AI assistant can do well — packaged as an installable **Claude Code plugin marketplace**.

## Install

Add this repo as a marketplace, then install the plugin (in a Claude Code session or via the **`/plugin`** GUI):

```bash
/plugin marketplace add jonstermash/make-it-make-sense
/plugin install make-it-make-sense@make-it-make-sense
```

Or from your terminal:

```bash
claude plugin marketplace add jonstermash/make-it-make-sense
```

Once installed, invoke a skill by its short name — `/make-it-make-sense`. The namespaced form, `/make-it-make-sense:make-it-make-sense`, also works and is the unambiguous fallback if two plugins ever share a skill name. New skills added to the repo arrive automatically on `/plugin marketplace update`.

> **Renamed from `jonstermash-skills` (v0.6.0).** If you installed under the old name, remove the old marketplace and re-add it with the command above.

## Skills

| Skill | What it does |
|-------|--------------|
| [make-it-make-sense](./plugins/make-it-make-sense/skills/make-it-make-sense/) | Zoom out and simplify any written or presented output so it's understandable on the first pass. |

## Layout

This repo is **both the marketplace and the plugin**. The marketplace catalog points at one bundled plugin that ships all the skills:

```
make-it-make-sense/
├── .claude-plugin/
│   └── marketplace.json              # marketplace catalog (read by /plugin GUI)
├── plugins/
│   └── make-it-make-sense/
│       ├── .claude-plugin/
│       │   └── plugin.json           # plugin manifest
│       └── skills/
│           └── make-it-make-sense/
│               └── SKILL.md
└── README.md
```

## Adding a new skill

1. Create a new folder under `plugins/make-it-make-sense/skills/` named after the skill (kebab-case).
2. Add a `SKILL.md` with YAML frontmatter (`name`, `description`) followed by the instructions.
3. Bump `version` in both `.claude-plugin/marketplace.json` and `plugins/make-it-make-sense/.claude-plugin/plugin.json` so installs receive the update.
4. Add a row to the table above.
