#!/bin/bash

SOURCE_DIRECTORY="$1"
DESTINATION_DIRECTORY="$2"

function extractCode {
  SOURCE_FILE_NAME=$(sed -e 's/\.md//' <<< $1)
  SED="s/\/book/$2/"
  SOURCE_FILE_NAME="$(sed -e $SED <<< $SOURCE_FILE_NAME)"

  grep '^    ' $1 | sed -e 's/^    //' > $SOURCE_FILE_NAME
}

for d in $(find $SOURCE_DIRECTORY -type d)
do
  SED="s/\/book/$DESTINATION_DIRECTORY/"
  DIRECTORY="$(sed -e $SED <<< $d)"
  if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
  fi
done

for f in $(find $SOURCE_DIRECTORY -name "*.*.md");
do
  extractCode $f $DESTINATION_DIRECTORY
done