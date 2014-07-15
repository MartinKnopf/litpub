#!/bin/bash

# This script extracts code blocks from Markdown files nd and saves them in a source code file.
# It also replaces 
# The given Markdown file has to be named *.*.md in order to write the extracted code to *.*.

function extractCode {
  SOURCE_FILE_NAME=$(sed -e 's/\.md//' <<< $1)
  grep '^    ' $1 | sed -e 's/^    //' > $SOURCE_FILE_NAME
}

function replacePlaceholders {
  sed -i "s/$1/$2/g" $3
}

# extract code
# ===================================
directories=( "./bin" "./lib" "./test" )
for i in "${directories[@]}"
do
  :
  for f in $(find $i -name "*.*.md");
  do
    extractCode $f
  done
done

# build book
# ===================================

# fresh and clean publish directory
MARKDOWN_FILE_PATTERN="*.md"
PUBLISH_DIR="./book"
rm -rf $PUBLISH_DIR
mkdir $PUBLISH_DIR

# copy Markdown files into publish dir
find ./     -type f -name "$MARKDOWN_FILE_PATTERN" -maxdepth 1 | xargs -i cp --parents {} $PUBLISH_DIR
find ./bin  -type f -name "$MARKDOWN_FILE_PATTERN"             | xargs -i cp --parents {} $PUBLISH_DIR
find ./lib  -type f -name "$MARKDOWN_FILE_PATTERN"             | xargs -i cp --parents {} $PUBLISH_DIR
find ./test -type f -name "$MARKDOWN_FILE_PATTERN"             | xargs -i cp --parents {} $PUBLISH_DIR