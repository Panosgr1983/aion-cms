'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';

// Τύπος για τα προϊόντα
type Product = {
  id: number;
  name: string;
  price: number;
  category?: string;
  image?: string;
};

export default function ProductsPage() {
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');

  // Προσομοίωση φόρτωσης δεδομένων από το API/Cloudinary
  useEffect(() => {
    // Εδώ θα φορτώναμε τα δεδομένα από το API/Cloudinary
    const timer = setTimeout(() => {
      const dummyProducts: Product[] = [
        { id: 1, name: 'Κερί με Βανίλια', price: 12.5, category: 'Κεριά' },
        { id: 2, name: 'Αρωματικό Κερί Melisa', price: 18.9, category: 'Κεριά' },
        { id: 3, name: 'Καστανή Ζάχαρη Bio', price: 3.5, category: 'Γλυκαντικά' },
        { id: 4, name: 'Μέλι Ανθέων', price: 8.75, category: 'Γλυκαντικά' },
        { id: 5, name: 'Φυστικοβούτυρο', price: 5.99, category: 'Επάλειψη' },
        { id: 6, name: 'Ταχίνι Ολικής', price: 4.5, category: 'Επάλειψη' },
      ];
      
      setProducts(dummyProducts);
      setIsLoading(false);
    }, 800);

    return () => clearTimeout(timer);
  }, []);

  // Φιλτράρισμα προϊόντων βάσει αναζήτησης
  const filteredProducts = products.filter(product => 
    product.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
    (product.category && product.category.toLowerCase().includes(searchTerm.toLowerCase()))
  );

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Διαχείριση Προϊόντων</h1>
        <button className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition">
          + Νέο Προϊόν
        </button>
      </div>

      <div className="mb-6">
        <input
          type="text"
          placeholder="Αναζήτηση προϊόντων..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p>Φόρτωση προϊόντων...</p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-md overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Προϊόν
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Κατηγορία
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Τιμή
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Ενέργειες
                </th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {filteredProducts.map((product) => (
                <tr key={product.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="flex items-center">
                      <div className="h-10 w-10 flex-shrink-0 bg-gray-100 rounded-full mr-4">
                        {/* Εδώ θα μπορούσαμε να έχουμε μια εικόνα του προϊόντος */}
                      </div>
                      <div>
                        <div className="text-sm font-medium text-gray-900">{product.name}</div>
                        <div className="text-sm text-gray-500">ID: {product.id}</div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                      {product.category || 'Χωρίς κατηγορία'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    {product.price.toFixed(2)} €
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    <button className="text-indigo-600 hover:text-indigo-900 mr-4">
                      Επεξεργασία
                    </button>
                    <button className="text-red-600 hover:text-red-900">
                      Διαγραφή
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {filteredProducts.length === 0 && (
            <div className="text-center py-8">
              <p>Δεν βρέθηκαν προϊόντα που να ταιριάζουν με την αναζήτησή σας.</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
