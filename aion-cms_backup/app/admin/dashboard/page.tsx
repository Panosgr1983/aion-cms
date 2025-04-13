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
