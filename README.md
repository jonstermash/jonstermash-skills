# jonstermash-skills

A personal collection of [Agent Skills](https://code.claude.com/docs/en/skills) — reusable instruction sets that extend what an AI assistant can do well — packaged as an installable **Claude Code plugin marketplace**.

## Install

Add this repo as a marketplace, then install the plugin (in a Claude Code session or via the **`/plugin`** GUI):

```bash
/plugin marketplace add jonstermash/jonstermash-skills
/plugin install jonstermash-skills@jonstermash-skills
```

Or from your terminal:

```bash
claude plugin marketplace add jonstermash/jonstermash-skills
```

Once installed, every skill is available namespaced under the plugin, e.g. `/jonstermash-skills:make-it-make-sense`. New skills added to the repo arrive automatically on `/plugin marketplace update`.

## Skills

| Skill | What it does |
|-------|--------------|
| [make-it-make-sense](./plugins/jonstermash-skills/skills/make-it-make-sense/) | Zoom out and simplify any written or presented output so it's understandable on the first pass. |

## Layout

This repo is **both the marketplace and the plugin**. The marketplace catalog points at one bundled plugin that ships all the skills:

```
jonstermash-skills/
├── .claude-plugin/
│   └── marketplace.json              # marketplace catalog (read by /plugin GUI)
├── plugins/
│   └── jonstermash-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json           # plugin manifest
│       └── skills/
│           └── make-it-make-sense/
│               └── SKILL.md
└── README.md
```

## Adding a new skill

1. Create a new folder under `plugins/jonstermash-skills/skills/` named after the skill (kebab-case).
2. Add a `SKILL.md` with YAML frontmatter (`name`, `description`) followed by the instructions.
3. Bump `version` in both `.claude-plugin/marketplace.json` and `plugins/jonstermash-skills/.claude-plugin/plugin.json` so installs receive the update.
4. Add a row to the table above.
