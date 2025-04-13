"use client"
import Link from 'next/link'
import { usePathname } from 'next/navigation'

export default function Sidebar {
  const pathname = usePathname
  
  const links = [
    { href: '/dashboard', label: 'Dashboard' },
    { href: '/products', label: 'Products' },
    { href: '/categories', label: 'Categories' },
    { href: '/media', label: 'Media' },
  ]
  
  const handleLogout =  => {
    localStorage.removeItem'isLoggedIn'
    window.location.href = '/login'
  }

  return 
    <div className="w-64 bg-gray-800 text-white h-full flex flex-col">
      <div className="p-4 border-b border-gray-700">
        <h2 className="text-xl font-bold">AION CMS</h2>
      </div>
      
      <nav className="flex-1 p-4">
        <ul className="space-y-2">
          {links.maplink => 
            <li key={link.href}>
              <Link 
                href={link.href}
                className={`block px-4 py-2 rounded hover:bg-gray-700 ${pathname === link.href ? 'bg-gray-700' : ''}`}
              >
                {link.label}
              </Link>
            </li>
          }
        </ul>
      </nav>
      
      <div className="p-4 border-t border-gray-700">
        <button 
          onClick={handleLogout}
          className="block w-full px-4 py-2 text-left rounded hover:bg-gray-700"
        >
          Logout
        </button>
      </div>
    </div>
  
}
