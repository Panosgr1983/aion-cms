// Βασικές λειτουργίες αυθεντικοποίησης
// Σημείωση: Σε παραγωγικό περιβάλλον θα χρησιμοποιούσαμε κάποια πιο ασφαλή λύση (π.χ. NextAuth.js)

// Έλεγχος αν ο χρήστης είναι συνδεδεμένος
export const isLoggedIn = (): boolean => {
  if (typeof window === 'undefined') return false;
  
  return localStorage.getItem('isLoggedIn') === 'true';
};

// Σύνδεση χρήστη
export const login = (username: string, password: string): boolean => {
  // Απλή υλοποίηση για τοπική ανάπτυξη
  // Σε πραγματική εφαρμογή, θα καλούσαμε ένα API endpoint
  if (username === 'admin' && password === 'admin') {
    localStorage.setItem('isLoggedIn', 'true');
    return true;
  }
  
  return false;
};

// Αποσύνδεση χρήστη
export const logout = (): void => {
  localStorage.removeItem('isLoggedIn');
  
  // Ανακατεύθυνση στη σελίδα login
  window.location.href = '/login';
};
