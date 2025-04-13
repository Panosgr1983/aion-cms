"use client"
import { useEffect, useState } from 'react'
import { useRouter } from 'next/navigation'
import Sidebar from '@/components/admin/Sidebar'

export default function AdminLayout{
  children,
}: {
  children: React.ReactNode
} {
  const router = useRouter
  const [isClient, setIsClient] = useStatefalse

  useEffect => {
    setIsClienttrue
    const isLoggedIn = localStorage.getItem'isLoggedIn'
    if !isLoggedIn || isLoggedIn !== 'true' {
      router.push'/login'
    }
  }, [router]

  if !isClient {
    return <div>Loading...</div>
  }

  return 
    <div className="flex h-screen bg-gray-100">
      <Sidebar />
      <div className="flex-1 overflow-auto p-8">
        {children}
      </div>
    </div>
  
}
