# asar-cli

**CLI utility to read/write electron asar archives.** (Npm module for node.js.)

[![npm version][badgeNpm]][linkNpm] ![license][badgeLicense] ![npm total downloads][badgeDownloads] [![dependencies][badgedDependencies]][linkDependencies] [![code coverage][badgeCoverage]][linkCoverage] [![build status][badgeBuild]][linkBuild]

## Table of Contents
- [Alternatives](#alternatives)
- [Motivation](#motivation)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Alternatives
- [asar-archive]: asar api (used by this)
- [grunt-asar]: grunt task
- [gulp-asar]: gulp task
- ([asar]: official command line interface and lib)

## Motivation
...

## Installation
Install (preferrably global) with `npm install asar-cli -g`.

## Usage
```
asar-cli [input] [output] [options]
Parameter:
input                 path to archive or directory
output                path to archive or directory
or if you prefer, you can set these with:
-i, --in <path>       specify input (can be archive or directory)
-o, --out <path>      specify output (can be archive or directory)
Options:
-h, --help            show help and exit
-v, --version         show version and exit
    --examples        show example usage and exit
    --verify          verify archive integrity and exit
    --info            output archive info and exit
-l, --list            list archive entries and exit
-s, --size            also list size
-a, --add <path>      path to directory to add to archive
-r, --root <path>     set root path in archive
-p, --pattern <glob>  set a filter pattern
    --stdout          print archive or file from archive to stdout
-w, --overwrite       overwrite files
-z, --compress        gzip file contents
-P, --pretty          write pretty printed json TOC
-c, --colors          use terminal colors for output
-C, --compat          also read legacy asar format
-Q, --verbose         more feedback
    --debug           a lot feedback
-q, --quiet           no feedback
```

## Examples

```
#create archive from dir
asar-cli dir archive

#same with named parameters
asar-cli -i dir -o archive

#extract archive to dir
asar-cli archive dir

#extract root from archive to dir
asar-cli archive dir -r root

#extract d/file from archive to dir
asar-cli archive dir -r d/file

#verify archive
asar-cli archive --verify

#list archive entries
asar-cli archive -l

#list archive entries for root
asar-cli archive -l -r root

#list entries for root with pattern
asar-cli archive -l -r root -p pattern

#list archive entries with size
asar-cli archive -ls

#print content of file to stdout
asar-cli archive -r d/file --stdout
```

## Contributing
- In lieu of a formal styleguide, take care to maintain the existing coding style.
- The source code is written in CoffeeScript and is in `src/`. Run `npm run build` to compile to JavaScript in `lib/`.
- Add unit tests for any new or changed functionality and fixed issues.
- Test your code using `npm test`.

## License
The MIT License (MIT)

Copyright (c) 2016 Benjamin Winkler ([bwin])

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



[badgeNpm]: https://img.shields.io/npm/v/asar-cli/master.svg?style=flat-square
[badgeLicense]: https://img.shields.io/npm/l/asar-cli.svg?style=flat-square
[badgeDownloads]: https://img.shields.io/npm/dt/asar-cli.svg?style=flat-square
[badgedDependencies]: https://img.shields.io/david/bwin/asar-cli/master.svg?style=flat-square
[badgeCoverage]: https://img.shields.io/coveralls/bwin/asar-cli/master.svg?style=flat-square
[badgeBuild]: https://img.shields.io/travis/bwin/asar-cli/master.svg?style=flat-square
[linkNpm]: https://npmjs.org/package/asar-cli/master
[linkDependencies]: https://david-dm.org/bwin/asar-cli/master
[linkCoverage]: https://coveralls.io/bwin/asar-cli/master
[linkBuild]: https://travis-ci.org/bwin/asar-cli/master

[bwin]: https://github.com/bwin
[asar-archive]: https://github.com/bwin/asar-archive
[grunt-asar]: https://github.com/bwin/grunt-asar
[gulp-asar]: https://github.com/bwin/gulp-asar
[asar]: https://github.com/atom/asar
[Module asar]: https://githubusercontent.com/bwin/asar-cli/master/docs/api/Asar.html
[Class AsarArchive]: https://githubusercontent.com/bwin/asar-cli/master/docs/api/AsarArchive.html
[Asar file format]: https://htmlpreview.github.io/?https://raw.githubusercontent.com/bwin/asar-cli/master/docs/asar-format.html
