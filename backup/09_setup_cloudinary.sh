#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία των utilities για το Cloudinary
echo -e "${GREEN}Δημιουργία των utilities για το Cloudinary...${NC}"

# Δημιουργία του φακέλου lib/cloudinary αν δεν υπάρχει
mkdir -p lib/cloudinary

# Δημιουργία του cloudinary.ts utility
cat > lib/cloudinary/index.ts << 'EOL'
import { v2 as cloudinary } from 'cloudinary';

// Ρύθμιση του Cloudinary
cloudinary.config({
  cloud_name: process.env.NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

export default cloudinary;

// Ανέβασμα εικόνας στο Cloudinary
export const uploadImage = async (file: File): Promise<any> => {
  // Στον client, θα πρέπει να στείλουμε το αρχείο στο API μας, το οποίο
  // στη συνέχεια θα το ανεβάσει στο Cloudinary
  const formData = new FormData();
  formData.append('file', file);

  try {
    const response = await fetch('/api/media/upload', {
      method: 'POST',
      body: formData,
    });

    if (!response.ok) {
      throw new Error('Upload failed');
    }

    return await response.json();
  } catch (error) {
    console.error('Error uploading image:', error);
    throw error;
  }
};

// Λήψη όλων των εικόνων από το Cloudinary
export const getImages = async (): Promise<any[]> => {
  try {
    const response = await fetch('/api/media');
    
    if (!response.ok) {
      throw new Error('Failed to fetch images');
    }

    return await response.json();
  } catch (error) {
    console.error('Error fetching images:', error);
    throw error;
  }
};

// Διαγραφή εικόνας από το Cloudinary
export const deleteImage = async (publicId: string): Promise<void> => {
  try {
    const response = await fetch(`/api/media/${publicId}`, {
      method: 'DELETE',
    });

    if (!response.ok) {
      throw new Error('Delete failed');
    }
  } catch (error) {
    console.error('Error deleting image:', error);
    throw error;
  }
};
EOL

# Δημιουργία του API endpoint για upload στο Cloudinary
mkdir -p app/api/media
cat > app/api/media/upload/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData();
    const file = formData.get('file') as File;

    if (!file) {
      return NextResponse.json(
        { error: 'No file provided' },
        { status: 400 }
      );
    }

    // Μετατροπή του File σε buffer
    const arrayBuffer = await file.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    // Μετατροπή του buffer σε base64 string για το Cloudinary
    const base64 = buffer.toString('base64');
    const base64File = `data:${file.type};base64,${base64}`;

    // Ανέβασμα στο Cloudinary
    const result = await new Promise((resolve, reject) => {
      cloudinary.uploader.upload(
        base64File,
        {
          folder: 'aion-cms',
        },
        (error, result) => {
          if (error) reject(error);
          else resolve(result);
        }
      );
    });

    return NextResponse.json(result);
  } catch (error) {
    console.error('Error uploading to Cloudinary:', error);
    return NextResponse.json(
      { error: 'Error uploading file' },
      { status: 500 }
    );
  }
}
EOL

# Δημιουργία του API endpoint για λήψη των εικόνων
cat > app/api/media/route.ts << 'EOL'
import { NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function GET() {
  try {
    // Ανάκτηση των εικόνων από το Cloudinary
    const result = await new Promise((resolve, reject) => {
      cloudinary.api.resources(
        {
          type: 'upload',
          prefix: 'aion-cms',
          max_results: 500,
        },
        (error, result) => {
          if (error) reject(error);
          else resolve(result);
        }
      );
    });

    return NextResponse.json(result.resources);
  } catch (error) {
    console.error('Error fetching from Cloudinary:', error);
    return NextResponse.json(
      { error: 'Error fetching images' },
      { status: 500 }
    );
  }
}
EOL

# Δημιουργία του API endpoint για διαγραφή εικόνας
cat > app/api/media/[publicId]/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function DELETE(
  req: NextRequest,
  { params }: { params: { publicId: string } }
) {
  try {
    const publicId = params.publicId;

    // Διαγραφή της εικόνας από το Cloudinary
    const result = await new Promise((resolve, reject) => {
      cloudinary.uploader.destroy(
        `aion-cms/${publicId}`,
        (error, result) => {
          if (error) reject(error);
          else resolve(result);
        }
      );
    });

    return NextResponse.json(result);
  } catch (error) {
    console.error('Error deleting from Cloudinary:', error);
    return NextResponse.json(
      { error: 'Error deleting image' },
      { status: 500 }
    );
  }
}
EOL

echo -e "${GREEN}Τα utilities και τα API endpoints για το Cloudinary δημιουργήθηκαν επιτυχώς.${NC}"