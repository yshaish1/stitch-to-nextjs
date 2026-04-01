# Quick Start

Get up and running in under 2 minutes.

## Step 1: Install the plugin

Add the marketplace to your `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "stitch-to-nextjs": {
      "source": {
        "source": "github",
        "repo": "yshaish1/stitch-to-nextjs"
      }
    }
  }
}
```

Then restart Claude Code and run:

```
/plugin install stitch-to-nextjs
```

This installs the skill and auto-configures the MCP server for HTML export and screenshots.

## Step 2: Authenticate with Google (one-time)

```bash
npx @_davideast/stitch-mcp init
```

Follow the wizard to authenticate with Google. This is a one-time setup.

## Step 3: Restart Claude Code

The plugin and MCP server load on restart.

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

## Alternative: Manual install (without plugin)

If you prefer not to use the plugin system:

```bash
curl -o ~/.claude/commands/stitch-to-nextjs.md \
  https://raw.githubusercontent.com/yshaish1/stitch-to-nextjs/main/skills/stitch-to-nextjs/SKILL.md
```

You'll need to manually configure the MCP server. See the [README](README.md#manual-mcp-configuration) for details.

## Next steps

- Read the [full README](README.md) for detailed documentation
- Check the [examples](skills/stitch-to-nextjs/examples/) for real-world usage
- See the [font mapping reference](skills/stitch-to-nextjs/references/font-mapping.md) for all supported fonts
