import Link from 'next/link'

export default function Home {
  return 
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold mb-6">AION CMS</h1>
      <p className="mb-8 text-lg">A modern content management system</p>
      <Link
        href="/login"
        className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
      >
        Go to Login
      </Link>
    </main>
  
}
