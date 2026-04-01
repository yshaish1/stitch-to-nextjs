# Stitch Font Mapping Reference

Complete mapping of all 29 Stitch design system fonts to `next/font/google` imports.

## Font Table

| Stitch Enum | next/font/google Import | CSS Variable | Font Type |
|---|---|---|---|
| `INTER` | `Inter` | `--font-inter` | Sans-serif |
| `BE_VIETNAM_PRO` | `Be_Vietnam_Pro` | `--font-be-vietnam-pro` | Sans-serif |
| `EPILOGUE` | `Epilogue` | `--font-epilogue` | Sans-serif |
| `LEXEND` | `Lexend` | `--font-lexend` | Sans-serif |
| `MANROPE` | `Manrope` | `--font-manrope` | Sans-serif |
| `NEWSREADER` | `Newsreader` | `--font-newsreader` | Serif |
| `NOTO_SERIF` | `Noto_Serif` | `--font-noto-serif` | Serif |
| `PLUS_JAKARTA_SANS` | `Plus_Jakarta_Sans` | `--font-plus-jakarta-sans` | Sans-serif |
| `PUBLIC_SANS` | `Public_Sans` | `--font-public-sans` | Sans-serif |
| `SPACE_GROTESK` | `Space_Grotesk` | `--font-space-grotesk` | Sans-serif |
| `SPLINE_SANS` | `Spline_Sans` | `--font-spline-sans` | Sans-serif |
| `WORK_SANS` | `Work_Sans` | `--font-work-sans` | Sans-serif |
| `DOMINE` | `Domine` | `--font-domine` | Serif |
| `LIBRE_CASLON_TEXT` | `Libre_Caslon_Text` | `--font-libre-caslon-text` | Serif |
| `EB_GARAMOND` | `EB_Garamond` | `--font-eb-garamond` | Serif |
| `LITERATA` | `Literata` | `--font-literata` | Serif |
| `SOURCE_SERIF_FOUR` | `Source_Serif_4` | `--font-source-serif-4` | Serif |
| `MONTSERRAT` | `Montserrat` | `--font-montserrat` | Sans-serif |
| `METROPOLIS` | **`next/font/local`** | `--font-metropolis` | Sans-serif |
| `SOURCE_SANS_THREE` | `Source_Sans_3` | `--font-source-sans-3` | Sans-serif |
| `NUNITO_SANS` | `Nunito_Sans` | `--font-nunito-sans` | Sans-serif |
| `ARIMO` | `Arimo` | `--font-arimo` | Sans-serif |
| `HANKEN_GROTESK` | `Hanken_Grotesk` | `--font-hanken-grotesk` | Sans-serif |
| `RUBIK` | `Rubik` | `--font-rubik` | Sans-serif |
| `GEIST` | `Geist` | `--font-geist` | Sans-serif |
| `DM_SANS` | `DM_Sans` | `--font-dm-sans` | Sans-serif |
| `IBM_PLEX_SANS` | `IBM_Plex_Sans` | `--font-ibm-plex-sans` | Sans-serif |
| `ROBOTO` | `Roboto` | `--font-roboto` | Sans-serif |
| `SORA` | `Sora` | `--font-sora` | Sans-serif |

## Usage Pattern

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

// In layout.tsx
<html className={`${inter.variable} ${manrope.variable}`}>
```

## METROPOLIS Special Case

Metropolis is NOT available on Google Fonts. Use `next/font/local`:

```tsx
import localFont from "next/font/local";

const metropolis = localFont({
  src: [
    { path: "./fonts/Metropolis-Regular.woff2", weight: "400" },
    { path: "./fonts/Metropolis-Medium.woff2", weight: "500" },
    { path: "./fonts/Metropolis-Bold.woff2", weight: "700" },
  ],
  variable: "--font-metropolis",
});
```

## Tailwind Config

```ts
// tailwind.config.ts
export default {
  theme: {
    extend: {
      fontFamily: {
        headline: ["var(--font-inter)", "sans-serif"],
        body: ["var(--font-manrope)", "sans-serif"],
        label: ["var(--font-space-grotesk)", "sans-serif"],
      },
    },
  },
};
```
