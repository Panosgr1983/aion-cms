#!/bin/bash

# Script για τη διόρθωση των διαδρομών mkdir με παρενθέσεις
# Αντικαθιστά τις παρενθέσεις στις εντολές mkdir για να αποφευχθούν σφάλματα σύνταξης

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Όνομα του τελικού script
INPUT_SCRIPT="aion-cms-full.sh"
FIXED_SCRIPT="aion-cms-fixed.sh"

echo -e "${BLUE}Διόρθωση των διαδρομών mkdir στο script: ${INPUT_SCRIPT}${NC}"

# Έλεγχος αν υπάρχει το αρχείο εισόδου
if [ ! -f "$INPUT_SCRIPT" ]; then
  echo -e "${RED}Το αρχείο $INPUT_SCRIPT δεν βρέθηκε!${NC}"
  exit 1
fi

# Αντιγραφή του αρχείου εισόδου στο αρχείο εξόδου
cp "$INPUT_SCRIPT" "$FIXED_SCRIPT"

# Αντικατάσταση των προβληματικών εντολών mkdir
echo -e "${GREEN}Αντικατάσταση των προβληματικών εντολών mkdir...${NC}"

# Αντικατάσταση του app/(admin) με app/admin
sed -i '' 's/mkdir -p app\/(admin)/mkdir -p app\/admin/g' "$FIXED_SCRIPT"

# Αντικατάσταση οποιασδήποτε άλλης εντολής με παρενθέσεις
sed -i '' 's/mkdir -p \([^(]*\)(\([^)]*\))/mkdir -p \1\2/g' "$FIXED_SCRIPT"

# Ενημέρωση των διαδρομών που έχουν αλλάξει στο υπόλοιπο script
echo -e "${GREEN}Ενημέρωση των διαδρομών που έχουν αλλάξει στο υπόλοιπο script...${NC}"
sed -i '' 's/app\/(admin)/app\/admin/g' "$FIXED_SCRIPT"

# Κάνουμε το νέο script εκτελέσιμο
chmod +x "$FIXED_SCRIPT"

echo -e "${GREEN}Δημιουργήθηκε διορθωμένο script: ${FIXED_SCRIPT}${NC}"
echo -e "Μπορείτε να το εκτελέσετε με την εντολή: ./${FIXED_SCRIPT} [όνομα-φακέλου]"