# Stitch Design Token Reference

## Color System

Stitch uses Material Design 3's dynamic color system. Colors are generated from a seed color with optional overrides.

### Design System Colors

| Token | Description | Usage |
|---|---|---|
| `customColor` | Primary seed color (hex) | Base color for the entire palette |
| `overridePrimaryColor` | Primary color override | Main brand color |
| `overrideSecondaryColor` | Secondary color override | Supporting color |
| `overrideTertiaryColor` | Tertiary color override | Accent color |
| `overrideNeutralColor` | Neutral color override | Backgrounds, text |

### Color Variants

| Variant | Description |
|---|---|
| `MONOCHROME` | Single-hue palette |
| `NEUTRAL` | Desaturated, subtle palette |
| `TONAL_SPOT` | Default MD3 scheme |
| `VIBRANT` | High-saturation palette |
| `EXPRESSIVE` | Bold, creative palette |
| `FIDELITY` | Closest to seed color |
| `CONTENT` | Derived from content |
| `RAINBOW` | Full spectrum |
| `FRUIT_SALAD` | Multi-hue playful palette |

### Implementation

Always extract actual rendered hex values from the HTML rather than computing MD3 colors:

```tsx
// Correct - use exact hex from Stitch HTML
<div className="bg-[#1E293B] text-[#F8FAFC]">

// Wrong - don't approximate with Tailwind defaults
<div className="bg-slate-800 text-slate-50">
```

## Roundness

| Stitch Value | Tailwind Class | Pixels |
|---|---|---|
| `ROUND_FOUR` | `rounded` | 4px |
| `ROUND_EIGHT` | `rounded-lg` | 8px |
| `ROUND_TWELVE` | `rounded-xl` | 12px |
| `ROUND_FULL` | `rounded-full` | 9999px |

## Color Mode

| Stitch Value | Implementation |
|---|---|
| `LIGHT` | Default light theme - no special handling |
| `DARK` | Apply dark backgrounds, light text, use `dark:` Tailwind classes if needed |
