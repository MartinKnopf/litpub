#!/bin/bash

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