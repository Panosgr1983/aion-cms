#!/bin/bash

# AION CMS - Full Installation Script
# Αυτό το script δημιουργήθηκε αυτόματα με το συνδυασμό επιμέρους script αρχείων

# Χρωματιστή έξοδος για καλύτερη αναγνωσιμότητα
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Εμφάνιση banner
echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}         AION CMS INSTALLER           ${NC}"
echo -e "${BLUE}=======================================${NC}"

# Έλεγχος αν δόθηκε όνομα φακέλου ως παράμετρος
if [ "$1" == "" ]; then
  echo -e "${YELLOW}Δεν δόθηκε όνομα φακέλου. Χρησιμοποιείται το προεπιλεγμένο 'aion-cms'${NC}"
  FOLDER_NAME="aion-cms"
else
  FOLDER_NAME="$1"
fi

# Δημιουργία βασικού φακέλου
echo -e "${GREEN}Δημιουργία βασικού φακέλου: ${FOLDER_NAME}${NC}"
mkdir -p "$FOLDER_NAME"
cd "$FOLDER_NAME"


# -------- Περιεχόμενο από το 02_setup_npm.sh --------


# Χρωματιστή έξοδος

# Αρχικοποίηση npm project
echo -e "${GREEN}Αρχικοποίηση npm project...${NC}"
cat > package.json << 'EOL'
{
  "name": "aion-cms",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@types/node": "^20.11.0",
    "@types/react": "^18.2.48",
    "@types/react-dom": "^18.2.18",
    "autoprefixer": "^10.4.16",
    "cloudinary": "^1.41.2",
    "eslint": "^8.56.0",
    "eslint-config-next": "^14.0.4",
    "next": "14.0.4",
    "postcss": "^8.4.33",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "tailwindcss": "^3.4.1",
    "typescript": "^5.3.3"
  }
}
EOL

echo -e "${GREEN}Το package.json δημιουργήθηκε επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 03_setup_config.sh --------


# Χρωματιστή έξοδος

# Δημιουργία των αρχείων ρυθμίσεων
echo -e "${GREEN}Δημιουργία αρχείων ρυθμίσεων...${NC}"

# Δημιουργία tsconfig.json
cat > tsconfig.json << 'EOL'
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOL

# Δημιουργία .env.local
cat > .env.local << 'EOL'
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
NEXT_PUBLIC_API_URL=http://localhost:3000/api
EOL

# next.config.js
cat > next.config.js << 'EOL'
/** @type {import'next'.NextConfig} */
const nextConfig = {
  images: {
    domains: ['res.cloudinary.com'],
  },
}

module.exports = nextConfig
EOL

# tailwind.config.js
cat > tailwind.config.js << 'EOL'
/** @type {import'tailwindcss'.Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# postcss.config.js
cat > postcss.config.js << 'EOL'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOL

echo -e "${GREEN}Τα αρχεία ρυθμίσεων δημιουργήθηκαν επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 04_setup_nextjs.sh --------


# Χρωματιστή έξοδος

# Δημιουργία δομής φακέλων
echo -e "${GREEN}Δημιουργία δομής φακέλων για το Next.js project...${NC}"
mkdir -p app/api/{auth,products,categories,media}
mkdir -p app/admin/{dashboard,products,categories,media}
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

export default function RootLayout{
  children,
}: {
  children: React.ReactNode
} {
  return 
    <html lang="en">
      <body>{children}</body>
    </html>
  
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
  color: rgbvar--foreground-rgb;
  background: rgbvar--background-rgb;
}
EOL

# Δημιουργία app/page.tsx
cat > app/page.tsx << 'EOL'
import Link from 'next/link'

export default function Home {
  return 
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
  
}
EOL

echo -e "${GREEN}Η βασική δομή του Next.js project δημιουργήθηκε επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 05_setup_components.sh --------


# Χρωματιστή έξοδος

# Δημιουργία components
echo -e "${GREEN}Δημιουργία των React components...${NC}"

# Δημιουργία Sidebar component
mkdir -p components/admin
cat > components/admin/Sidebar.tsx << 'EOL'
"use client"
import Link from 'next/link'
import { usePathname } from 'next/navigation'

export default function Sidebar {
  const pathname = usePathname
  
  const links = [
    { href: '/dashboard', label: 'Dashboard' },
    { href: '/products', label: 'Products' },
    { href: '/categories', label: 'Categories' },
    { href: '/media', label: 'Media' },
  ]
  
  const handleLogout =  => {
    localStorage.removeItem'isLoggedIn'
    window.location.href = '/login'
  }

  return 
    <div className="w-64 bg-gray-800 text-white h-full flex flex-col">
      <div className="p-4 border-b border-gray-700">
        <h2 className="text-xl font-bold">AION CMS</h2>
      </div>
      
      <nav className="flex-1 p-4">
        <ul className="space-y-2">
          {links.maplink => 
            <li key={link.href}>
              <Link 
                href={link.href}
                className={`block px-4 py-2 rounded hover:bg-gray-700 ${pathname === link.href ? 'bg-gray-700' : ''}`}
              >
                {link.label}
              </Link>
            </li>
          }
        </ul>
      </nav>
      
      <div className="p-4 border-t border-gray-700">
        <button 
          onClick={handleLogout}
          className="block w-full px-4 py-2 text-left rounded hover:bg-gray-700"
        >
          Logout
        </button>
      </div>
    </div>
  
}
EOL

# Δημιουργία βασικών UI components
mkdir -p components/ui
cat > components/ui/Button.tsx << 'EOL'
interface ButtonProps {
  children: React.ReactNode;
  variant?: 'primary' | 'secondary' | 'danger';
  type?: 'button' | 'submit' | 'reset';
  onClick?:  => void;
  disabled?: boolean;
  className?: string;
}

export default function Button{
  children,
  variant = 'primary',
  type = 'button',
  onClick,
  disabled = false,
  className = '',
}: ButtonProps {
  const getVariantClasses =  => {
    switch variant {
      case 'primary':
        return 'bg-blue-600 hover:bg-blue-700 text-white';
      case 'secondary':
        return 'bg-gray-200 hover:bg-gray-300 text-gray-800';
      case 'danger':
        return 'bg-red-600 hover:bg-red-700 text-white';
      default:
        return 'bg-blue-600 hover:bg-blue-700 text-white';
    }
  };

  return 
    <button
      type={type}
      onClick={onClick}
      disabled={disabled}
      className={`px-4 py-2 rounded font-medium ${getVariantClasses} ${
        disabled ? 'opacity-50 cursor-not-allowed' : ''
      } ${className}`}
    >
      {children}
    </button>
  ;
}
EOL

# Δημιουργία Card component
cat > components/ui/Card.tsx << 'EOL'
interface CardProps {
  children: React.ReactNode;
  className?: string;
}

export default function Card{ children, className = '' }: CardProps {
  return 
    <div className={`bg-white rounded-lg shadow-md overflow-hidden ${className}`}>
      {children}
    </div>
  ;
}
EOL

# Δημιουργία βασικού Form component
mkdir -p components/forms
cat > components/forms/TextField.tsx << 'EOL'
interface TextFieldProps {
  id: string;
  label: string;
  value: string;
  onChange: e: React.ChangeEvent<HTMLInputElement> => void;
  type?: string;
  placeholder?: string;
  required?: boolean;
  error?: string;
}

export default function TextField{
  id,
  label,
  value,
  onChange,
  type = 'text',
  placeholder = '',
  required = false,
  error,
}: TextFieldProps {
  return 
    <div className="mb-4">
      <label htmlFor={id} className="block text-sm font-medium text-gray-700 mb-1">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <input
        id={id}
        type={type}
        value={value}
        onChange={onChange}
        placeholder={placeholder}
        required={required}
        className={`w-full px-3 py-2 border ${
          error ? 'border-red-500' : 'border-gray-300'
        } rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500`}
      />
      {error && <p className="mt-1 text-sm text-red-500">{error}</p>}
    </div>
  ;
}
EOL

echo -e "${GREEN}Τα React components δημιουργήθηκαν επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 06_setup_admin.sh --------


# Χρωματιστή έξοδος

# Δημιουργία admin layout και σχετικών σελίδων
echo -e "${GREEN}Δημιουργία του admin layout και των σχετικών σελίδων...${NC}"

# Δημιουργία σελίδας login
cat > app/login/page.tsx << 'EOL'
"use client"
import { useState } from 'react'
import { useRouter } from 'next/navigation'

export default function Login {
  const router = useRouter
  const [username, setUsername] = useState''
  const [password, setPassword] = useState''
  const [error, setError] = useState''

  const handleSubmit = e: React.FormEvent => {
    e.preventDefault
    // Απλό σύστημα login demo για τοπική ανάπτυξη
    if username === 'admin' && password === 'admin' {
      localStorage.setItem'isLoggedIn', 'true'
      router.push'/dashboard'
    } else {
      setError'Invalid username or password'
    }
  }

  return 
    <div className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="w-full max-w-md p-8 space-y-8 bg-white rounded-lg shadow-md">
        <div className="text-center">
          <h1 className="text-2xl font-bold">AION CMS Login</h1>
          <p className="mt-2 text-gray-600">Sign in to your account</p>
        </div>

        {error && 
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
            {error}
          </div>
        }

        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div>
            <label htmlFor="username" className="block text-sm font-medium text-gray-700">
              Username
            </label>
            <input
              id="username"
              name="username"
              type="text"
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
              value={username}
              onChange={e => setUsernamee.target.value}
            />
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">
              Password
            </label>
            <input
              id="password"
              name="password"
              type="password"
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
              value={password}
              onChange={e => setPassworde.target.value}
            />
          </div>

          <div>
            <button
              type="submit"
              className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
            >
              Sign in
            </button>
          </div>
        </form>
      </div>
    </div>
  
}
EOL

# Δημιουργία admin layout
cat > app/admin/layout.tsx << 'EOL'
"use client"
import { useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import Sidebar from '@/components/admin/Sidebar'

export default function AdminLayout{
  children,
}: {
  children: React.ReactNode
} {
  const router = useRouter
  const [isClient, setIsClient] = useStatefalse

  useEffect => {
    setIsClienttrue
    const isLoggedIn = localStorage.getItem'isLoggedIn'
    if !isLoggedIn || isLoggedIn !== 'true' {
      router.push'/login'
    }
  }, [router]

  if !isClient {
    return <div>Loading...</div>
  }

  return 
    <div className="flex h-screen bg-gray-100">
      <Sidebar />
      <div className="flex-1 overflow-auto p-8">
        {children}
      </div>
    </div>
  
}
EOL

echo -e "${GREEN}Το admin layout και οι σχετικές σελίδες δημιουργήθηκαν επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 07_setup_pages.sh --------


# Χρωματιστή έξοδος

# Δημιουργία των σελίδων του admin panel
echo -e "${GREEN}Δημιουργία των βασικών σελίδων του admin panel...${NC}"

# Δημιουργία dashboard page
mkdir -p app/admin/dashboard
cat > app/admin/dashboard/page.tsx << 'EOL'
"use client"
import { useEffect, useState } from 'react'

export default function Dashboard {
  const [stats, setStats] = useState{
    products: 0,
    categories: 0,
    media: 0
  }

  useEffect => {
    // Εδώ θα φορτώναμε πραγματικά στατιστικά από το API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setStats{
      products: 24,
      categories: 8,
      media: 56
    }
  }, []

  return 
    <div>
      <h1 className="text-2xl font-bold mb-6">Dashboard</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-white p-6 rounded-lg shadow">
          <h2 className="text-lg font-semibold text-gray-700">Products</h2>
          <p className="text-3xl font-bold mt-2">{stats.products}</p>
        </div>
        
        <div className="bg-white p-6 rounded-lg shadow">
          <h2 className="text-lg font-semibold text-gray-700">Categories</h2>
          <p className="text-3xl font-bold mt-2">{stats.categories}</p>
        </div>
        
        <div className="bg-white p-6 rounded-lg shadow">
          <h2 className="text-lg font-semibold text-gray-700">Media Files</h2>
          <p className="text-3xl font-bold mt-2">{stats.media}</p>
        </div>
      </div>
      
      <div className="mt-8 bg-white p-6 rounded-lg shadow">
        <h2 className="text-xl font-semibold mb-4">Recent Activity</h2>
        <div className="text-gray-600">
          <p>No recent activity to display.</p>
        </div>
      </div>
    </div>
  
}
EOL

# Δημιουργία products page
mkdir -p app/admin/products
cat > app/admin/products/page.tsx << 'EOL'
"use client"
import { useState, useEffect } from 'react'
import Link from 'next/link'

interface Product {
  id: string
  name: string
  category: string
  price: number
}

export default function Products {
  const [products, setProducts] = useState<Product[]>[]
  const [loading, setLoading] = useStatetrue

  useEffect => {
    // Εδώ θα φορτώναμε πραγματικά προϊόντα από το API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setTimeout => {
      setProducts[
        { id: '1', name: 'Product 1', category: 'Category A', price: 29.99 },
        { id: '2', name: 'Product 2', category: 'Category B', price: 49.99 },
        { id: '3', name: 'Product 3', category: 'Category A', price: 19.99 },
      ]
      setLoadingfalse
    }, 500
  }, []

  return 
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Products</h1>
        <Link
          href="/products/new"
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
        >
          Add New Product
        </Link>
      </div>

      {loading ? 
        <div className="text-center py-4">Loading products...</div>
       : 
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Name
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Category
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Price
                </th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {products.mapproduct => 
                <tr key={product.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm font-medium text-gray-900">{product.name}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-500">{product.category}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-500">${product.price.toFixed2}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <Link
                      href={`/products/edit/${product.id}`}
                      className="text-blue-600 hover:text-blue-900 mr-4"
                    >
                      Edit
                    </Link>
                    <button
                      className="text-red-600 hover:text-red-900"
                      onClick={ => {
                        if confirm'Are you sure you want to delete this product?' {
                          // Εδώ θα καλούσαμε το API για διαγραφή
                          setProductsproducts.filterp => p.id !== product.id
                        }
                      }}
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              }
            </tbody>
          </table>
        </div>
      }
    </div>
  
}
EOL

# Δημιουργία categories page
mkdir -p app/admin/categories
cat > app/admin/categories/page.tsx << 'EOL'
"use client"
import { useState, useEffect } from 'react'
import Link from 'next/link'

interface Category {
  id: string
  name: string
  productCount: number
}

export default function Categories {
  const [categories, setCategories] = useState<Category[]>[]
  const [loading, setLoading] = useStatetrue

  useEffect => {
    // Εδώ θα φορτώναμε πραγματικές κατηγορίες από το API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setTimeout => {
      setCategories[
        { id: '1', name: 'Category A', productCount: 12 },
        { id: '2', name: 'Category B', productCount: 8 },
        { id: '3', name: 'Category C', productCount: 4 },
      ]
      setLoadingfalse
    }, 500
  }, []

  return 
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Categories</h1>
        <Link
          href="/categories/new"
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
        >
          Add New Category
        </Link>
      </div>

      {loading ? 
        <div className="text-center py-4">Loading categories...</div>
       : 
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Name
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Products
                </th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {categories.mapcategory => 
                <tr key={category.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm font-medium text-gray-900">{category.name}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-500">{category.productCount}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <Link
                      href={`/categories/edit/${category.id}`}
                      className="text-blue-600 hover:text-blue-900 mr-4"
                    >
                      Edit
                    </Link>
                    <button
                      className="text-red-600 hover:text-red-900"
                      onClick={ => {
                        if confirm'Are you sure you want to delete this category?' {
                          // Εδώ θα καλούσαμε το API για διαγραφή
                          setCategoriescategories.filterc => c.id !== category.id
                        }
                      }}
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              }
            </tbody>
          </table>
        </div>
      }
    </div>
  
}
EOL
# -------- Περιεχόμενο από το 08_setup_media_page.sh --------


# Χρωματιστή έξοδος

# Δημιουργία της σελίδας διαχείρισης πολυμέσων
echo -e "${GREEN}Δημιουργία της σελίδας διαχείρισης πολυμέσων...${NC}"

# Δημιουργία media page
mkdir -p app/admin/media
cat > app/admin/media/page.tsx << 'EOL'
"use client"
import { useState, useEffect } from 'react'
import Image from 'next/image'

interface MediaItem {
  id: string
  url: string
  name: string
  type: string
  size: number
}

export default function Media {
  const [mediaItems, setMediaItems] = useState<MediaItem[]>[]
  const [loading, setLoading] = useStatetrue
  const [uploading, setUploading] = useStatefalse

  useEffect => {
    // Εδώ θα φορτώναμε πραγματικά αρχεία από το Cloudinary μέσω του API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setTimeout => {
      setMediaItems[
        { 
          id: '1', 
          url: 'https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg', 
          name: 'sample.jpg', 
          type: 'image/jpeg', 
          size: 123456 
        },
        { 
          id: '2', 
          url: 'https://res.cloudinary.com/demo/image/upload/v1312461204/sample2.jpg', 
          name: 'sample2.jpg', 
          type: 'image/jpeg', 
          size: 234567 
        },
      ]
      setLoadingfalse
    }, 500
  }, []

  const handleFileUpload = async e: React.ChangeEvent<HTMLInputElement> => {
    const files = e.target.files
    if !files || files.length === 0 return

    setUploadingtrue
    
    // Εδώ θα ανεβάζαμε τα αρχεία στο Cloudinary μέσω του API
    // Για τώρα προσομοιώνουμε το ανέβασμα
    setTimeout => {
      const newMediaItems = [...mediaItems]
      
      for let i = 0; i < files.length; i++ {
        const file = files[i]
        newMediaItems.push{
          id: `new-${Date.now}-${i}`,
          url: URL.createObjectURLfile,
          name: file.name,
          type: file.type,
          size: file.size
        }
      }
      
      setMediaItemsnewMediaItems
      setUploadingfalse
    }, 1500
  }

  const formatFileSize = bytes: number => {
    if bytes < 1024 return bytes + ' bytes'
    else if bytes < 1048576 return bytes / 1024.toFixed1 + ' KB'
    else return bytes / 1048576.toFixed1 + ' MB'
  }

  return 
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Media Library</h1>
        <div>
          <input
            type="file"
            id="file-upload"
            className="hidden"
            multiple
            onChange={handleFileUpload}
            accept="image/*"
          />
          <label
            htmlFor="file-upload"
            className={`px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 cursor-pointer ${
              uploading ? 'opacity-50 cursor-not-allowed' : ''
            }`}
          >
            {uploading ? 'Uploading...' : 'Upload Files'}
          </label>
        </div>
      </div>

      {loading ? 
        <div className="text-center py-4">Loading media...</div>
       : 
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {mediaItems.mapitem => 
            <div
              key={item.id}
              className="bg-white rounded-lg shadow overflow-hidden"
            >
              <div className="relative h-40 bg-gray-100">
                {item.type.startsWith'image/' ? 
                  <img
                    src={item.url}
                    alt={item.name}
                    className="w-full h-full object-cover"
                  />
                 : 
                  <div className="flex items-center justify-center h-full">
                    <span className="text-gray-400">{item.type}</span>
                  </div>
                }
              </div>
              <div className="p-3">
                <p className="text-sm font-medium text-gray-900 truncate">{item.name}</p>
                <p className="text-xs text-gray-500">{formatFileSizeitem.size}</p>
              </div>
              <div className="bg-gray-50 px-3 py-2 text-right">
                <button
                  className="text-red-600 text-xs hover:text-red-900"
                  onClick={ => {
                    if confirm'Are you sure you want to delete this file?' {
                      // Εδώ θα καλούσαμε το API για διαγραφή από το Cloudinary
                      setMediaItemsmediaItems.filterm => m.id !== item.id
                    }
                  }}
                >
                  Delete
                </button>
              </div>
            </div>
          }
        </div>
      }
    </div>
  
}
EOL

echo -e "${GREEN}Η σελίδα διαχείρισης πολυμέσων δημιουργήθηκε επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 09_setup_cloudinary.sh --------


# Χρωματιστή έξοδος

# Δημιουργία των utilities για το Cloudinary
echo -e "${GREEN}Δημιουργία των utilities για το Cloudinary...${NC}"

# Δημιουργία του φακέλου lib/cloudinary αν δεν υπάρχει
mkdir -p lib/cloudinary

# Δημιουργία του cloudinary.ts utility
cat > lib/cloudinary/index.ts << 'EOL'
import { v2 as cloudinary } from 'cloudinary';

// Ρύθμιση του Cloudinary
cloudinary.config{
  cloud_name: process.env.NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
};

export default cloudinary;

// Ανέβασμα εικόνας στο Cloudinary
export const uploadImage = async file: File: Promise<any> => {
  // Στον client, θα πρέπει να στείλουμε το αρχείο στο API μας, το οποίο
  // στη συνέχεια θα το ανεβάσει στο Cloudinary
  const formData = new FormData;
  formData.append'file', file;

  try {
    const response = await fetch'/api/media/upload', {
      method: 'POST',
      body: formData,
    };

    if !response.ok {
      throw new Error'Upload failed';
    }

    return await response.json;
  } catch error {
    console.error'Error uploading image:', error;
    throw error;
  }
};

// Λήψη όλων των εικόνων από το Cloudinary
export const getImages = async : Promise<any[]> => {
  try {
    const response = await fetch'/api/media';
    
    if !response.ok {
      throw new Error'Failed to fetch images';
    }

    return await response.json;
  } catch error {
    console.error'Error fetching images:', error;
    throw error;
  }
};

// Διαγραφή εικόνας από το Cloudinary
export const deleteImage = async publicId: string: Promise<void> => {
  try {
    const response = await fetch`/api/media/${publicId}`, {
      method: 'DELETE',
    };

    if !response.ok {
      throw new Error'Delete failed';
    }
  } catch error {
    console.error'Error deleting image:', error;
    throw error;
  }
};
EOL

# Δημιουργία του API endpoint για upload στο Cloudinary
mkdir -p app/api/media
cat > app/api/media/upload/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function POSTreq: NextRequest {
  try {
    const formData = await req.formData;
    const file = formData.get'file' as File;

    if !file {
      return NextResponse.json
        { error: 'No file provided' },
        { status: 400 }
      ;
    }

    // Μετατροπή του File σε buffer
    const arrayBuffer = await file.arrayBuffer;
    const buffer = Buffer.fromarrayBuffer;

    // Μετατροπή του buffer σε base64 string για το Cloudinary
    const base64 = buffer.toString'base64';
    const base64File = `data:${file.type};base64,${base64}`;

    // Ανέβασμα στο Cloudinary
    const result = await new Promiseresolve, reject => {
      cloudinary.uploader.upload
        base64File,
        {
          folder: 'aion-cms',
        },
        error, result => {
          if error rejecterror;
          else resolveresult;
        }
      ;
    };

    return NextResponse.jsonresult;
  } catch error {
    console.error'Error uploading to Cloudinary:', error;
    return NextResponse.json
      { error: 'Error uploading file' },
      { status: 500 }
    ;
  }
}
EOL

# Δημιουργία του API endpoint για λήψη των εικόνων
cat > app/api/media/route.ts << 'EOL'
import { NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function GET {
  try {
    // Ανάκτηση των εικόνων από το Cloudinary
    const result = await new Promiseresolve, reject => {
      cloudinary.api.resources
        {
          type: 'upload',
          prefix: 'aion-cms',
          max_results: 500,
        },
        error, result => {
          if error rejecterror;
          else resolveresult;
        }
      ;
    };

    return NextResponse.jsonresult.resources;
  } catch error {
    console.error'Error fetching from Cloudinary:', error;
    return NextResponse.json
      { error: 'Error fetching images' },
      { status: 500 }
    ;
  }
}
EOL

# Δημιουργία του API endpoint για διαγραφή εικόνας
cat > app/api/media/[publicId]/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function DELETE
  req: NextRequest,
  { params }: { params: { publicId: string } }
 {
  try {
    const publicId = params.publicId;

    // Διαγραφή της εικόνας από το Cloudinary
    const result = await new Promiseresolve, reject => {
      cloudinary.uploader.destroy
        `aion-cms/${publicId}`,
        error, result => {
          if error rejecterror;
          else resolveresult;
        }
      ;
    };

    return NextResponse.jsonresult;
  } catch error {
    console.error'Error deleting from Cloudinary:', error;
    return NextResponse.json
      { error: 'Error deleting image' },
      { status: 500 }
    ;
  }
}
EOL

echo -e "${GREEN}Τα utilities και τα API endpoints για το Cloudinary δημιουργήθηκαν επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 10_setup_api.sh --------


# Χρωματιστή έξοδος

# Δημιουργία των βασικών API endpoints
echo -e "${GREEN}Δημιουργία των βασικών API endpoints...${NC}"

# Δημιουργία των τύπων για τα API
mkdir -p types
cat > types/index.ts << 'EOL'
export interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
  images: string[];
  categoryId: string;
  createdAt: string;
  updatedAt: string;
}

export interface Category {
  id: string;
  name: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
}

export interface MediaItem {
  id: string;
  publicId: string;
  url: string;
  secureUrl: string;
  format: string;
  width: number;
  height: number;
  createdAt: string;
}
EOL

# Δημιουργία του API endpoint για προϊόντα
mkdir -p app/api/products
cat > app/api/products/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Product } from '@/types';

// Προσωρινή αποθήκη προϊόντων θα αντικατασταθεί με πραγματική βάση δεδομένων
let products: Product[] = [
  {
    id: '1',
    name: 'Product 1',
    description: 'This is product 1',
    price: 29.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg'],
    categoryId: '1',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '2',
    name: 'Product 2',
    description: 'This is product 2',
    price: 49.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample2.jpg'],
    categoryId: '2',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '3',
    name: 'Product 3',
    description: 'This is product 3',
    price: 19.99,
    images: [],
    categoryId: '1',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
];

export async function GET {
  return NextResponse.jsonproducts;
}

export async function POSTreq: NextRequest {
  try {
    const data = await req.json;
    
    // Επικύρωση δεδομένων
    if !data.name || typeof data.price !== 'number' {
      return NextResponse.json
        { error: 'Invalid product data' },
        { status: 400 }
      ;
    }
    
    // Δημιουργία νέου προϊόντος
    const newProduct: Product = {
      id: Date.now.toString,
      name: data.name,
      description: data.description || '',
      price: data.price,
      images: data.images || [],
      categoryId: data.categoryId || '',
      createdAt: new Date.toISOString,
      updatedAt: new Date.toISOString,
    };
    
    // Προσθήκη στα προϊόντα
    products.pushnewProduct;
    
    return NextResponse.jsonnewProduct, { status: 201 };
  } catch error {
    console.error'Error creating product:', error;
    return NextResponse.json
      { error: 'Error creating product' },
      { status: 500 }
    ;
  }
}
EOL

# Δημιουργία του API endpoint για συγκεκριμένο προϊόν
cat > app/api/products/[id]/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Product } from '@/types';

// Προσωρινή αποθήκη προϊόντων θα αντικατασταθεί με πραγματική βάση δεδομένων
// Σημείωση: Σε πραγματική εφαρμογή, θα χρησιμοποιούσαμε μια βάση δεδομένων
let products: Product[] = [
  {
    id: '1',
    name: 'Product 1',
    description: 'This is product 1',
    price: 29.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg'],
    categoryId: '1',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '2',
    name: 'Product 2',
    description: 'This is product 2',
    price: 49.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample2.jpg'],
    categoryId: '2',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '3',
    name: 'Product 3',
    description: 'This is product 3',
    price: 19.99,
    images: [],
    categoryId: '1',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
];

export async function GET
  req: NextRequest,
  { params }: { params: { id: string } }
 {
  const product = products.findp => p.id === params.id;
  
  if !product {
    return NextResponse.json
      { error: 'Product not found' },
      { status: 404 }
    ;
  }
  
  return NextResponse.jsonproduct;
}

export async function PUT
  req: NextRequest,
  { params }: { params: { id: string } }
 {
  try {
    const data = await req.json;
    const index = products.findIndexp => p.id === params.id;
    
    if index === -1 {
      return NextResponse.json
        { error: 'Product not found' },
        { status: 404 }
      ;
    }
    
    // Ενημέρωση του προϊόντος
    products[index] = {
      ...products[index],
      ...data,
      updatedAt: new Date.toISOString,
    };
    
    return NextResponse.jsonproducts[index];
  } catch error {
    console.error'Error updating product:', error;
    return NextResponse.json
      { error: 'Error updating product' },
      { status: 500 }
    ;
  }
}

export async function DELETE
  req: NextRequest,
  { params }: { params: { id: string } }
 {
  const index = products.findIndexp => p.id === params.id;
  
  if index === -1 {
    return NextResponse.json
      { error: 'Product not found' },
      { status: 404 }
    ;
  }
  
  // Διαγραφή του προϊόντος
  products.spliceindex, 1;
  
  return NextResponse.json{ success: true };
}
EOL

# Δημιουργία του API endpoint για κατηγορίες
mkdir -p app/api/categories
cat > app/api/categories/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Category } from '@/types';

// Προσωρινή αποθήκη κατηγοριών θα αντικατασταθεί με πραγματική βάση δεδομένων
let categories: Category[] = [
  {
    id: '1',
    name: 'Category A',
    description: 'This is category A',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '2',
    name: 'Category B',
    description: 'This is category B',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '3',
    name: 'Category C',
    description: 'This is category C',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
];

export async function GET
  req: NextRequest,
  { params }: { params: { id: string } }
 {
  const category = categories.findc => c.id === params.id;
  
  if !category {
    return NextResponse.json
      { error: 'Category not found' },
      { status: 404 }
    ;
  }
  
  return NextResponse.jsoncategory;
}

export async function PUT
  req: NextRequest,
  { params }: { params: { id: string } }
 {
  try {
    const data = await req.json;
    const index = categories.findIndexc => c.id === params.id;
    
    if index === -1 {
      return NextResponse.json
        { error: 'Category not found' },
        { status: 404 }
      ;
    }
    
    // Ενημέρωση της κατηγορίας
    categories[index] = {
      ...categories[index],
      ...data,
      updatedAt: new Date.toISOString,
    };
    
    return NextResponse.jsoncategories[index];
  } catch error {
    console.error'Error updating category:', error;
    return NextResponse.json
      { error: 'Error updating category' },
      { status: 500 }
    ;
  }
}

export async function DELETE
  req: NextRequest,
  { params }: { params: { id: string } }
 {
  const index = categories.findIndexc => c.id === params.id;
  
  if index === -1 {
    return NextResponse.json
      { error: 'Category not found' },
      { status: 404 }
    ;
  }
  
  // Διαγραφή της κατηγορίας
  categories.spliceindex, 1;
  
  return NextResponse.json{ success: true };
}
EOL

echo -e "${GREEN}Τα API endpoints δημιουργήθηκαν επιτυχώς.${NC}"

export async function GET {
  return NextResponse.jsoncategories;
}

export async function POSTreq: NextRequest {
  try {
    const data = await req.json;
    
    // Επικύρωση δεδομένων
    if !data.name {
      return NextResponse.json
        { error: 'Category name is required' },
        { status: 400 }
      ;
    }
    
    // Δημιουργία νέας κατηγορίας
    const newCategory: Category = {
      id: Date.now.toString,
      name: data.name,
      description: data.description || '',
      createdAt: new Date.toISOString,
      updatedAt: new Date.toISOString,
    };
    
    // Προσθήκη στις κατηγορίες
    categories.pushnewCategory;
    
    return NextResponse.jsonnewCategory, { status: 201 };
  } catch error {
    console.error'Error creating category:', error;
    return NextResponse.json
      { error: 'Error creating category' },
      { status: 500 }
    ;
  }
}
EOL

# Δημιουργία του API endpoint για συγκεκριμένη κατηγορία
cat > app/api/categories/[id]/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Category } from '@/types';

// Προσωρινή αποθήκη κατηγοριών θα αντικατασταθεί με πραγματική βάση δεδομένων
let categories: Category[] = [
  {
    id: '1',
    name: 'Category A',
    description: 'This is category A',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '2',
    name: 'Category B',
    description: 'This is category B',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
  {
    id: '3',
    name: 'Category C',
    description: 'This is category C',
    createdAt: new Date.toISOString,
    updatedAt: new Date.toISOString,
  },
];
# -------- Περιεχόμενο από το 11_setup_utils.sh --------


# Χρωματιστή έξοδος

# Δημιουργία των βοηθητικών συναρτήσεων
echo -e "${GREEN}Δημιουργία των βοηθητικών συναρτήσεων...${NC}"

# Δημιουργία του φακέλου lib/utils αν δεν υπάρχει
mkdir -p lib/utils

# Δημιουργία του auth.ts utility
cat > lib/utils/auth.ts << 'EOL'
// Βασικές λειτουργίες αυθεντικοποίησης
// Σημείωση: Σε παραγωγικό περιβάλλον θα χρησιμοποιούσαμε κάποια πιο ασφαλή λύση π.χ. NextAuth.js

// Έλεγχος αν ο χρήστης είναι συνδεδεμένος
export const isLoggedIn = : boolean => {
  if typeof window === 'undefined' return false;
  
  return localStorage.getItem'isLoggedIn' === 'true';
};

// Σύνδεση χρήστη
export const login = username: string, password: string: boolean => {
  // Απλή υλοποίηση για τοπική ανάπτυξη
  // Σε πραγματική εφαρμογή, θα καλούσαμε ένα API endpoint
  if username === 'admin' && password === 'admin' {
    localStorage.setItem'isLoggedIn', 'true';
    return true;
  }
  
  return false;
};

// Αποσύνδεση χρήστη
export const logout = : void => {
  localStorage.removeItem'isLoggedIn';
  
  // Ανακατεύθυνση στη σελίδα login
  window.location.href = '/login';
};
EOL

# Δημιουργία του format.ts utility
cat > lib/utils/format.ts << 'EOL'
// Συναρτήσεις μορφοποίησης

// Μορφοποίηση τιμής σε νόμισμα
export const formatCurrency = value: number, locale = 'el-GR', currency = 'EUR': string => {
  return new Intl.NumberFormatlocale, {
    style: 'currency',
    currency,
  }.formatvalue;
};

// Μορφοποίηση ημερομηνίας
export const formatDate = dateString: string, locale = 'el-GR': string => {
  const date = new DatedateString;
  return new Intl.DateTimeFormatlocale, {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }.formatdate;
};

// Μορφοποίηση μεγέθους αρχείου
export const formatFileSize = bytes: number: string => {
  if bytes < 1024 return bytes + ' bytes';
  else if bytes < 1048576 return bytes / 1024.toFixed1 + ' KB';
  else return bytes / 1048576.toFixed1 + ' MB';
};
EOL

# Δημιουργία του api.ts utility
cat > lib/utils/api.ts << 'EOL'
// Βασικές συναρτήσεις για επικοινωνία με το API

// Ανάκτηση δεδομένων από το API
export const fetchData = async <T>endpoint: string: Promise<T> => {
  try {
    const response = await fetch`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}`;
    
    if !response.ok {
      throw new Error`API error: ${response.status}`;
    }
    
    return await response.json as T;
  } catch error {
    console.error`Error fetching from ${endpoint}:`, error;
    throw error;
  }
};

// Αποστολή δεδομένων στο API POST
export const postData = async <T>endpoint: string, data: any: Promise<T> => {
  try {
    const response = await fetch`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringifydata,
    };
    
    if !response.ok {
      throw new Error`API error: ${response.status}`;
    }
    
    return await response.json as T;
  } catch error {
    console.error`Error posting to ${endpoint}:`, error;
    throw error;
  }
};

// Ενημέρωση δεδομένων στο API PUT
export const updateData = async <T>endpoint: string, id: string, data: any: Promise<T> => {
  try {
    const response = await fetch`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}/${id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringifydata,
    };
    
    if !response.ok {
      throw new Error`API error: ${response.status}`;
    }
    
    return await response.json as T;
  } catch error {
    console.error`Error updating ${endpoint}/${id}:`, error;
    throw error;
  }
};

// Διαγραφή δεδομένων από το API DELETE
export const deleteData = async endpoint: string, id: string: Promise<void> => {
  try {
    const response = await fetch`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}/${id}`, {
      method: 'DELETE',
    };
    
    if !response.ok {
      throw new Error`API error: ${response.status}`;
    }
  } catch error {
    console.error`Error deleting ${endpoint}/${id}:`, error;
    throw error;
  }
};
EOL

# Δημιουργία του index.ts utility
cat > lib/utils/index.ts << 'EOL'
// Εξαγωγή όλων των utilities
export * from './auth';
export * from './format';
export * from './api';
EOL

echo -e "${GREEN}Οι βοηθητικές συναρτήσεις δημιουργήθηκαν επιτυχώς.${NC}"
# -------- Περιεχόμενο από το 12_create_readme.sh --------


# Ολοκλήρωση εγκατάστασης
echo -e "${GREEN}Η εγκατάσταση του AION CMS ολοκληρώθηκε επιτυχώς!${NC}"
echo -e "Μπορείτε να ξεκινήσετε την εφαρμογή με την εντολή: cd ${FOLDER_NAME} && npm run dev"
