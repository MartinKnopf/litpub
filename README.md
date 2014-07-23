litpub
======

Project seed for literate programming that supports:

* extraction of code from Markdown files on save
* running mocha tests against the extracted code
* replacing placeholders in Markdown files

## Installation

Clone this repository or download it as zip. Then ```npm install``` and start writing!

## Usage

You write your literate code in Markdown files with the file name pattern ```*.*.md``` (e.g. ```*.js.md```). All code blocks from those Markdown files will be extracted into new files without the ```.md``` extension. **Code blocks need to be indented by four spaces**.

There are only three grunt tasks:

### ```grunt```

Starts a watch process that extracts code from all Markdown files in ```./book``` to ```./``` and runs your mocha tests against the extracted code.

### ```grunt extract```

Extracts code from all Markdown files in ```./book``` to ```./```.

### ```grunt publish```

Copies all Markdown files from ```./book``` to ```./publish``` and replaces the placeholders defined in ```placeholders.json```.

## Example

Consider the following project structure:

```
million$Project/
  |-- book/
  |   |-- bin/
  |   |   |-- server-cli.js.md
  |   |-- conf/
  |   |   |-- conf.js.md
  |   |-- lib/
  |   |   |-- server.js.md
  |   |-- test/
  |   |   |-- server.test.js.md
  |-- extract-code.sh
  |-- Gruntfile.js
  |-- replacements.json
  |-- ...
```

The content of one of the Markdown documents could look like this:

  > book/lib/server.js.md

```
# This is the server of my __projectTitle__.

It does:
* this
* and this
* and this

But first it greet's the world:

    console.log('hello world!');
...
```

Start the code extraction process with ```grunt``` and whenever you save one of the Markdown documents in ```./book``` all of them will be processed. The resulting project structure would then look like this:

```
million$Project/
  |-- bin/
  |   |-- server-cli.js
  |-- book/
  |   |-- ...
  |-- conf/
  |   |-- conf.js
  |-- lib/
  |   |-- server.js
  |-- test/
  |   |-- server.test.js
  |-- extract-code.sh
  |-- Gruntfile.js
  |-- replacements.json
  |-- ...
```

All Markdown files from ```./book``` got copied into ```./```. The content of ```./lib/server.js``` would look like this:


  > lib/server.js

```
console.log('hello world!');
```

If you now want to publish the book, you can run ```grunt publish```. This will just copy ```./book``` into ```./publish``` and replace the placeholders in all Markdown files:

```
million$Project/
  |-- bin/
  |-- book/
  |-- conf/
  |-- lib/
  |-- publish/
  |   |-- bin/
  |   |   |-- server-cli.js.md
  |   |-- conf/
  |   |   |-- conf.js.md
  |   |-- lib/
  |   |   |-- server.js.md
  |   |-- test/
  |   |   |-- server.test.js.md
  |-- test/
  |   |-- server.test.js
  |-- extract-code.sh
  |-- Gruntfile.js
  |-- replacements.json
  |-- ...
```

Your replacements.json might look like this:

  > replacements.json

```
{
  "__projectTitle__": "Million$Project"
}
```

The resulting ```server.js.md``` would then look like this:

  > publish/lib/server.js.md

```
# This is the server of my Million$Project.

It does:
* this
* and this
* and this

But first it greet's the world:

    console.log('hello world!');
...
```