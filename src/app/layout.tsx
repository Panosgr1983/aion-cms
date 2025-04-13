import React from 'react';
import './globals.css';

export const metadata = {
  title: 'AION CMS',
  description: 'Content Management System για ηλεκτρονικά καταστήματα',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="el">
      <body className="min-h-screen bg-gray-50">{children}</body>
    </html>
  )
}