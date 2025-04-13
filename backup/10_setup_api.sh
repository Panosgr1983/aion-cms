#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία των βασικών API endpoints
echo -e "${GREEN}Δημιουργία των βασικών API endpoints...${NC}"

# Δημιουργία των τύπων για τα API
mkdir -p types
cat > types/index.ts << 'EOL'
export interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
  images: string[];
  categoryId: string;
  createdAt: string;
  updatedAt: string;
}

export interface Category {
  id: string;
  name: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
}

export interface MediaItem {
  id: string;
  publicId: string;
  url: string;
  secureUrl: string;
  format: string;
  width: number;
  height: number;
  createdAt: string;
}
EOL

# Δημιουργία του API endpoint για προϊόντα
mkdir -p app/api/products
cat > app/api/products/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Product } from '@/types';

// Προσωρινή αποθήκη προϊόντων (θα αντικατασταθεί με πραγματική βάση δεδομένων)
let products: Product[] = [
  {
    id: '1',
    name: 'Product 1',
    description: 'This is product 1',
    price: 29.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg'],
    categoryId: '1',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '2',
    name: 'Product 2',
    description: 'This is product 2',
    price: 49.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample2.jpg'],
    categoryId: '2',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '3',
    name: 'Product 3',
    description: 'This is product 3',
    price: 19.99,
    images: [],
    categoryId: '1',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

export async function GET() {
  return NextResponse.json(products);
}

export async function POST(req: NextRequest) {
  try {
    const data = await req.json();
    
    // Επικύρωση δεδομένων
    if (!data.name || typeof data.price !== 'number') {
      return NextResponse.json(
        { error: 'Invalid product data' },
        { status: 400 }
      );
    }
    
    // Δημιουργία νέου προϊόντος
    const newProduct: Product = {
      id: Date.now().toString(),
      name: data.name,
      description: data.description || '',
      price: data.price,
      images: data.images || [],
      categoryId: data.categoryId || '',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    
    // Προσθήκη στα προϊόντα
    products.push(newProduct);
    
    return NextResponse.json(newProduct, { status: 201 });
  } catch (error) {
    console.error('Error creating product:', error);
    return NextResponse.json(
      { error: 'Error creating product' },
      { status: 500 }
    );
  }
}
EOL

# Δημιουργία του API endpoint για συγκεκριμένο προϊόν
cat > app/api/products/[id]/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Product } from '@/types';

// Προσωρινή αποθήκη προϊόντων (θα αντικατασταθεί με πραγματική βάση δεδομένων)
// Σημείωση: Σε πραγματική εφαρμογή, θα χρησιμοποιούσαμε μια βάση δεδομένων
let products: Product[] = [
  {
    id: '1',
    name: 'Product 1',
    description: 'This is product 1',
    price: 29.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg'],
    categoryId: '1',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '2',
    name: 'Product 2',
    description: 'This is product 2',
    price: 49.99,
    images: ['https://res.cloudinary.com/demo/image/upload/v1312461204/sample2.jpg'],
    categoryId: '2',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '3',
    name: 'Product 3',
    description: 'This is product 3',
    price: 19.99,
    images: [],
    categoryId: '1',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  const product = products.find(p => p.id === params.id);
  
  if (!product) {
    return NextResponse.json(
      { error: 'Product not found' },
      { status: 404 }
    );
  }
  
  return NextResponse.json(product);
}

export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const data = await req.json();
    const index = products.findIndex(p => p.id === params.id);
    
    if (index === -1) {
      return NextResponse.json(
        { error: 'Product not found' },
        { status: 404 }
      );
    }
    
    // Ενημέρωση του προϊόντος
    products[index] = {
      ...products[index],
      ...data,
      updatedAt: new Date().toISOString(),
    };
    
    return NextResponse.json(products[index]);
  } catch (error) {
    console.error('Error updating product:', error);
    return NextResponse.json(
      { error: 'Error updating product' },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  const index = products.findIndex(p => p.id === params.id);
  
  if (index === -1) {
    return NextResponse.json(
      { error: 'Product not found' },
      { status: 404 }
    );
  }
  
  // Διαγραφή του προϊόντος
  products.splice(index, 1);
  
  return NextResponse.json({ success: true });
}
EOL

# Δημιουργία του API endpoint για κατηγορίες
mkdir -p app/api/categories
cat > app/api/categories/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Category } from '@/types';

// Προσωρινή αποθήκη κατηγοριών (θα αντικατασταθεί με πραγματική βάση δεδομένων)
let categories: Category[] = [
  {
    id: '1',
    name: 'Category A',
    description: 'This is category A',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '2',
    name: 'Category B',
    description: 'This is category B',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '3',
    name: 'Category C',
    description: 'This is category C',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  const category = categories.find(c => c.id === params.id);
  
  if (!category) {
    return NextResponse.json(
      { error: 'Category not found' },
      { status: 404 }
    );
  }
  
  return NextResponse.json(category);
}

export async function PUT(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const data = await req.json();
    const index = categories.findIndex(c => c.id === params.id);
    
    if (index === -1) {
      return NextResponse.json(
        { error: 'Category not found' },
        { status: 404 }
      );
    }
    
    // Ενημέρωση της κατηγορίας
    categories[index] = {
      ...categories[index],
      ...data,
      updatedAt: new Date().toISOString(),
    };
    
    return NextResponse.json(categories[index]);
  } catch (error) {
    console.error('Error updating category:', error);
    return NextResponse.json(
      { error: 'Error updating category' },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  const index = categories.findIndex(c => c.id === params.id);
  
  if (index === -1) {
    return NextResponse.json(
      { error: 'Category not found' },
      { status: 404 }
    );
  }
  
  // Διαγραφή της κατηγορίας
  categories.splice(index, 1);
  
  return NextResponse.json({ success: true });
}
EOL

echo -e "${GREEN}Τα API endpoints δημιουργήθηκαν επιτυχώς.${NC}"

export async function GET() {
  return NextResponse.json(categories);
}

export async function POST(req: NextRequest) {
  try {
    const data = await req.json();
    
    // Επικύρωση δεδομένων
    if (!data.name) {
      return NextResponse.json(
        { error: 'Category name is required' },
        { status: 400 }
      );
    }
    
    // Δημιουργία νέας κατηγορίας
    const newCategory: Category = {
      id: Date.now().toString(),
      name: data.name,
      description: data.description || '',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    
    // Προσθήκη στις κατηγορίες
    categories.push(newCategory);
    
    return NextResponse.json(newCategory, { status: 201 });
  } catch (error) {
    console.error('Error creating category:', error);
    return NextResponse.json(
      { error: 'Error creating category' },
      { status: 500 }
    );
  }
}
EOL

# Δημιουργία του API endpoint για συγκεκριμένη κατηγορία
cat > app/api/categories/[id]/route.ts << 'EOL'
import { NextRequest, NextResponse } from 'next/server';
import { Category } from '@/types';

// Προσωρινή αποθήκη κατηγοριών (θα αντικατασταθεί με πραγματική βάση δεδομένων)
let categories: Category[] = [
  {
    id: '1',
    name: 'Category A',
    description: 'This is category A',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '2',
    name: 'Category B',
    description: 'This is category B',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: '3',
    name: 'Category C',
    description: 'This is category C',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];