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
