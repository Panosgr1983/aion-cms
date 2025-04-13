#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία των βοηθητικών συναρτήσεων
echo -e "${GREEN}Δημιουργία των βοηθητικών συναρτήσεων...${NC}"

# Δημιουργία του φακέλου lib/utils αν δεν υπάρχει
mkdir -p lib/utils

# Δημιουργία του auth.ts utility
cat > lib/utils/auth.ts << 'EOL'
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
EOL

# Δημιουργία του format.ts utility
cat > lib/utils/format.ts << 'EOL'
// Συναρτήσεις μορφοποίησης

// Μορφοποίηση τιμής σε νόμισμα
export const formatCurrency = (value: number, locale = 'el-GR', currency = 'EUR'): string => {
  return new Intl.NumberFormat(locale, {
    style: 'currency',
    currency,
  }).format(value);
};

// Μορφοποίηση ημερομηνίας
export const formatDate = (dateString: string, locale = 'el-GR'): string => {
  const date = new Date(dateString);
  return new Intl.DateTimeFormat(locale, {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date);
};

// Μορφοποίηση μεγέθους αρχείου
export const formatFileSize = (bytes: number): string => {
  if (bytes < 1024) return bytes + ' bytes';
  else if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
  else return (bytes / 1048576).toFixed(1) + ' MB';
};
EOL

# Δημιουργία του api.ts utility
cat > lib/utils/api.ts << 'EOL'
// Βασικές συναρτήσεις για επικοινωνία με το API

// Ανάκτηση δεδομένων από το API
export const fetchData = async <T>(endpoint: string): Promise<T> => {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}`);
    
    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }
    
    return await response.json() as T;
  } catch (error) {
    console.error(`Error fetching from ${endpoint}:`, error);
    throw error;
  }
};

// Αποστολή δεδομένων στο API (POST)
export const postData = async <T>(endpoint: string, data: any): Promise<T> => {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    
    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }
    
    return await response.json() as T;
  } catch (error) {
    console.error(`Error posting to ${endpoint}:`, error);
    throw error;
  }
};

// Ενημέρωση δεδομένων στο API (PUT)
export const updateData = async <T>(endpoint: string, id: string, data: any): Promise<T> => {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}/${id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    });
    
    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }
    
    return await response.json() as T;
  } catch (error) {
    console.error(`Error updating ${endpoint}/${id}:`, error);
    throw error;
  }
};

// Διαγραφή δεδομένων από το API (DELETE)
export const deleteData = async (endpoint: string, id: string): Promise<void> => {
  try {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/${endpoint}/${id}`, {
      method: 'DELETE',
    });
    
    if (!response.ok) {
      throw new Error(`API error: ${response.status}`);
    }
  } catch (error) {
    console.error(`Error deleting ${endpoint}/${id}:`, error);
    throw error;
  }
};
EOL

# Δημιουργία του index.ts utility
cat > lib/utils/index.ts << 'EOL'
// Εξαγωγή όλων των utilities
export * from './auth';
export * from './format';
export * from './api';
EOL

echo -e "${GREEN}Οι βοηθητικές συναρτήσεις δημιουργήθηκαν επιτυχώς.${NC}"