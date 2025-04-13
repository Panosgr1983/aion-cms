#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Δημιουργία του README.md
echo -e "${GREEN}Δημιουργία του README.md...${NC}"

cat > README.md << 'EOL'
# AION CMS

Το AION CMS είναι ένα σύγχρονο Content Management System βασισμένο στο Next.js 14, TypeScript και Cloudinary.

## Λειτουργίες

- **Διαχείριση Προϊόντων**: Προσθήκη, επεξεργασία και διαγραφή προϊόντων
- **Διαχείριση Κατηγοριών**: Οργάνωση προϊόντων σε κατηγορίες
- **Διαχείριση Πολυμέσων**: Ανέβασμα και διαχείριση εικόνων μέσω του Cloudinary
- **Αυθεντικοποίηση**: Βασικό σύστημα login (για ανάπτυξη)
- **API**: RESTful API για όλες τις λειτουργίες του συστήματος

## Τεχνολογίες

- **Frontend**: Next.js 14, React, TypeScript, Tailwind CSS
- **Backend**: Next.js API Routes
- **Διαχείριση Εικόνων**: Cloudinary
- **Styling**: Tailwind CSS

## Εγκατάσταση

1. Κλωνοποιήστε το repository:
   ```
   git clone https://github.com/yourusername/aion-cms.git
   cd aion-cms
   ```

2. Εγκαταστήστε τις εξαρτήσεις:
   ```
   npm install
   ```

3. Δημιουργήστε ένα αρχείο `.env.local` με τις ακόλουθες μεταβλητές:
   ```
   NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_API_KEY=your_api_key
   CLOUDINARY_API_SECRET=your_api_secret
   NEXT_PUBLIC_API_URL=http://localhost:3000/api
   ```

4. Εκκινήστε τον development server:
   ```
   npm run dev
   ```

5. Ανοίξτε το [http://localhost:3000](http://localhost:3000) στον browser σας.

## Χρήση

### Login

- Για να συνδεθείτε στο διαχειριστικό panel, χρησιμοποιήστε:
  - Username: `admin`
  - Password: `admin`

### Διαχείριση Προϊόντων

- Προβολή όλων των προϊόντων: `/products`
- Προσθήκη νέου προϊόντος: `/products/new`
- Επεξεργασία προϊόντος: `/products/edit/[id]`

### Διαχείριση Κατηγοριών

- Προβολή όλων των κατηγοριών: `/categories`
- Προσθήκη νέας κατηγορίας: `/categories/new`
- Επεξεργασία κατηγορίας: `/categories/edit/[id]`

### Διαχείριση Πολυμέσων

- Προβολή βιβλιοθήκης πολυμέσων: `/media`
- Ανέβασμα νέων εικόνων: Χρησιμοποιήστε το κουμπί "Upload Files" στη σελίδα `/media`

## API Endpoints

### Προϊόντα

- `GET /api/products`: Ανάκτηση όλων των προϊόντων
- `POST /api/products`: Δημιουργία νέου προϊόντος
- `GET /api/products/[id]`: Ανάκτηση συγκεκριμένου προϊόντος
- `PUT /api/products/[id]`: Ενημέρωση συγκεκριμένου προϊόντος
- `DELETE /api/products/[id]`: Διαγραφή συγκεκριμένου προϊόντος

### Κατηγορίες

- `GET /api/categories`: Ανάκτηση όλων των κατηγοριών
- `POST /api/categories`: Δημιουργία νέας κατηγορίας
- `GET /api/categories/[id]`: Ανάκτηση συγκεκριμένης κατηγορίας
- `PUT /api/categories/[id]`: Ενημέρωση συγκεκριμένης κατηγορίας
- `DELETE /api/categories/[id]`: Διαγραφή συγκεκριμένης κατηγορίας

### Πολυμέσα

- `GET /api/media`: Ανάκτηση όλων των εικόνων
- `POST /api/media/upload`: Ανέβασμα νέας εικόνας
- `DELETE /api/media/[publicId]`: Διαγραφή συγκεκριμένης εικόνας

## Μελλοντικές βελτιώσεις

- Ενσωμάτωση πραγματικής βάσης δεδομένων (MongoDB, PostgreSQL)
- Προσθήκη πιο ασφαλούς συστήματος αυθεντικοποίησης (π.χ. NextAuth.js)
- Ενσωμάτωση προηγμένων λειτουργιών επεξεργασίας εικόνων
- Υποστήριξη για άλλους τύπους περιεχομένου (blog posts, σελίδες)
- Βελτιωμένο UI/UX
EOL

# Ενημέρωση του κύριου script
echo -e "${GREEN}Ενημέρωση του κύριου script για να συμπεριλάβει το README.md...${NC}"

# Δημιουργία του υπόλοιπου του οδηγού εγκατάστασης
cat > SETUP-GUIDE.md << 'EOL'
# Οδηγός Εγκατάστασης του AION CMS

Αυτός ο οδηγός θα σας βοηθήσει να εγκαταστήσετε και να ρυθμίσετε το AION CMS.

## 1. Προετοιμασία Περιβάλλοντος

Βεβαιωθείτε ότι έχετε εγκατεστημένα τα ακόλουθα:

- Node.js (έκδοση 18 ή νεότερη)
- npm (έκδοση 8 ή νεότερη)
- Git

## 2. Εκτέλεση του Script Εγκατάστασης

Για να εγκαταστήσετε το AION CMS, εκτελέστε το ακόλουθο script:

```bash
./01_setup_main.sh [όνομα-φακέλου]
```

Όπου `[όνομα-φακέλου]` είναι το όνομα του φακέλου στον οποίο θέλετε να εγκατασταθεί το CMS. Αν δεν δώσετε όνομα φακέλου, θα χρησιμοποιηθεί το προεπιλεγμένο "aion-cms".

## 3. Ρύθμιση του Cloudinary

1. Δημιουργήστε έναν λογαριασμό στο [Cloudinary](https://cloudinary.com/)
2. Αποκτήστε τα API κλειδιά σας από το Cloudinary Dashboard
3. Ενημερώστε το αρχείο `.env.local` με τα κλειδιά σας:
   ```
   NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=το_όνομα_cloud_σας
   CLOUDINARY_API_KEY=το_api_key_σας
   CLOUDINARY_API_SECRET=το_api_secret_σας
   ```

## 4. Εκκίνηση της Εφαρμογής

Για να εκκινήσετε την εφαρμογή, εκτελέστε:

```bash
cd [όνομα-φακέλου]
npm run dev
```

Η εφαρμογή θα είναι διαθέσιμη στη διεύθυνση [http://localhost:3000](http://localhost:3000).

## 5. Σύνδεση στο Διαχειριστικό Panel

Για να συνδεθείτε στο διαχειριστικό panel:

1. Πλοηγηθείτε στη διεύθυνση [http://localhost:3000/login](http://localhost:3000/login)
2. Χρησιμοποιήστε τα παρακάτω στοιχεία:
   - Username: `admin`
   - Password: `admin`

## 6. Επόμενα Βήματα

Μετά την εγκατάσταση, μπορείτε να:

1. Προσαρμόσετε το UI/UX
2. Ενσωματώσετε πραγματική βάση δεδομένων
3. Βελτιώσετε το σύστημα αυθεντικοποίησης
4. Προσθέσετε επιπλέον λειτουργίες
EOL

echo -e "${GREEN}Το README.md και ο οδηγός εγκατάστασης δημιουργήθηκαν επιτυχώς.${NC}"