'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import AdminSidebar from '@/components/admin/AdminSidebar';

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();

  const [isClient, setIsClient] = useState(false);
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [isLoginPage, setIsLoginPage] = useState(false);

  useEffect(() => {
    setIsClient(true);

    // Έλεγχος αν ο χρήστης είναι συνδεδεμένος
    const loggedIn = localStorage.getItem('isLoggedIn');
    setIsLoggedIn(!!loggedIn);

    // Έλεγχος αν βρισκόμαστε στη σελίδα login
    if (typeof window !== 'undefined') {
      setIsLoginPage(window.location.pathname === '/admin/login');

      // Αν δεν είναι συνδεδεμένος, ανακατεύθυνση στη σελίδα login
      if (!loggedIn && window.location.pathname !== '/admin/login') {
        router.push('/admin/login');
      }
    }
  }, [router]);

  // Εμφάνιση μόνο όταν εκτελείται στον client
  if (!isClient) return null;

  return (
    <div className="flex h-screen bg-gray-100">
      {!isLoginPage && isLoggedIn && <AdminSidebar />}
      <main className="flex-1 overflow-y-auto p-4">{children}</main>
    </div>
  );
}