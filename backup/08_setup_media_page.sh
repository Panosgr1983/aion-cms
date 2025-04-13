#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία της σελίδας διαχείρισης πολυμέσων
echo -e "${GREEN}Δημιουργία της σελίδας διαχείρισης πολυμέσων...${NC}"

# Δημιουργία media page
mkdir -p app/(admin)/media
cat > app/(admin)/media/page.tsx << 'EOL'
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

export default function Media() {
  const [mediaItems, setMediaItems] = useState<MediaItem[]>([])
  const [loading, setLoading] = useState(true)
  const [uploading, setUploading] = useState(false)

  useEffect(() => {
    // Εδώ θα φορτώναμε πραγματικά αρχεία από το Cloudinary μέσω του API
    // Για τώρα χρησιμοποιούμε δοκιμαστικά δεδομένα
    setTimeout(() => {
      setMediaItems([
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
      ])
      setLoading(false)
    }, 500)
  }, [])

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files
    if (!files || files.length === 0) return

    setUploading(true)
    
    // Εδώ θα ανεβάζαμε τα αρχεία στο Cloudinary μέσω του API
    // Για τώρα προσομοιώνουμε το ανέβασμα
    setTimeout(() => {
      const newMediaItems = [...mediaItems]
      
      for (let i = 0; i < files.length; i++) {
        const file = files[i]
        newMediaItems.push({
          id: `new-${Date.now()}-${i}`,
          url: URL.createObjectURL(file),
          name: file.name,
          type: file.type,
          size: file.size
        })
      }
      
      setMediaItems(newMediaItems)
      setUploading(false)
    }, 1500)
  }

  const formatFileSize = (bytes: number) => {
    if (bytes < 1024) return bytes + ' bytes'
    else if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB'
    else return (bytes / 1048576).toFixed(1) + ' MB'
  }

  return (
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

      {loading ? (
        <div className="text-center py-4">Loading media...</div>
      ) : (
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {mediaItems.map((item) => (
            <div
              key={item.id}
              className="bg-white rounded-lg shadow overflow-hidden"
            >
              <div className="relative h-40 bg-gray-100">
                {item.type.startsWith('image/') ? (
                  <img
                    src={item.url}
                    alt={item.name}
                    className="w-full h-full object-cover"
                  />
                ) : (
                  <div className="flex items-center justify-center h-full">
                    <span className="text-gray-400">{item.type}</span>
                  </div>
                )}
              </div>
              <div className="p-3">
                <p className="text-sm font-medium text-gray-900 truncate">{item.name}</p>
                <p className="text-xs text-gray-500">{formatFileSize(item.size)}</p>
              </div>
              <div className="bg-gray-50 px-3 py-2 text-right">
                <button
                  className="text-red-600 text-xs hover:text-red-900"
                  onClick={() => {
                    if (confirm('Are you sure you want to delete this file?')) {
                      // Εδώ θα καλούσαμε το API για διαγραφή από το Cloudinary
                      setMediaItems(mediaItems.filter(m => m.id !== item.id))
                    }
                  }}
                >
                  Delete
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
EOL

echo -e "${GREEN}Η σελίδα διαχείρισης πολυμέσων δημιουργήθηκε επιτυχώς.${NC}"