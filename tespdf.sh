#!/bin/bash
#set +x
for pdf_file in ./*.pdf; do
    rm $(basename $pdf_file .pdf);
    echo $(basename "$pdf_file" .pdf)_%d.tif;
    eval "gs -dNOPAUSE -dBATCH -sDEVICE=tiffg4 -sOutputFile=$(basename "$pdf_file" .pdf)_%03d.tif $pdf_file";

    for tif_file in ./$(basename $pdf_file .pdf)_*.tif; do
        echo "$tif_file $(basename "$tif_file" .tif)";
        tesseract "$tif_file" $(basename "$tif_file" .tif);
        cat $(basename "$pdf_file" .pdf)*.txt > "$(basename "$pdf_file" .pdf)";
    done
    rm $(basename $pdf_file .pdf)_*.txt
    rm $(basename $pdf_file .pdf)_*.tif
done

