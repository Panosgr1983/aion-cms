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
