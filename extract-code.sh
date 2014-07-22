#!/bin/bash

if [ $# -ne 3 ] ; then 
  echo "Usage: extract-code.sh <source directory> <destination directory> <file name extension>"
  echo ""
  echo "  source directory"
  echo "                     directory from where the documentation files should be copied"
  echo "  destination directory"
  echo "                     directory to where the documentation files should be copied"
  echo "  file name extension"
  echo "                     file name extension of the files to extract code from"
  echo ""
  echo "Example: extract-code ./book ./ .md"
  exit 1
fi

SOURCE_DIRECTORY="$1"
DESTINATION_DIRECTORY="$2"
FILE_NAME_PATTERN="$3"
FILE_PATH_SED="s:$SOURCE_DIRECTORY/\{0,1\}:$DESTINATION_DIRECTORY:"

function extractCode {
  FILE_NAME_SED="s:$FILE_NAME_PATTERN::"
  SOURCE_FILE_NAME=$(sed $FILE_NAME_SED <<< $1)

  SOURCE_FILE_NAME="$(sed $FILE_PATH_SED <<< $SOURCE_FILE_NAME)"

  grep '^    ' $1 | sed -e 's/^    //' > $SOURCE_FILE_NAME
}

for d in $(find $SOURCE_DIRECTORY -type d)
do
  DIRECTORY="$(sed $FILE_PATH_SED <<< $d)"

  if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
  fi
done

for f in $(find $SOURCE_DIRECTORY -name "*.*$FILE_NAME_PATTERN");
do
  extractCode $f
done