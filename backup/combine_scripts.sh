#!/bin/bash

# Script για τη συνένωση όλων των επιμέρους script αρχείων σε ένα ενιαίο εκτελέσιμο

# Χρωματιστή έξοδος για καλύτερη αναγνωσιμότητα
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Εμφάνιση banner
echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}    AION CMS SCRIPT COMBINER         ${NC}"
echo -e "${BLUE}=======================================${NC}"

# Έλεγχος αν δόθηκε όνομα για το τελικό script
if [ "$1" == "" ]; then
  echo -e "${YELLOW}Δεν δόθηκε όνομα για το τελικό script. Χρησιμοποιείται το προεπιλεγμένο 'aion-cms-full.sh'${NC}"
  OUTPUT_SCRIPT="aion-cms-full.sh"
else
  OUTPUT_SCRIPT="$1"
fi

# Έλεγχος αν υπάρχουν τα απαραίτητα script αρχεία
SCRIPT_FILES=(
  "01_setup_main.sh"
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

MISSING_FILES=0
for file in "${SCRIPT_FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo -e "${RED}Λείπει το αρχείο: $file${NC}"
    MISSING_FILES=$((MISSING_FILES + 1))
  fi
done

if [ $MISSING_FILES -gt 0 ]; then
  echo -e "${RED}Λείπουν $MISSING_FILES αρχεία. Παρακαλώ βεβαιωθείτε ότι όλα τα απαραίτητα script αρχεία βρίσκονται στον τρέχοντα φάκελο.${NC}"
  exit 1
fi

# Δημιουργία του ενιαίου script
echo -e "${GREEN}Δημιουργία του ενιαίου script: $OUTPUT_SCRIPT${NC}"

# Αρχίζουμε με το header του script
cat > "$OUTPUT_SCRIPT" << 'EOL'
#!/bin/bash

# AION CMS - Full Installation Script
# Αυτό το script δημιουργήθηκε αυτόματα με το συνδυασμό επιμέρους script αρχείων

# Χρωματιστή έξοδος για καλύτερη αναγνωσιμότητα
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Εμφάνιση banner
echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}         AION CMS INSTALLER           ${NC}"
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

EOL

# Προσθήκη του περιεχομένου των επιμέρους script αρχείων
# Παραλείπουμε το 01_setup_main.sh αφού έχουμε ήδη προσθέσει το header του ενιαίου script
for file in "${SCRIPT_FILES[@]:1}"; do
  echo -e "${GREEN}Προσθήκη του περιεχομένου του $file${NC}"
  
  # Εξαγωγή του κύριου περιεχομένου του script (αφαιρούμε το shebang και τις δηλώσεις μεταβλητών χρώματος)
  # και προσθέτουμε διαχωριστικό για καλύτερη αναγνωσιμότητα
  echo -e "\n# -------- Περιεχόμενο από το $file --------\n" >> "$OUTPUT_SCRIPT"
  
  # Αφαιρούμε τις γραμμές με shebang και χρώματα
  sed -n '/^#!/d; /^GREEN=/d; /^BLUE=/d; /^YELLOW=/d; /^RED=/d; /^NC=/d; p' "$file" >> "$OUTPUT_SCRIPT"
done

# Προσθήκη του footer του script
cat >> "$OUTPUT_SCRIPT" << 'EOL'

# Ολοκλήρωση εγκατάστασης
echo -e "${GREEN}Η εγκατάσταση του AION CMS ολοκληρώθηκε επιτυχώς!${NC}"
echo -e "Μπορείτε να ξεκινήσετε την εφαρμογή με την εντολή: cd ${FOLDER_NAME} && npm run dev"
EOL

# Κάνουμε το script εκτελέσιμο
chmod +x "$OUTPUT_SCRIPT"

echo -e "${GREEN}Το ενιαίο script δημιουργήθηκε επιτυχώς: $OUTPUT_SCRIPT${NC}"
echo -e "Μπορείτε να το εκτελέσετε με την εντολή: ./$OUTPUT_SCRIPT [όνομα-φακέλου]"