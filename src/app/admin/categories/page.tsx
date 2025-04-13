'use client';

import React, { useState, useEffect } from 'react';

type Category = {
  id: number;
  name: string;
  description?: string;
  productCount?: number;
};

export default function CategoriesPage() {
  const [categories, setCategories] = useState<Category[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');

  // Προσομοίωση φόρτωσης δεδομένων από το API
  useEffect(() => {
    const timer = setTimeout(() => {
      const dummyCategories: Category[] = [
        { id: 1, name: 'Κεριά', description: 'Αρωματικά κεριά σόγιας', productCount: 8 },
        { id: 2, name: 'Γλυκαντικά', description: 'Φυσικά γλυκαντικά', productCount: 5 },
        { id: 3, name: 'Επάλειψη', description: 'Φυσικά προϊόντα επάλειψης', productCount: 4 },
        { id: 4, name: 'Ξηροί Καρποί', description: 'Ωμοί και ψημένοι ξηροί καρποί', productCount: 12 },
        { id: 5, name: 'Superfoods', description: 'Τροφές υψηλής διατροφικής αξίας', productCount: 9 },
        { id: 6, name: 'Μαρμελάδες', description: 'Σπιτικές μαρμελάδες', productCount: 7 },
      ];
      
      setCategories(dummyCategories);
      setIsLoading(false);
    }, 800);

    return () => clearTimeout(timer);
  }, []);

  // Φιλτράρισμα κατηγοριών βάσει αναζήτησης
  const filteredCategories = categories.filter(category => 
    category.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
    (category.description && category.description.toLowerCase().includes(searchTerm.toLowerCase()))
  );

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Διαχείριση Κατηγοριών</h1>
        <button className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition">
          + Νέα Κατηγορία
        </button>
      </div>

      <div className="mb-6">
        <input
          type="text"
          placeholder="Αναζήτηση κατηγοριών..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>

      {isLoading ? (
        <div className="text-center py-8">
          <p>Φόρτωση κατηγοριών...</p>
        </div>
      ) : (
        <div className="bg-white rounded-lg shadow-md overflow-hidden">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Όνομα
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Περιγραφή
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Προϊόντα
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Ενέργειες
                </th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {filteredCategories.map((category) => (
                <tr key={category.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="text-sm font-medium text-gray-900">{category.name}</div>
                    <div className="text-sm text-gray-500">ID: {category.id}</div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className="text-sm text-gray-500">
                      {category.description || 'Χωρίς περιγραφή'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                      {category.productCount || 0}
                    </span>
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

          {filteredCategories.length === 0 && (
            <div className="text-center py-8">
              <p>Δεν βρέθηκαν κατηγορίες που να ταιριάζουν με την αναζήτησή σας.</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}