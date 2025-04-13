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
