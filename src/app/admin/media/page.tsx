'use client';

import React, { useState, useEffect } from 'react';
import ImageUploader from '../../../components/admin/ImageUploader';
type MediaItem = {
  id: string;
  url: string;
  name: string;
  format: string;
  size: number;
  created_at: string;
};

export default function MediaPage() {
  const [mediaItems, setMediaItems] = useState<MediaItem[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedItems, setSelectedItems] = useState<string[]>([]);
  const [isUploaderVisible, setIsUploaderVisible] = useState(false);

  // Προσομοίωση φόρτωσης δεδομένων από το Cloudinary
  useEffect(() => {
    const timer = setTimeout(() => {
      const dummyMedia: MediaItem[] = [
        {
          id: 'image1',
          url: 'https://res.cloudinary.com/duabzt63b/image/upload/v1617123456/sample1.jpg',
          name: 'product_candle_1.jpg',
          format: 'jpg',
          size: 1240000,
          created_at: '2025-03-15T10:30:00Z',
        },
        {
          id: 'image2',
          url: 'https://res.cloudinary.com/duabzt63b/image/upload/v1617123457/sample2.jpg',
          name: 'product_honey_1.jpg',
          format: 'jpg',
          size: 950000,
          created_at: '2025-03-20T14:45:00Z',
        },
        {
          id: 'image3',
          url: 'https://res.cloudinary.com/duabzt63b/image/upload/v1617123458/sample3.jpg',
          name: 'category_candles.jpg',
          format: 'jpg',
          size: 1050000,
          created_at: '2025-03-22T09:15:00Z',
        },
        {
          id: 'image4',
          url: 'https://res.cloudinary.com/duabzt63b/image/upload/v1617123459/sample4.jpg',
          name: 'banner_homepage.jpg',
          format: 'jpg',
          size: 2340000,
          created_at: '2025-03-25T16:20:00Z',
        },
        {
          id: 'image5',
          url: 'https://res.cloudinary.com/duabzt63b/image/upload/v1617123460/sample5.jpg',
          name: 'logo.png',
          format: 'png',
          size: 540000,
          created_at: '2025-03-10T11:10:00Z',
        },
      ];
      
      setMediaItems(dummyMedia);
      setIsLoading(false);
    }, 800);

    return () => clearTimeout(timer);
  }, []);

  // Φιλτράρισμα πολυμέσων βάσει αναζήτησης
  const filteredMedia = mediaItems.filter(item => 
    item.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Χειρισμός επιλογής/αποεπιλογής
  const toggleSelection = (id: string) => {
    if (selectedItems.includes(id)) {
      setSelectedItems(selectedItems.filter(itemId => itemId !== id));
    } else {
      setSelectedItems([...selectedItems, id]);
    }
  };

  // Προσομοίωση διαγραφής επιλεγμένων στοιχείων
  const deleteSelected = () => {
    if (selectedItems.length === 0) return;
    
    if (confirm(`Είστε σίγουροι ότι θέλετε να διαγράψετε ${selectedItems.length} στοιχεία;`)) {
      setMediaItems(mediaItems.filter(item => !selectedItems.includes(item.id)));
      setSelectedItems([]);
    }
  };

  // Προσομοίωση επιτυχούς ανεβάσματος εικόνας
  const handleUploadSuccess = (imageData: any) => {
    // Σε πραγματική εφαρμογή, το imageData θα περιείχε δεδομένα από το Cloudinary
    const newItem: MediaItem = {
      id: `image${mediaItems.length + 1}`,
      url: imageData.secure_url || 'https://res.cloudinary.com/duabzt63b/image/upload/v1617123461/sample6.jpg',
      name: imageData.original_filename || `new_upload_${Date.now()}.jpg`,
      format: imageData.format || 'jpg',
      size: imageData.bytes || 1000000,
      created_at: new Date().toISOString(),
    };
    
    setMediaItems([newItem, ...mediaItems]);
    setIsUploaderVisible(false);
  };

  // Μορφοποίηση μεγέθους αρχείου
  const formatFileSize = (bytes: number) => {
    if (bytes < 1024) return `${bytes} B`;
    if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(2)} KB`;
    return `${(bytes / (1024 * 1024)).toFixed(2)} MB`;
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Διαχείριση Πολυμέσων</h1>
        <div>
          {selectedItems.length > 0 ? (
            <button 
              onClick={deleteSelected}
              className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition mr-2"
            >
              Διαγραφή ({selectedItems.length})
            </button>
          ) : null}
          
          <button 
            onClick={() => setIsUploaderVisible(!isUploaderVisible)}
            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition"
          >
            {isUploaderVisible ? 'Ακύρωση' : '+ Ανέβασμα Εικόνας'}
          </button>
        </div>
      </div>

      {isUploaderVisible && (
        <div className="mb-6">
          <ImageUploader onUploadSuccess={handleUploadSuccess} />
        </div>
      )}

      <div className="mb-6">
        <input
          type="text"
          placeholder="Αναζήτηση πολυμέσων..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p>Φόρτωση πολυμέσων...</p>
        </div>
      ) : (
        <>
          {filteredMedia.length === 0 ? (
            <div className="text-center py-8 bg-white rounded-lg shadow-md">
              <p>Δεν βρέθηκαν πολυμέσα που να ταιριάζουν με την αναζήτησή σας.</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
              {filteredMedia.map((item) => (
                <div 
                  key={item.id} 
                  className={`bg-white rounded-lg shadow-md overflow-hidden ${
                    selectedItems.includes(item.id) ? 'ring-2 ring-blue-500' : ''
                  }`}
                  onClick={() => toggleSelection(item.id)}
                >
                  <div className="relative h-40 bg-gray-200">
                    <div className="absolute inset-0 flex items-center justify-center">
                      {/* Εδώ θα μπορούσαμε να έχουμε πραγματικές εικόνες από το Cloudinary */}
                      <div className="w-full h-full bg-gray-300 flex items-center justify-center">
                        <span className="text-gray-500">{item.format.toUpperCase()}</span>
                      </div>
                    </div>
                    {selectedItems.includes(item.id) && (
                      <div className="absolute top-2 left-2 w-6 h-6 bg-blue-500 rounded-full flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                        </svg>
                      </div>
                    )}
                  </div>
                  <div className="p-3">
                    <div className="truncate text-sm font-medium">{item.name}</div>
                    <div className="text-xs text-gray-500 mt-1">
                      {formatFileSize(item.size)} · {new Date(item.created_at).toLocaleDateString()}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}