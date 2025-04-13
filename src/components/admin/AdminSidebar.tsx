'use client';

<<<<<<< HEAD
=======
import React from 'react';
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import clsx from 'clsx';
import { useRouter } from 'next/navigation';

const AdminSidebar = () => {
  const pathname = usePathname();
  const router = useRouter();

  const links = [
    { label: 'Dashboard', href: '/admin/dashboard' },
    { label: 'Προϊόντα', href: '/admin/products' },
    { label: 'Κατηγορίες', href: '/admin/categories' },
    { label: 'Πολυμέσα', href: '/admin/media' }
  ];

  const handleLogout = () => {
    localStorage.removeItem('isLoggedIn');
    router.push('/admin/login');
  };

  return (
    <aside className="w-64 bg-gray-800 text-white p-4">
      <div className="text-xl font-bold mb-8">AION CMS</div>
      <nav>
        <ul className="space-y-2">
          {links.map((link) => (
            <li key={link.href}>
              <Link 
                href={link.href} 
                className={clsx(
                  "block p-2 rounded hover:bg-gray-700 transition",
                  pathname === link.href && "bg-gray-700"
                )}
              >
                {link.label}
              </Link>
            </li>
          ))}
        </ul>
      </nav>
      <div className="mt-auto pt-8">
        <button 
          onClick={handleLogout}
          className="w-full p-2 bg-red-600 text-white rounded hover:bg-red-700 transition"
        >
          Αποσύνδεση
        </button>
      </div>
    </aside>
  );
};

<<<<<<< HEAD
export default AdminSidebar;
=======
export default AdminSidebar;
>>>>>>> a9f1e74161aa60dd4fb3611586001be169da926f
