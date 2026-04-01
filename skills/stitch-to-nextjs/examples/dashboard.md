# Example: Dashboard with Interactive Elements

## Stitch Design

A dashboard screen with:
- Sidebar navigation (static)
- Stats cards (static)
- Interactive chart area (needs client component)
- Filter dropdowns (needs client component)

## Command

```
/stitch-to-nextjs 4044680601076201931 abc123def456
```

## Generated Output

### `src/components/stitch/Dashboard/Dashboard.tsx` (Server Component)

```tsx
import Image from "next/image";
import { DashboardFilters } from "./Dashboard.client";

export default function Dashboard() {
  return (
    <div className="flex min-h-screen bg-[#F8FAFC]">
      {/* Sidebar */}
      <aside className="flex w-[260px] flex-col gap-[8px] border-r border-[#E2E8F0] bg-white px-[16px] py-[24px]">
        <Image
          src="/assets/stitch/dashboard/logo.svg"
          alt="Logo"
          width={120}
          height={32}
        />
        <nav className="mt-[24px] flex flex-col gap-[4px]">
          <a className="flex items-center gap-[12px] rounded-lg bg-[#EEF2FF] px-[12px] py-[10px] text-[14px] font-medium text-[#4F46E5]">
            Overview
          </a>
          <a className="flex items-center gap-[12px] rounded-lg px-[12px] py-[10px] text-[14px] text-[#64748B]">
            Analytics
          </a>
        </nav>
      </aside>

      {/* Main content */}
      <main className="flex-1 px-[32px] py-[24px]">
        <DashboardFilters />

        {/* Stats cards */}
        <div className="mt-[24px] grid grid-cols-3 gap-[20px]">
          <div className="rounded-xl border border-[#E2E8F0] bg-white p-[24px]">
            <p className="text-[13px] font-medium text-[#64748B]">Total Users</p>
            <p className="mt-[8px] text-[28px] font-bold text-[#0F172A]">12,849</p>
          </div>
        </div>
      </main>
    </div>
  );
}
```

### `src/components/stitch/Dashboard/Dashboard.client.tsx` (Client Component)

```tsx
"use client";

import { useState } from "react";

export function DashboardFilters() {
  const [period, setPeriod] = useState("7d");

  return (
    <div className="flex items-center gap-[12px]">
      <select
        value={period}
        onChange={(e) => setPeriod(e.target.value)}
        className="rounded-lg border border-[#E2E8F0] bg-white px-[12px] py-[8px] text-[14px] text-[#0F172A]"
      >
        <option value="7d">Last 7 days</option>
        <option value="30d">Last 30 days</option>
        <option value="90d">Last 90 days</option>
      </select>
    </div>
  );
}
```

### `src/components/stitch/Dashboard/index.ts`

```tsx
export { default } from "./Dashboard";
export { DashboardFilters } from "./Dashboard.client";
```

### Key decisions

- Sidebar and stats cards are Server Components (no interactivity)
- Filters extracted to `.client.tsx` because they use `useState`
- Every color is an exact hex value from Stitch
- Every spacing value uses arbitrary Tailwind syntax
- Logo SVG downloaded from Stitch CDN
