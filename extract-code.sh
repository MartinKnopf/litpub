#!/bin/bash

DESTINATION_DIRECTORY="$1"

function extractCode {
  SOURCE_FILE_NAME=$(sed -e 's/\.md//' <<< $1)
  SOURCE_FILE_NAME=$(sed -e "s/\/book/$2/" <<< $SOURCE_FILE_NAME)

  grep '^    ' $1 | sed -e 's/^    //' > $SOURCE_FILE_NAME
}

for d in $(find ./book -type d)
do
  DIRECTORY=$(sed -e "s/\/book/$DESTINATION_DIRECTORY/" <<< $d)
  echo "------ $DIRECTORY"
  if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
  fi
done

for f in $(find ./book -name "*.*.md");
do
  extractCode $f $DESTINATION_DIRECTORY
done