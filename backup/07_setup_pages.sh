#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία των σελίδων του admin panel
echo -e "${GREEN}Δημιουργία των βασικών σελίδων του admin panel...${NC}"

# Δημιουργία dashboard page
mkdir -p app/(admin)/dashboard
cat > app/(admin)/dashboard/page.tsx << 'EOL'
"use client"
import { useEffect, useState } from 'react'

export default function Dashboard() {
  const [stats, setStats] = useState({
    products: 0,
    categories: 0,
    media: 0
  })

  useEffect(() => {
    // Εδώ θα φορτώναμε πραγματικά στατιστικά από το API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setStats({
      products: 24,
      categories: 8,
      media: 56
    })
  }, [])

  return (
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
  )
}
EOL

# Δημιουργία products page
mkdir -p app/(admin)/products
cat > app/(admin)/products/page.tsx << 'EOL'
"use client"
import { useState, useEffect } from 'react'
import Link from 'next/link'

interface Product {
  id: string
  name: string
  category: string
  price: number
}

export default function Products() {
  const [products, setProducts] = useState<Product[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    // Εδώ θα φορτώναμε πραγματικά προϊόντα από το API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setTimeout(() => {
      setProducts([
        { id: '1', name: 'Product 1', category: 'Category A', price: 29.99 },
        { id: '2', name: 'Product 2', category: 'Category B', price: 49.99 },
        { id: '3', name: 'Product 3', category: 'Category A', price: 19.99 },
      ])
      setLoading(false)
    }, 500)
  }, [])

  return (
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

      {loading ? (
        <div className="text-center py-4">Loading products...</div>
      ) : (
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
              {products.map((product) => (
                <tr key={product.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm font-medium text-gray-900">{product.name}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-500">{product.category}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm text-gray-500">${product.price.toFixed(2)}</div>
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
                      onClick={() => {
                        if (confirm('Are you sure you want to delete this product?')) {
                          // Εδώ θα καλούσαμε το API για διαγραφή
                          setProducts(products.filter(p => p.id !== product.id))
                        }
                      }}
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}
EOL

# Δημιουργία categories page
mkdir -p app/(admin)/categories
cat > app/(admin)/categories/page.tsx << 'EOL'
"use client"
import { useState, useEffect } from 'react'
import Link from 'next/link'

interface Category {
  id: string
  name: string
  productCount: number
}

export default function Categories() {
  const [categories, setCategories] = useState<Category[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    // Εδώ θα φορτώναμε πραγματικές κατηγορίες από το API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setTimeout(() => {
      setCategories([
        { id: '1', name: 'Category A', productCount: 12 },
        { id: '2', name: 'Category B', productCount: 8 },
        { id: '3', name: 'Category C', productCount: 4 },
      ])
      setLoading(false)
    }, 500)
  }, [])

  return (
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

      {loading ? (
        <div className="text-center py-4">Loading categories...</div>
      ) : (
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
              {categories.map((category) => (
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
                      onClick={() => {
                        if (confirm('Are you sure you want to delete this category?')) {
                          // Εδώ θα καλούσαμε το API για διαγραφή
                          setCategories(categories.filter(c => c.id !== category.id))
                        }
                      }}
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}
EOL