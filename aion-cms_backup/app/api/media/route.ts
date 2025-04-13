import { NextResponse } from 'next/server';
import cloudinary from '@/lib/cloudinary';

export async function GET {
  try {
    // Ανάκτηση των εικόνων από το Cloudinary
    const result = await new Promiseresolve, reject => {
      cloudinary.api.resources
        {
          type: 'upload',
          prefix: 'aion-cms',
          max_results: 500,
        },
        error, result => {
          if error rejecterror;
          else resolveresult;
        }
      ;
    };

    return NextResponse.jsonresult.resources;
  } catch error {
    console.error'Error fetching from Cloudinary:', error;
    return NextResponse.json
      { error: 'Error fetching images' },
      { status: 500 }
    ;
  }
}
