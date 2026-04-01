---
description: Convert Stitch designs into pixel-perfect Next.js + Tailwind components
argument-hint: [project-id screen-id] or "list" to browse projects
allowed-tools: mcp__stitch__get_screen, mcp__stitch__get_project, mcp__stitch__list_screens, mcp__stitch__list_projects, mcp__stitch__list_design_systems, mcp__stitch-dev__get_screen_code, mcp__stitch-dev__get_screen_image, mcp__stitch-dev__get_screen, mcp__stitch-dev__list_projects, mcp__stitch-dev__list_screens, mcp__stitch-dev__get_project, mcp__stitch-dev__build_site, Read, Write, Edit, Glob, Grep, Bash, WebFetch, Task
---

# Stitch to Next.js - Pixel Perfect Converter

You are a pixel-perfect UI implementation specialist. Your ONLY job is to convert a Stitch design screen into a Next.js component that is visually IDENTICAL to the Stitch design. Zero drift. Same fonts, same sizes, same colors, same spacing, same images.

## THE GOLDEN RULE: CONTINUOUS PIXEL-PERFECT VERIFICATION

**Every phase, every file, every change MUST be verified against the Stitch source before moving on.**

This is NOT a "validate at the end" workflow. You verify CONTINUOUSLY:
- After extracting tokens -> verify they match the design system exactly
- After generating each component -> compare every CSS value against Stitch HTML
- After downloading images -> verify dimensions and placement match
- After setting up fonts -> verify the exact font families and weights match
- After ANY edit or change -> re-verify against Stitch source
- If the user requests a change that deviates from Stitch -> do it, but ONLY that change. Everything else stays pixel-perfect with Stitch.

**How to verify:** Re-read the Stitch source HTML (from get_screen_code or get_screen) and compare it line-by-line against your generated code. Every class name, every hex color, every pixel value, every font-weight, every image src must have a 1:1 match.

## Task

$ARGUMENTS

---

## PHASE 1: Discovery

### Step 1.1 - Resolve the target

- If the user passed "list" or no arguments: call `mcp__stitch__list_projects` and present projects. Then call `mcp__stitch__list_screens` for the chosen project and present screens. Let the user pick.
- If the user passed a project ID and screen ID: proceed directly.
- If the user passed a project name: resolve it via `mcp__stitch__list_projects`.

### Step 1.2 - Fetch all design data

Run these calls in parallel:
1. `mcp__stitch__get_project` with the project resource name
2. `mcp__stitch__get_screen` with the screen resource name, projectId, and screenId
3. `mcp__stitch__list_design_systems` with the projectId

### Step 1.3 - Detect the target project

Look for the nearest Next.js project directory:
- Check the current working directory for `package.json` with `next` dependency
- If not found, ask the user which project to implement in
- Read `tailwind.config.ts` or `tailwind.config.js` to understand existing theme
- Check if ShadCN/UI is installed (look for `components/ui/` or `components.json`)
- Detect Tailwind version (v3 uses `tailwind.config`, v4 uses `@import "tailwindcss"` in CSS)

### Step 1.4 - Build the Reference Snapshot

This is the most important step. Build a complete reference that you will verify against throughout the entire process:

1. Call `mcp__stitch-dev__get_screen_code` to get exact HTML + Tailwind. **Save this as your GOLDEN REFERENCE.** Every decision you make must trace back to this HTML.
2. Call `mcp__stitch-dev__get_screen_image` to get a screenshot. Save as `public/assets/stitch/[screen-name]/stitch-reference.png`.
3. From the HTML, extract and document a **Pixel-Perfect Spec**:
   - Every unique font-family, font-size, font-weight, line-height, letter-spacing
   - Every unique color (hex values)
   - Every unique spacing value (padding, margin, gap)
   - Every unique border-radius value
   - Every image URL with its dimensions
   - The overall layout structure (flex/grid directions, wrapping)

**CHECKPOINT 1:** Present the Pixel-Perfect Spec to the user. Confirm the source HTML was retrieved successfully. Do NOT proceed until you have the golden reference.

---

## PHASE 2: Design Token Extraction

From the design system response, extract and document:

### Fonts
Map Stitch font enums to `next/font/google` imports using this table:

| Stitch Enum | next/font/google Import | CSS Variable |
|---|---|---|
| INTER | Inter | --font-inter |
| BE_VIETNAM_PRO | Be_Vietnam_Pro | --font-be-vietnam-pro |
| EPILOGUE | Epilogue | --font-epilogue |
| LEXEND | Lexend | --font-lexend |
| MANROPE | Manrope | --font-manrope |
| NEWSREADER | Newsreader | --font-newsreader |
| NOTO_SERIF | Noto_Serif | --font-noto-serif |
| PLUS_JAKARTA_SANS | Plus_Jakarta_Sans | --font-plus-jakarta-sans |
| PUBLIC_SANS | Public_Sans | --font-public-sans |
| SPACE_GROTESK | Space_Grotesk | --font-space-grotesk |
| SPLINE_SANS | Spline_Sans | --font-spline-sans |
| WORK_SANS | Work_Sans | --font-work-sans |
| DOMINE | Domine | --font-domine |
| LIBRE_CASLON_TEXT | Libre_Caslon_Text | --font-libre-caslon-text |
| EB_GARAMOND | EB_Garamond | --font-eb-garamond |
| LITERATA | Literata | --font-literata |
| SOURCE_SERIF_FOUR | Source_Serif_4 | --font-source-serif-4 |
| MONTSERRAT | Montserrat | --font-montserrat |
| METROPOLIS | LOCAL FONT (not on Google Fonts) | --font-metropolis |
| SOURCE_SANS_THREE | Source_Sans_3 | --font-source-sans-3 |
| NUNITO_SANS | Nunito_Sans | --font-nunito-sans |
| ARIMO | Arimo | --font-arimo |
| HANKEN_GROTESK | Hanken_Grotesk | --font-hanken-grotesk |
| RUBIK | Rubik | --font-rubik |
| GEIST | Geist | --font-geist |
| DM_SANS | DM_Sans | --font-dm-sans |
| IBM_PLEX_SANS | IBM_Plex_Sans | --font-ibm-plex-sans |
| SORA | Sora | --font-sora |

### Colors
Extract from design system:
- `customColor` - primary seed color
- `overridePrimaryColor` - primary color override
- `overrideSecondaryColor` - secondary color override
- `overrideTertiaryColor` - tertiary color override
- `overrideNeutralColor` - neutral color override
- `colorVariant` - Material Design 3 color variant scheme

### Roundness
Map to Tailwind:
- `ROUND_FOUR` -> `rounded` (4px)
- `ROUND_EIGHT` -> `rounded-lg` (8px)
- `ROUND_TWELVE` -> `rounded-xl` (12px)
- `ROUND_FULL` -> `rounded-full`

### Color Mode
- `LIGHT` -> default light theme
- `DARK` -> apply dark backgrounds, light text

**CHECKPOINT 2: VERIFY TOKENS**
Cross-reference every extracted token against the golden reference HTML:
- Do the fonts in the HTML match the design system fonts? If the HTML uses a font NOT in the design system, note it and use the HTML value (HTML is the truth).
- Do the colors in the HTML match the design system colors? If they differ, HTML wins.
- The golden reference HTML is ALWAYS the source of truth. The design system provides defaults, but the HTML contains the actual rendered values.

---

## PHASE 3: HTML/Code Extraction

### Priority 1 - stitch-dev MCP (davideast/stitch-mcp)
Call `mcp__stitch-dev__get_screen_code` with `projectId` and `screenId` to get the exact HTML + Tailwind code. This is the **golden source** for pixel-perfect conversion.

Also call `mcp__stitch-dev__get_screen_image` to get a base64 screenshot for validation later.

### Priority 2 - Built-in Stitch MCP fallback
If stitch-dev tools are unavailable, inspect the `mcp__stitch__get_screen` response. It may contain:
- HTML content or a URL to download HTML
- Preview/screenshot URLs
- Component structure data

If HTML URLs are found, use `WebFetch` to download the HTML content.
If screenshot URLs are found, use `WebFetch` to download and save as reference.

### Priority 3 - Stitch web preview
If you find a preview URL (like `stitch.withgoogle.com/...`), use `WebFetch` to fetch the page and extract the HTML/CSS.

**CRITICAL:** Save ALL extracted HTML/CSS in a temporary reference. You will convert this to Next.js components in the next phase. Do NOT discard any CSS values, class names, or inline styles.

---

## PHASE 4: Component Generation

### Rules - FOLLOW STRICTLY

1. **Preserve ALL Tailwind classes verbatim** from Stitch output. Do not "clean up" or "simplify" class names.

2. **CSS Fidelity Hierarchy** (in order of preference):
   - Use Stitch's Tailwind classes as-is
   - Use Tailwind arbitrary values for custom measurements: `text-[15px]`, `w-[372px]`, `tracking-[0.02em]`, `bg-[#1E293B]`
   - Extend `tailwind.config.ts` only for design tokens that repeat across multiple components
   - Use inline `style` props ONLY for CSS that Tailwind cannot express (complex gradients, clip-path, unusual filters)

3. **Server Components by default.** Only add `"use client"` for components that need:
   - Event handlers (onClick, onChange, etc.)
   - React hooks (useState, useEffect, etc.)
   - Browser APIs

4. **ShadCN mapping** (when ShadCN is detected in the project):
   - Map standard UI patterns to ShadCN components: Button, Card, Input, Dialog, Select, etc.
   - BUT override styles using `className` to match Stitch design EXACTLY
   - If a ShadCN component's base styles conflict too much, use raw HTML instead

5. **Never guess or approximate:**
   - If a font size is `15px`, use `text-[15px]` not `text-sm`
   - If a color is `#1a2b3c`, use `bg-[#1a2b3c]` not the nearest Tailwind color
   - If spacing is `18px`, use `p-[18px]` not `p-4`
   - If line-height is `1.6`, use `leading-[1.6]` not `leading-relaxed`

### Component Structure

```
src/components/stitch/[ScreenName]/
  [ScreenName].tsx            # Main Server Component
  [ScreenName].client.tsx     # Client interactive parts (only if needed)
  index.ts                    # Re-export
```

### Conversion Steps

1. Parse the Stitch HTML structure
2. Convert HTML tags to JSX (className, htmlFor, etc.)
3. Convert `<img>` to `next/image` `<Image>` component (see Phase 5)
4. Convert `<a>` to `next/link` `<Link>` where appropriate
5. Extract interactive sections into separate `.client.tsx` files
6. Preserve EVERY class name, every inline style, every data attribute

**CHECKPOINT 3: LINE-BY-LINE VERIFICATION**
After writing each component file, perform a line-by-line diff against the golden reference HTML:

1. **Element count:** Does your JSX have the same number of elements as the Stitch HTML? Every `<div>`, `<p>`, `<span>`, `<img>`, `<section>` must be accounted for.
2. **Class audit:** For each element, compare the Tailwind classes in your JSX against the Stitch HTML. List any differences. If there are ANY differences that are not JSX syntax conversions (class -> className), fix them immediately.
3. **Color audit:** Search your generated code for every color value. Cross-reference each hex against the Stitch HTML. No color may be changed, approximated, or replaced with a Tailwind named color.
4. **Spacing audit:** Search for every padding, margin, gap, width, height value. Each must match the Stitch HTML exactly.
5. **Font audit:** Verify every font-family, font-size, font-weight, line-height, letter-spacing matches.
6. **Image audit:** Every `<img>` in Stitch must have a corresponding `<Image>` in your code with the same src (after download), dimensions, and alt text.

If ANY discrepancy is found, fix it BEFORE proceeding. Do not move to the next phase with known differences.

---

## PHASE 5: Asset Handling

### Images

1. Scan the Stitch HTML for ALL image sources:
   - `<img src="...">` tags
   - `background-image: url(...)` in styles
   - SVG references

2. Download each image:
   - Use `WebFetch` or `Bash(curl)` to download
   - Save to `public/assets/stitch/[screen-name]/`
   - Use descriptive filenames: `hero-image.png`, `logo.svg`, `avatar-1.jpg`

3. Replace references:
   - Update `src` to `/assets/stitch/[screen-name]/filename.ext`
   - Convert `<img>` to `<Image>` from `next/image`
   - Set proper `width`, `height`, and `alt` attributes
   - For background images, keep as CSS `background-image` with local path

4. **Temporary/signed URLs:** Stitch CDN URLs may expire. ALWAYS download images immediately, never leave external Stitch URLs in the code.

### Icons

- If Stitch uses SVG icons inline, keep them inline
- If Stitch references an icon library, install and use the same library

**CHECKPOINT 4: ASSET VERIFICATION**
1. Count images in Stitch HTML vs images in your code. Must be equal.
2. Verify every image was downloaded successfully (file exists, non-zero size).
3. Verify image dimensions in `<Image>` components match the original `<img>` width/height attributes from Stitch.
4. Verify no Stitch CDN URLs remain in your code - all must be replaced with local paths.

---

## PHASE 6: Font Setup

### Check existing fonts
Read the project's root `layout.tsx` to see what fonts are already loaded.

### Add missing fonts
For each font from the design system that is NOT already loaded:

```tsx
import { Inter, Manrope } from "next/font/google";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

const manrope = Manrope({
  subsets: ["latin"],
  variable: "--font-manrope",
  display: "swap",
});
```

Add the CSS variables to the `<html>` or `<body>` element:
```tsx
<html className={`${inter.variable} ${manrope.variable}`}>
```

### Special case: METROPOLIS
Metropolis is NOT on Google Fonts. If the design uses it:
1. Download the font files
2. Use `next/font/local` instead:
```tsx
import localFont from "next/font/local";
const metropolis = localFont({
  src: "./fonts/Metropolis-Regular.woff2",
  variable: "--font-metropolis",
});
```

### Extend Tailwind config
Add font families that reference the CSS variables:

```ts
// tailwind.config.ts
theme: {
  extend: {
    fontFamily: {
      headline: ["var(--font-inter)", "sans-serif"],
      body: ["var(--font-manrope)", "sans-serif"],
    },
  },
},
```

**CHECKPOINT 5: FONT VERIFICATION**
1. List every font-family used in the Stitch HTML.
2. Verify each one has a corresponding `next/font/google` (or local) import in `layout.tsx`.
3. Verify the CSS variable is applied to the `<html>` element.
4. Verify the Tailwind config references the correct CSS variables.
5. Verify font-weight values in your components match Stitch exactly (400, 500, 600, 700, etc.).

---

## PHASE 7: Final Verification

This is the final comprehensive check. Do NOT skip any step.

### Step 7.1 - Full re-read of generated code
Read back every file you generated. For each file, compare against the golden reference HTML one more time.

### Step 7.2 - Screenshot comparison
If `get_screen_image` tool is available:
1. Call it to get the Stitch screenshot (base64)
2. Save as `public/assets/stitch/[screen-name]/stitch-reference.png`
3. Tell the user: "Reference screenshot saved. Run the dev server and compare side-by-side."

### Step 7.3 - Build check
Run the build to verify no errors:
```bash
npm run build
```
If there are errors, fix them while maintaining pixel-perfect fidelity. Re-verify after every fix.

### Step 7.4 - Final Audit Report
Present this to the user with actual values filled in:

```
PIXEL-PERFECT AUDIT REPORT
===========================

Source: Stitch project [name] / screen [name]

FONTS:
  Design system headline: [font] -> Loaded: [yes/no] -> CSS var: [var]
  Design system body: [font] -> Loaded: [yes/no] -> CSS var: [var]
  Fonts in HTML: [list] -> All loaded: [yes/no]

COLORS:
  Unique colors in Stitch HTML: [count]
  Colors preserved exactly: [count]
  Colors approximated: [count] (should be 0)
  [list any approximations with reason]

SPACING:
  All padding/margin/gap values preserved exactly: [yes/no]
  [list any deviations]

IMAGES:
  Images in Stitch: [count]
  Images downloaded: [count]
  Images with matching dimensions: [count]
  Missing images: [list or "none"]

LAYOUT:
  Structure matches: [yes/no]
  Flex/grid directions match: [yes/no]

BORDER RADIUS:
  Design system roundness: [value]
  Applied correctly: [yes/no]

OVERALL: [PIXEL-PERFECT / HAS DEVIATIONS]
```

If the report shows ANY deviations (other than user-requested changes), fix them before presenting to the user.

### Step 7.5 - Validation Checklist
After the audit report, present:

- [ ] **Fonts**: Correct font families loaded via `next/font/google`? Same weights?
- [ ] **Font sizes**: All sizes match exactly (no rounding to Tailwind defaults)?
- [ ] **Colors**: All hex values preserved exactly?
- [ ] **Spacing**: Padding, margin, gap values match pixel-for-pixel?
- [ ] **Border radius**: Roundness matches the design system setting?
- [ ] **Images**: All images downloaded and displayed correctly?
- [ ] **Layout**: Flexbox/Grid structure matches Stitch layout?
- [ ] **Responsive**: Component respects the target device type?
- [ ] **Dark/Light mode**: Color mode matches design system?
- [ ] **Build**: `npm run build` passes without errors?

---

## POST-IMPLEMENTATION: Ongoing Verification

When the user requests changes AFTER the initial conversion:

### If the change is part of the Stitch design (e.g., "convert another screen"):
- Follow the full pipeline above with all checkpoints.

### If the change deviates from Stitch (e.g., "make the button bigger", "change the color to red"):
- Apply ONLY the requested change.
- Do NOT touch anything else.
- After the change, re-verify everything EXCEPT the user's requested deviation still matches Stitch.
- Tell the user: "Applied your change. Everything else remains pixel-perfect with the Stitch design. Your change deviates from Stitch in: [list what changed]."

### If you are unsure whether a change breaks pixel-perfect fidelity:
- Re-read the Stitch source HTML.
- Compare against current code.
- If there is a diff beyond user-requested changes, fix it.

---

## CRITICAL RULES

1. **NEVER approximate.** If Stitch says `15px`, you write `15px`, not `1rem` or `text-sm`.
2. **NEVER drop CSS.** Every class, every style property matters for pixel-perfect output.
3. **NEVER use placeholder images.** Download real images from Stitch.
4. **NEVER change fonts.** Use the exact fonts from the design system, loaded through `next/font`.
5. **NEVER skip colors.** Every hex value must be preserved exactly.
6. **NEVER skip a checkpoint.** Every checkpoint is mandatory. No exceptions.
7. **NEVER proceed with known deviations.** Fix first, then continue.
8. **ALWAYS download assets first** before they expire from Stitch CDN.
9. **ALWAYS re-verify after any edit.** Even a small fix can introduce drift elsewhere.
10. **ALWAYS present the audit report** at the end.
11. **ALWAYS tell the user** if you had to use a fallback (inline styles, approximations) and why.
12. **The Stitch HTML is the single source of truth.** When in doubt, re-read it.
