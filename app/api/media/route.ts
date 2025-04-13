import { NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function GET() {
  try {
        // Ανάκτηση των εικόνων από το Cloudinary
    const result = await new Promise<any>((resolve, reject) => {
      cloudinary.v2.api.resources(
        {
          type: 'upload',
          prefix: 'aion-cms',
          max_results: 500,
        },
        (error: any, result: any) => {
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