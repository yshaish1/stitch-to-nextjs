# CSS Fidelity Rules

The core principle: **never approximate**. Every CSS value from Stitch must be preserved exactly.

## Fidelity Hierarchy

Use this order of preference when converting Stitch CSS:

### 1. Stitch Tailwind Classes (Verbatim)

If Stitch outputs a Tailwind class, use it exactly as-is:

```html
<!-- Stitch output -->
<div class="flex items-center gap-4 rounded-lg bg-white p-6 shadow-md">

<!-- Next.js output - IDENTICAL -->
<div className="flex items-center gap-4 rounded-lg bg-white p-6 shadow-md">
```

### 2. Tailwind Arbitrary Values

For custom measurements that don't match Tailwind defaults:

```tsx
// Correct
<div className="text-[15px] w-[372px] tracking-[0.02em] bg-[#1E293B]">

// Wrong - these approximate but don't match
<div className="text-sm w-96 tracking-wide bg-slate-800">
```

### 3. Tailwind Config Extensions

Only for design tokens that repeat across multiple components:

```ts
// tailwind.config.ts - only for repeating tokens
theme: {
  extend: {
    colors: {
      primary: "#6366F1",
      surface: "#0F172A",
    },
    borderRadius: {
      design: "12px",
    },
  },
},
```

### 4. Inline Styles (Last Resort)

Only for CSS that Tailwind cannot express:

```tsx
// Complex gradients
<div style={{
  background: "linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f97316 100%)"
}}>

// Clip paths
<div style={{
  clipPath: "polygon(0 0, 100% 0, 100% 85%, 0 100%)"
}}>
```

## Common Mistakes to Avoid

| Stitch Value | Wrong | Right |
|---|---|---|
| `15px` font | `text-sm` | `text-[15px]` |
| `#1E293B` bg | `bg-slate-800` | `bg-[#1E293B]` |
| `18px` padding | `p-4` | `p-[18px]` |
| `1.6` line-height | `leading-relaxed` | `leading-[1.6]` |
| `0.02em` tracking | `tracking-wide` | `tracking-[0.02em]` |
| `12px` radius | `rounded-lg` | `rounded-xl` or `rounded-[12px]` |
