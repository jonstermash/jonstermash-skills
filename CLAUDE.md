# CLAUDE.md

Working notes for this repo. Read before editing anything under `plugins/`.

## What this repo is

`mims-public` is both a marketplace and a plugin. `.claude-plugin/marketplace.json` is the catalog the `/plugin` GUI reads; it points at one bundled plugin, `make-it-make-sense`, which ships all the skills and one hook.

```
mims-public/
├── .claude-plugin/marketplace.json          # marketplace catalog
├── plugins/make-it-make-sense/
│   ├── .claude-plugin/plugin.json           # plugin manifest
│   ├── BUILD                                # generated build stamp — never hand-edit
│   ├── hooks/                               # hooks.json + syco-killer.sh (UserPromptSubmit)
│   └── skills/<skill-name>/
│       ├── SKILL.md
│       └── references/                      # loaded on demand
├── scripts/stamp-build.sh                   # writes and verifies BUILD
├── docs/design/
├── CHANGELOG.md
└── README.md
```

No test suite and no dependencies. Everything shipped is markdown, JSON, and one bash hook. The only build step is the stamp below.

## Rules that break installs if you miss them

**Set `name:` explicitly in every SKILL.md frontmatter.** Without it the invocation name falls back to the install directory, which for marketplace installs is a version string that changes on every update. The skill silently becomes uninvocable.

**Bump `version` in both files, together.** `.claude-plugin/marketplace.json` and `plugins/make-it-make-sense/.claude-plugin/plugin.json`. Bump only one and existing installs never receive the update. This is the step most easily lost in a PR — it has already been lost once, so check both before committing:

```bash
grep -h '"version"' .claude-plugin/marketplace.json plugins/make-it-make-sense/.claude-plugin/plugin.json
```

**Re-stamp `BUILD` whenever a shipped plugin file changes.** `scripts/stamp-build.sh` records the version and a content hash over the plugin tree, and the hook prints that line into context on every prompt. Skip the re-stamp and every running session reports a build that isn't the one it's running. Verify with `scripts/stamp-build.sh --check` — it exits 1 on drift. `BUILD` is generated; edit the script, never the stamp.

**Don't rename the marketplace or plugin IDs.** The v1.0.0 rename from `jonstermash-skills` forced every existing install to remove and re-add the marketplace. Treat the IDs as frozen.

## Adding a skill

1. New folder under `plugins/make-it-make-sense/skills/`, kebab-case.
2. `SKILL.md` with YAML frontmatter (`name`, `description`) then the instructions.
3. Bump `version` in both manifests.
4. Run `scripts/stamp-build.sh`.
5. Add a row to the skills table in `README.md`.
6. Add a `CHANGELOG.md` entry.

## Writing a SKILL.md

The house pattern, visible in both existing skills:

- **The description is the trigger.** It's what the model reads when deciding whether to fire, so it carries the cues, the default posture, and the "when in doubt" instruction — not just a summary of what the skill does. The cap is 1,536 characters across `name` + `description` combined.
- **SKILL.md is self-sufficient.** Tell-lists, examples, and edge cases live in `references/` and load on demand, but the skill's checks must fire from SKILL.md alone. A check that needs a reference open is a check that doesn't run.
- **Moves state in one line each,** with the reference file named inline where the detail lives.
- **Procedures beat rule-lists.** A skill that reads as fifteen loose rules gets partially applied; a skill that reads as ordered passes with a gate at the end of each gets run.

## Editing prose in this repo

Skills, README, and CHANGELOG are all read by people deciding whether to install something. Run `/make-it-make-sense` over any substantial prose edit before committing.
