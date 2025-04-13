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
