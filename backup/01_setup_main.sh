#!/bin/bash

# AION CMS Generator Script - Main Setup
# Δημιουργεί αυτόματα την αρχική δομή και τα απαραίτητα αρχεία για το AION CMS

# Χρωματιστή έξοδος για καλύτερη αναγνωσιμότητα
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Εμφάνιση banner
echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}         AION CMS GENERATOR           ${NC}"
echo -e "${BLUE}=======================================${NC}"

# Έλεγχος αν δόθηκε όνομα φακέλου ως παράμετρος
if [ "$1" == "" ]; then
  echo -e "${YELLOW}Δεν δόθηκε όνομα φακέλου. Χρησιμοποιείται το προεπιλεγμένο 'aion-cms'${NC}"
  FOLDER_NAME="aion-cms"
else
  FOLDER_NAME="$1"
fi

# Δημιουργία βασικού φακέλου
echo -e "${GREEN}Δημιουργία βασικού φακέλου: ${FOLDER_NAME}${NC}"
mkdir -p "$FOLDER_NAME"
cd "$FOLDER_NAME"

# Εκτέλεση των επιμέρους scripts
echo -e "${GREEN}Εκτέλεση των scripts εγκατάστασης...${NC}"

# Κάνουμε executable όλα τα script αρχεία
chmod +x ./02_setup_npm.sh
chmod +x ./03_setup_config.sh
chmod +x ./04_setup_nextjs.sh
chmod +x ./05_setup_components.sh
chmod +x ./06_setup_admin.sh
chmod +x ./07_setup_pages.sh

# Εκτέλεση scripts
./02_setup_npm.sh
./03_setup_config.sh
./04_setup_nextjs.sh
./05_setup_components.sh
./06_setup_admin.sh
./07_setup_pages.sh

echo -e "${GREEN}Η εγκατάσταση του AION CMS ολοκληρώθηκε επιτυχώς!${NC}"
echo -e "Μπορείτε να ξεκινήσετε την εφαρμογή με την εντολή: cd ${FOLDER_NAME} && npm run dev"