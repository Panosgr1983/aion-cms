import './globals.css'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'AION CMS',
  description: 'A modern content management system',
}

export default function RootLayout{
  children,
}: {
  children: React.ReactNode
} {
  return 
    <html lang="en">
      <body>{children}</body>
    </html>
  
}
