# USAGE
```bash
install.sh
```

# DESCRIPTION

This will download the php-cs-fixer source, create a valid PHAR, and
install it.
This is a workaround the fact that the offical source does not
provide a means to validate its sanity, as described in a Homebrew
[update request] (https://github.com/josegonzalez/homebrew-php/pull/377)

The utility of this script will be void once someond is kind enough to
do one of the following:

* Re-work the logic into a Homebrew formula
* The upstream provider publishes  a analogous script for the community

The latter would be preferred as it would benefit more than just the
Homebrew community

The phar will be installed to /usr/local/bin/php-cs-fixer.phar with an
executable that allows it to be called in a valid shell PATH with
`php-cs-fixer`

# REQUIREMENTS:

* wget
* openssl
* [composer](http://getcomposer.org)
* 'phar.readonly=1' in your php.ini

# LICENSE AND COPYRIGHT

Copyright (c) David Neimeyer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
