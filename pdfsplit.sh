#!/usr/bash

# note: assumes that the desetion ~PDF exist, and is where lpr
# will print out pdf files.
# required: sudo apt-get -y install cups-pdf
# todo: error when path has whitespace

usage="Usage: $(basename "$0") [-P pages] [PDF-sourcefile] [PDF-destfile]
	   where pages could be '1,3-5,16' note: based on lpr"

## Check arguments
if [ "$1" == "-h"  ]; then
  echo $usage
  exit 0
fi

if [ "$#" -lt 2 ]; then
  echo "Error. expected at least 2 arguments!"
  echo $usage
  exit 0
fi

## assign random integer
randint=$((1 + RANDOM % 10000))

lpr "$2" -P PDF -o page-ranges="$1" -C "$randint"

# wait till file has been created
until [ $(ls ~/PDF | grep "$randint" | wc -w) == 1  ]
do
     sleep 0.1
done

## ready paths
printfile=$(ls ~/PDF | grep "$randint")
fullfile=${2}
filename="${fullfile##*/}"
wd=$(pwd)

## move file
if [ "$#" == 2 ]; then
	mv ~/PDF/$printfile "$wd/splitted_$filename"
else
	mv ~/PDF/$printfile "$wd/${3}"
fi


