#!/bin/bash

usage="Usage: $(basename "$0") [quality] [PDF-sourcefile] [PDF-destfile]
where quality: [-s (72 DPI), -m (150 DPI), -l (300 DPI)]"

## check

if [ "$1" == "-h"  ]; then
  echo $usage
  exit 0
fi

if [ "$#" -ne 3 ]; then
  echo "Error. expected 3 arguments!"
  echo $usage
  exit 0
fi

input="$2"
output="$3"


if [ "$1" == "-s" ]; then
	compression="/screen" # 72 DPI
elif [ "$1" == "-m" ]; then
	compression="/ebook" # 150 DPI
elif [ "$1" == "-l" ]; then
	compression="/prepress" # 300 DPI
elif [ "$1" == "-p" ]; then
	compression="/printer" 
elif [ "$1" == "-d" ]; then
	compression="/default" 
else 
	echo "Invalid quality argument"
	echo $usage
	exit 0
fi

if ! [ -f "$input" ]; then
	echo "input file does not exist!"
	echo $usage
	exit 0
fi 


gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=$compression -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output $input









