litpub
======

Project seed for literate programming that supports:

* extraction of code from Markdown files on save
* running mocha tests against the extracted code
* replacing placeholders in Markdown files

## Basics

You write your literate code in Markdown files with the file name pattern {{*.*.md}} (e.g. {{*.js*md}}. All code blocks from those Markdown files will be extracted into new files without the {{.md}} extension. *Code blocks need to be indented by four spaces*.

There are only three grunt tasks:

### {{grunt}}

Starts a watch process that extracts code from all Markdown files in {{./book}} to {{./}} and runs your mocha tests against the extracted code.

### {{grunt extract}}

Extracts code from all Markdown files in {{./book}} to {{./}}.

### {{grunt publish}}

Copies all Markdown files from {{./book}} to {{./publish}} and replaces the placeholders defined in {{placeholders.json}}.