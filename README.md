# jonstermash-skills

A personal collection of Agent Skills — reusable instruction sets that extend what an AI assistant can do well.

## Layout

Each skill lives in its own top-level folder containing a `SKILL.md` file (plus any supporting scripts or assets that skill needs):

```
jonstermash-skills/
├── README.md
└── make-it-make-sense/
    └── SKILL.md
```

## Skills

| Skill | What it does |
|-------|--------------|
| [make-it-make-sense](./make-it-make-sense/) | Zoom out and simplify any written or presented output so it's understandable on the first pass. |

## Adding a new skill

1. Create a new folder named after the skill (kebab-case).
2. Add a `SKILL.md` with YAML frontmatter (`name`, `description`) followed by the instructions.
3. Add a row to the table above.
