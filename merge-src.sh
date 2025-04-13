#!/bin/bash

echo "🚀 AION Backup Merge ξεκινάει από aion-cms_backup/... προς το κανονικό project"

src_paths=("aion-cms_backup/components" "aion-cms_backup/app" "aion-cms_backup/lib" "aion-cms_backup/types")
dst_paths=("src/components" "app" "lib" "types")

for i in "${!src_paths[@]}"; do
  src="${src_paths[$i]}"
  dst="${dst_paths[$i]}"
  echo "📁 Merging $src → $dst"

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

echo "🎉 AION CMS Backup Merge ολοκληρώθηκε!"