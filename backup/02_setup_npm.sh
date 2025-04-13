#!/bin/bash

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Αρχικοποίηση npm project
echo -e "${GREEN}Αρχικοποίηση npm project...${NC}"
cat > package.json << 'EOL'
{
  "name": "aion-cms",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@types/node": "^20.11.0",
    "@types/react": "^18.2.48",
    "@types/react-dom": "^18.2.18",
    "autoprefixer": "^10.4.16",
    "cloudinary": "^1.41.2",
    "eslint": "^8.56.0",
    "eslint-config-next": "^14.0.4",
    "next": "14.0.4",
    "postcss": "^8.4.33",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "tailwindcss": "^3.4.1",
    "typescript": "^5.3.3"
  }
}
EOL

echo -e "${GREEN}Το package.json δημιουργήθηκε επιτυχώς.${NC}"