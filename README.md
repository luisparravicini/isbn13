# ISBN13

Validation and correct formatting of and ISBN13 number.

## Usage

  require 'isbn13'

  ISBN13.format('9789873303111') # => '978-987-33-0311-1'

  ISBN13.valid?('978-987-33-0311-1') # => true
  ISBN13.valid?('9789873303111') # => true


## Formatting

A formatted ISBN13 number consists is on the form: GS1-GROUP-PUBLISHER-ITEM_NUMBER-CHECKSUM. The problem is, only GS1 and CHECKSUM has fixed lengths. The other components lengths vary according to the ranges assigned by the international/national ISBN agencies.

So, how can an ISBN13 be properly hyphenated? I've found RangeMessage.xml at [http://www.isbn-international.org/page/ranges] containing a list of UCC / Groups prefixes which I've used initially for formatting, but later found some errors hyphenating some isbns from Uruguay.

Later I've found an [http://www.isbn-international.org/ia/isbncvt](ISBN10 to ISBN13 converter) which have all the ranges defined as arrays in Javascript. And that's the data I've used for hyphenate the isbns. There's a bin/make_isbn_ranges.rb which downloads/parses the page and creates a new data file to be used by the gem.


## Author

[Luis Parravicini](mailto:lparravi@gmail.com)

## Changelog

* 2012-01-27 - Initial release

## License

Copyright (c) 2012 Luis Parravicini

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
