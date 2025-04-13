#!/bin/bash

echo "🚀 AION Merge Wizard ξεκινά..."

# Ορισμός μονοπατιών
src_paths=("aion-cms/components" "aion-cms/app" "aion-cms/lib" "aion-cms/types")
dst_paths=("src/components" "app" "lib" "types")

# Βρόχος για μεταφορά
for i in "${!src_paths[@]}"; do
  src="${src_paths[$i]}"
  dst="${dst_paths[$i]}"
  echo "📁 Merging from $src → $dst"
  
  find "$src" -type f | while read file; do
    rel_path="${file#$src/}"
    target="$dst/$rel_path"

    if [ -f "$target" ]; then
      ext="${target##*.}"
      base="${target%.*}"
      new="${base}_temp.${ext}"
      echo "⚠️  Conflict: $rel_path → saving as $new"
      mkdir -p "$(dirname "$new")"
      cp "$file" "$new"
    else
      mkdir -p "$(dirname "$target")"
      cp "$file" "$target"
      echo "✅ Copied: $rel_path"
    fi
  done
done

# Μετονομασία φακέλου
if [ -d "aion-cms" ]; then
  mv aion-cms aion-cms_backup
  echo "📦 Backup created: aion-cms → aion-cms_backup"
fi

# Προσθήκη στο .gitignore
if ! grep -q "aion-cms_backup" .gitignore 2>/dev/null; then
  echo "aion-cms_backup/" >> .gitignore
  echo "🛡️  Added aion-cms_backup to .gitignore"
fi

echo "🎉 AION Merge ολοκληρώθηκε με επιτυχία!"