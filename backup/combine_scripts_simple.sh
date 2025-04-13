#!/bin/bash

# Απλό script για τη συνένωση όλων των επιμέρους script αρχείων σε ένα ενιαίο εκτελέσιμο

# Χρωματιστή έξοδος
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Όνομα του τελικού script
OUTPUT_SCRIPT="aion-cms-full.sh"

echo -e "${BLUE}Δημιουργία ενιαίου script: ${OUTPUT_SCRIPT}${NC}"

# Δημιουργία του αρχείου και προσθήκη του shebang
echo "#!/bin/bash" > "$OUTPUT_SCRIPT"
echo "" >> "$OUTPUT_SCRIPT"
echo "# AION CMS - Πλήρες script εγκατάστασης" >> "$OUTPUT_SCRIPT"
echo "# Δημιουργήθηκε αυτόματα από τα επιμέρους script αρχεία" >> "$OUTPUT_SCRIPT"
echo "" >> "$OUTPUT_SCRIPT"

# Προσθήκη των κωδικών χρώματος
echo "# Χρωματιστή έξοδος" >> "$OUTPUT_SCRIPT"
echo "GREEN='\033[0;32m'" >> "$OUTPUT_SCRIPT"
echo "BLUE='\033[0;34m'" >> "$OUTPUT_SCRIPT"
echo "YELLOW='\033[1;33m'" >> "$OUTPUT_SCRIPT"
echo "RED='\033[0;31m'" >> "$OUTPUT_SCRIPT"
echo "NC='\033[0m' # No Color" >> "$OUTPUT_SCRIPT"
echo "" >> "$OUTPUT_SCRIPT"

# Προσθήκη του κύριου μέρους του 01_setup_main.sh
echo "# Εμφάνιση banner" >> "$OUTPUT_SCRIPT"
echo "echo -e \"\${BLUE}=======================================${NC}\"" >> "$OUTPUT_SCRIPT"
echo "echo -e \"\${BLUE}         AION CMS INSTALLER           ${NC}\"" >> "$OUTPUT_SCRIPT"
echo "echo -e \"\${BLUE}=======================================${NC}\"" >> "$OUTPUT_SCRIPT"
echo "" >> "$OUTPUT_SCRIPT"

echo "# Έλεγχος αν δόθηκε όνομα φακέλου ως παράμετρος" >> "$OUTPUT_SCRIPT"
echo "if [ \"\$1\" == \"\" ]; then" >> "$OUTPUT_SCRIPT"
echo "  echo -e \"\${YELLOW}Δεν δόθηκε όνομα φακέλου. Χρησιμοποιείται το προεπιλεγμένο 'aion-cms'${NC}\"" >> "$OUTPUT_SCRIPT"
echo "  FOLDER_NAME=\"aion-cms\"" >> "$OUTPUT_SCRIPT"
echo "else" >> "$OUTPUT_SCRIPT"
echo "  FOLDER_NAME=\"\$1\"" >> "$OUTPUT_SCRIPT"
echo "fi" >> "$OUTPUT_SCRIPT"
echo "" >> "$OUTPUT_SCRIPT"

echo "# Δημιουργία βασικού φακέλου" >> "$OUTPUT_SCRIPT"
echo "echo -e \"\${GREEN}Δημιουργία βασικού φακέλου: \${FOLDER_NAME}${NC}\"" >> "$OUTPUT_SCRIPT"
echo "mkdir -p \"\$FOLDER_NAME\"" >> "$OUTPUT_SCRIPT"
echo "cd \"\$FOLDER_NAME\"" >> "$OUTPUT_SCRIPT"
echo "" >> "$OUTPUT_SCRIPT"

# Προσθήκη των υπόλοιπων script αρχείων
FILES=(
  "02_setup_npm.sh"
  "03_setup_config.sh"
  "04_setup_nextjs.sh"
  "05_setup_components.sh"
  "06_setup_admin.sh"
  "07_setup_pages.sh"
  "08_setup_media_page.sh"
  "09_setup_cloudinary.sh"
  "10_setup_api.sh"
  "11_setup_utils.sh"
  "12_create_readme.sh"
)

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo -e "${GREEN}Προσθήκη περιεχομένου από το ${file}${NC}"
    echo "" >> "$OUTPUT_SCRIPT"
    echo "# ----- Περιεχόμενο από $file -----" >> "$OUTPUT_SCRIPT"
    echo "" >> "$OUTPUT_SCRIPT"
    
    # Αφαιρούμε το shebang και τις μεταβλητές χρώματος και προσθέτουμε το υπόλοιπο περιεχόμενο
    grep -v "^#\!/bin/bash" "$file" | grep -v "^GREEN=" | grep -v "^BLUE=" | grep -v "^YELLOW=" | grep -v "^RED=" | grep -v "^NC=" >> "$OUTPUT_SCRIPT"
  else
    echo -e "${RED}Το αρχείο $file δεν βρέθηκε! Παραλείπεται.${NC}"
  fi
done

# Προσθήκη του τέλους του script
echo "" >> "$OUTPUT_SCRIPT"
echo "# Ολοκλήρωση εγκατάστασης" >> "$OUTPUT_SCRIPT"
echo "echo -e \"\${GREEN}Η εγκατάσταση του AION CMS ολοκληρώθηκε επιτυχώς!${NC}\"" >> "$OUTPUT_SCRIPT"
echo "echo -e \"Μπορείτε να ξεκινήσετε την εφαρμογή με την εντολή: cd \${FOLDER_NAME} && npm run dev\"" >> "$OUTPUT_SCRIPT"

# Κάνουμε το script εκτελέσιμο
chmod +x "$OUTPUT_SCRIPT"

echo -e "${GREEN}Το ενιαίο script δημιουργήθηκε επιτυχώς: ${OUTPUT_SCRIPT}${NC}"
echo -e "Μπορείτε να το εκτελέσετε με την εντολή: ./${OUTPUT_SCRIPT} [όνομα-φακέλου]"