#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία δομής φακέλων
echo -e "${GREEN}Δημιουργία δομής φακέλων για το Next.js project...${NC}"
mkdir -p app/api/{auth,products,categories,media}
mkdir -p app/(admin)/{dashboard,products,categories,media}
mkdir -p app/login
mkdir -p components/{ui,admin,forms}
mkdir -p lib/{cloudinary,utils}
mkdir -p types
mkdir -p public/images

# Δημιουργία app/layout.tsx
cat > app/layout.tsx << 'EOL'
import './globals.css'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'AION CMS',
  description: 'A modern content management system',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
EOL

# Δημιουργία app/globals.css
cat > app/globals.css << 'EOL'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --foreground-rgb: 0, 0, 0;
  --background-rgb: 255, 255, 255;
}

body {
  color: rgb(var(--foreground-rgb));
  background: rgb(var(--background-rgb));
}
EOL

# Δημιουργία app/page.tsx
cat > app/page.tsx << 'EOL'
import Link from 'next/link'

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold mb-6">AION CMS</h1>
      <p className="mb-8 text-lg">A modern content management system</p>
      <Link
        href="/login"
        className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
      >
        Go to Login
      </Link>
    </main>
  )
}
EOL

echo -e "${GREEN}Η βασική δομή του Next.js project δημιουργήθηκε επιτυχώς.${NC}"