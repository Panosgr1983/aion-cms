'use client';

<<<<<<< HEAD
import { useState } from 'react';
import { uploadImage } from '@/lib/cloudinary';
=======
import React, { useState } from 'react';
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f

type ImageUploaderProps = {
  onUploadSuccess?: (imageData: any) => void;
};

export default function ImageUploader({ onUploadSuccess }: ImageUploaderProps) {
  const [isUploading, setIsUploading] = useState(false);
  const [uploadError, setUploadError] = useState<string | null>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Δημιουργία preview URL για την εικόνα
    const fileUrl = URL.createObjectURL(file);
    setPreviewUrl(fileUrl);
    setUploadError(null);
  };

  const handleUpload = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    
    const fileInput = e.currentTarget.elements.namedItem('image') as HTMLInputElement;
    const file = fileInput.files?.[0];
    
    if (!file) {
      setUploadError('Παρακαλώ επιλέξτε ένα αρχείο.');
      return;
    }
    
    setIsUploading(true);
    
    try {
<<<<<<< HEAD
      const uploadResult = await uploadImage(file);
      
      if (uploadResult.error) {
        setUploadError(uploadResult.error.message || 'Σφάλμα κατά το ανέβασμα.');
      } else {
        if (onUploadSuccess) {
          onUploadSuccess(uploadResult);
=======
      // Σε πραγματική εφαρμογή, αυτό θα καλούσε το Cloudinary API
      // Για τώρα, προσομοιώνουμε μια επιτυχή απάντηση μετά από μικρή καθυστέρηση
      setTimeout(() => {
        const mockResponse = {
          secure_url: URL.createObjectURL(file),
          original_filename: file.name,
          format: file.name.split('.').pop(),
          bytes: file.size
        };
        
        if (onUploadSuccess) {
          onUploadSuccess(mockResponse);
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f
        }
        
        // Καθαρισμός μετά από επιτυχία
        setPreviewUrl(null);
        fileInput.value = '';
<<<<<<< HEAD
      }
    } catch (error: any) {
      setUploadError(error.message || 'Απρόσμενο σφάλμα κατά το ανέβασμα.');
    } finally {
=======
        setIsUploading(false);
      }, 1500);
    } catch (error: any) {
      setUploadError(error.message || 'Απρόσμενο σφάλμα κατά το ανέβασμα.');
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f
      setIsUploading(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-md p-6">
      <h2 className="text-xl font-bold mb-4">Ανέβασμα Εικόνας</h2>
      
      {uploadError && (
        <div className="mb-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
          {uploadError}
        </div>
      )}
      
      <form onSubmit={handleUpload}>
        <div className="mb-4">
          <label className="block text-gray-700 mb-2" htmlFor="image">
            Επιλογή εικόνας
          </label>
          <input
            id="image"
            name="image"
            type="file"
            accept="image/*"
            onChange={handleFileChange}
            className="w-full px-3 py-2 border border-gray-300 rounded"
            disabled={isUploading}
          />
        </div>
        
        {previewUrl && (
          <div className="mb-4">
            <p className="text-gray-700 mb-2">Προεπισκόπηση:</p>
            <div className="w-full h-48 bg-gray-100 rounded overflow-hidden">
              <img 
                src={previewUrl} 
                alt="Προεπισκόπηση" 
                className="w-full h-full object-contain" 
              />
            </div>
          </div>
        )}
        
        <button
          type="submit"
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition"
          disabled={isUploading}
        >
          {isUploading ? 'Ανέβασμα...' : 'Ανέβασμα Εικόνας'}
        </button>
      </form>
    </div>
  );
<<<<<<< HEAD
}
=======
}
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f
