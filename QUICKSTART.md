# Quick Start

Get up and running in under 2 minutes.

## Step 1: Install the skill

```bash
curl -o ~/.claude/commands/stitch-to-nextjs.md \
  https://raw.githubusercontent.com/shaishmini/stitch-to-nextjs/main/skills/stitch-to-nextjs/SKILL.md
```

## Step 2: (Recommended) Install stitch-mcp for HTML export

```bash
npx @_davideast/stitch-mcp init
```

Follow the wizard to authenticate with Google. Then add to your project's `.mcp.json`:

```json
{
  "mcpServers": {
    "stitch-dev": {
      "command": "npx",
      "args": ["-y", "@_davideast/stitch-mcp", "proxy"]
    }
  }
}
```

## Step 3: Restart Claude Code

The new skill and MCP server load on restart.

## Step 4: Use it

Open Claude Code in your Next.js project directory and run:

```
/stitch-to-nextjs list
```

This will list your Stitch projects and screens. Pick one and the skill converts it into a pixel-perfect Next.js component.

## What you get

```
src/components/stitch/YourScreen/
  YourScreen.tsx          # Pixel-perfect Next.js component
  YourScreen.client.tsx   # Interactive parts (if needed)
  index.ts                # Re-export

public/assets/stitch/your-screen/
  hero-image.png          # Downloaded images
  stitch-reference.png    # Screenshot for comparison
```

Plus:
- Fonts added to your `layout.tsx` via `next/font/google`
- Tailwind config extended with design tokens
- A validation checklist to verify everything matches

## Next steps

- Read the [full README](README.md) for detailed documentation
- Check the [examples](skills/stitch-to-nextjs/examples/) for real-world usage
- See the [font mapping reference](skills/stitch-to-nextjs/references/font-mapping.md) for all supported fonts
