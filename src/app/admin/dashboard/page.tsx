'use client';

<<<<<<< HEAD
import { useState, useEffect } from 'react';
=======
import React, { useState, useEffect } from 'react';
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f

// Τύπος για τη στατιστική κάρτα
type StatCardProps = {
  title: string;
  value: number;
  icon: string;
  color: string;
};

// Component για τη στατιστική κάρτα
const StatCard = ({ title, value, icon, color }: StatCardProps) => (
  <div className={`p-6 rounded-lg shadow-md ${color}`}>
    <div className="flex items-center justify-between">
      <div>
        <p className="text-white text-sm">{title}</p>
        <h3 className="text-white text-2xl font-bold">{value}</h3>
      </div>
      <div className="text-white text-3xl">{icon}</div>
    </div>
  </div>
);

export default function DashboardPage() {
  // Τα στατιστικά δεδομένα (στατικά για τώρα)
  const [stats, setStats] = useState({
    products: 0,
    categories: 0,
    media: 0,
    users: 1
  });

  // Προσομοίωση φόρτωσης δεδομένων
  useEffect(() => {
    // Εδώ θα μπορούσαμε να φορτώσουμε τα δεδομένα από ένα API
    // Για τώρα, απλά θέτουμε κάποιες τιμές μετά από ένα μικρό delay
    const timer = setTimeout(() => {
      setStats({
        products: 24,
        categories: 6,
        media: 45,
        users: 1
      });
    }, 500);

    return () => clearTimeout(timer);
  }, []);

  return (
    <div>
      <h1 className="text-2xl font-bold mb-6">Καλωσήρθατε στο AION CMS</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <StatCard 
          title="Προϊόντα" 
          value={stats.products} 
          icon="📦" 
          color="bg-blue-500" 
        />
        <StatCard 
          title="Κατηγορίες" 
          value={stats.categories} 
          icon="🗂️" 
          color="bg-green-500" 
        />
        <StatCard 
          title="Πολυμέσα" 
          value={stats.media} 
          icon="🖼️" 
          color="bg-purple-500" 
        />
        <StatCard 
          title="Χρήστες" 
          value={stats.users} 
          icon="👤" 
          color="bg-orange-500" 
        />
      </div>
      
      <div className="bg-white rounded-lg shadow-md p-6">
        <h2 className="text-xl font-bold mb-4">Γρήγορες Ενέργειες</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <button className="p-4 bg-gray-100 rounded hover:bg-gray-200 transition">
            Προσθήκη Νέου Προϊόντος
          </button>
          <button className="p-4 bg-gray-100 rounded hover:bg-gray-200 transition">
            Ανέβασμα Εικόνας
          </button>
          <button className="p-4 bg-gray-100 rounded hover:bg-gray-200 transition">
            Προσθήκη Κατηγορίας
          </button>
        </div>
      </div>
    </div>
  );
}
