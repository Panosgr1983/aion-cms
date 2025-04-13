import { redirect } from 'next/navigation';

export default function Home() {
  // Ανακατεύθυνση στην σελίδα login του admin panel
  redirect('/admin/login');
}
