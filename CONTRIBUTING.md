# Contributing

Thanks for your interest in contributing to stitch-to-nextjs!

## How to contribute

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Test with a real Stitch design
5. Submit a pull request

## What to contribute

- **Bug fixes** - If the skill generates incorrect CSS, wrong font mappings, or broken components
- **New framework targets** - React (non-Next.js), Svelte, Vue, Astro
- **Better validation** - Automated visual regression testing, Playwright comparisons
- **Edge case handling** - Complex layouts, animations, responsive patterns
- **Documentation** - Examples, tutorials, better explanations

## Skill file format

The main skill lives at `skills/stitch-to-nextjs/SKILL.md`. It's a standard Claude Code skill file with YAML frontmatter:

```yaml
---
description: What the skill does
argument-hint: Expected arguments
allowed-tools: Comma-separated tool list
---

[Skill instructions in markdown]
```

## Guidelines

- Keep the skill focused on pixel-perfect fidelity
- Don't add approximations or "close enough" fallbacks
- Test with real Stitch designs before submitting
- Update the font mapping table if Stitch adds new fonts
- Update examples if you change the output format

## Code of Conduct

Be respectful. We're all here to build better tools.
