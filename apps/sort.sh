#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

sizes=(128 256 512 1024)

for s in "${sizes[@]}"; do
    mkdir -p "${s}x${s}"
done

shopt -s nullglob nocaseglob
for f in *.png *.jpg *.jpeg *.webp *.svg; do
    read -r w h < <(identify -format "%w %h" "$f[0]" 2>/dev/null)

    if [[ -n "$w" && "$w" == "$h" && " ${sizes[*]} " == *" $w "* ]]; then
        mv -v -- "$f" "${w}x${h}/"
    else
        echo "Skipped $f (size: ${w:-unknown}x${h:-unknown})"
    fi
done
