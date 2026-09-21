#!/bin/sh

# This script will compile or run another finishing operation on a document. I
# have this script run via vim.

file="${1}"
ext="${file##*.}"
# dir=${file%/*}
base="${file%.*}"

case "${ext}" in
c) gcc -Wall -Wextra -o "${base}" "${file}" ;;
h) sudo make install ;;
md)
	css=""
	[ -f "$(dirname "${file}")/style.css" ] && css="--css=style.css"
	pandoc "${file}" -f markdown -t pdf $css --pdf-engine=weasyprint -o "${base}.pdf"
	;;
py) python "${file}" ;;
[rR]md) Rscript -e "rmarkdown::render('${file}', quiet=TRUE)" ;;
tex) latexmk ;;
typ) typst compile "${file}" ;;
*) sed -n '/^#!/s/^#!//p; q' "${file}" | xargs -r -I % "${file}" ;;
esac
