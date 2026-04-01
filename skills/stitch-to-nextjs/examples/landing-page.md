# Example: Landing Page Hero Section

## Stitch Design

A hero section with:
- Headline in Inter Bold at 48px
- Subtext in Manrope Regular at 18px
- Background color #0F172A
- CTA button with 12px border-radius
- Hero image on the right

## Command

```
/stitch-to-nextjs 4044680601076201931 98b50e2ddc9943efb387052637738f61
```

## Generated Output

### `src/components/stitch/HeroSection/HeroSection.tsx`

```tsx
import Image from "next/image";

export default function HeroSection() {
  return (
    <section className="flex min-h-[600px] items-center bg-[#0F172A] px-[80px] py-[60px]">
      <div className="flex max-w-[1200px] items-center gap-[64px]">
        <div className="flex flex-1 flex-col gap-[24px]">
          <h1 className="font-headline text-[48px] font-bold leading-[1.15] tracking-[-0.02em] text-white">
            Build faster with AI-powered design
          </h1>
          <p className="font-body text-[18px] leading-[1.6] text-[#94A3B8]">
            Transform your Stitch designs into production-ready Next.js
            components with zero visual drift.
          </p>
          <button className="w-fit rounded-xl bg-[#6366F1] px-[32px] py-[14px] text-[16px] font-medium text-white transition-colors hover:bg-[#4F46E5]">
            Get Started
          </button>
        </div>
        <div className="flex-1">
          <Image
            src="/assets/stitch/hero-section/hero-image.png"
            alt="Product screenshot"
            width={560}
            height={400}
            className="rounded-[16px] shadow-2xl"
          />
        </div>
      </div>
    </section>
  );
}
```

### Key decisions

- `text-[48px]` not `text-5xl` (which is 48px but we preserve the exact value)
- `px-[80px]` not `px-20` (exact padding from Stitch)
- `gap-[64px]` not `gap-16` (preserves design intent)
- `rounded-xl` matches ROUND_TWELVE from design system
- `bg-[#0F172A]` exact hex, not `bg-slate-900`
- Image downloaded to `public/assets/stitch/hero-section/`
