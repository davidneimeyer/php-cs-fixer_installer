#!/bin/bash
# DESCRIPTION
# This will download the php-cs-fixer source, create a valid PHAR, and
# install it.
# This is a workaround the fact that the offical source doesn't not
# provide a means to valid it's sanity, as described
#  https://github.com/josegonzalez/homebrew-php/pull/377
#
# The utility of this script will be void once someond is kind enough to:
# A) re-work the logic into a Homebrew formula
# or
# B) The upstream provider packages a analogous script for the community
#
# The latter would be preferred as it would benefit more than just the
# Homebrew community
#
# The phar will be installed to /usr/local/bin/php-cs-fixer.phar with an
# executable the allows it to be called in a valid shell PATH with
# `php-cs-fixer`
#
# REQUIREMENTS:
# - wget
# - openssl
# - composer (getcomposer.org)
# - 'phar.readonly=1' in your php.ini
#
# LICENSE AND COPYRIGHT
# Copyright (c) David Neimeyer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

version='0.1.0'
sha1='3d25398022d97bf62663d0fe274104a94bca67ef'

###################
echo "# Preparing and Installing php-cs-fixer version $version"
echo "# "
if [ -e v0.1.0.tar.gz ]; then
    rm -rf v0.1.0.tar.gz
fi

if [ -d src ]; then
    rm -rf src
fi

###################
echo "# Fetching source..."
wget -q 'https://github.com/fabpot/PHP-CS-Fixer/archive/v0.1.0.tar.gz'

download_sha1=`openssl sha1 v0.1.0.tar.gz |awk '{print \$2}'`

if [ "$sha1" != "$download_sha1" ]; then
    echo "not ok 1 - Downloaded tar matches expected SHA1 checksum"
    echo "ok 2 - # skip php-cs-fixer.phar can execute properly"
    echo "Result: FAIL"
    exit 1
else
    echo "ok 1 - Downloaded tar matches expected SHA1 checksum"
fi

###################
echo "# Extracting source..."

tar -xf v0.1.0.tar.gz
mv PHP-CS-Fixer-0.1.0 src
cd src

###################
echo "# Adding/Updating dependencies with Composer..."
composer install 1>/dev/null

###################
echo "# Stripping unnecessary shebang from bootstrap in source"
sed -i '' '1d' php-cs-fixer
cd ..


###################
echo "# Building PHAR from composed source..."
if [ -e 'php-cs-fixer.phar' ]; then
    rm -f php-cs-fixer.phar
fi
php -f genphar.php

###################
echo "# Verifying PHAR..."
test_output=`php php-cs-fixer.phar -- --version`

expect_output='PHP CS Fixer version 0.2 by Fabien Potencier'

if [ "$test_output" != "$expect_output" ]; then
    echo ""
    echo "not ok 2 - php-cs-fixer.phar can execute properly"
    echo "Result: FAIL"
    exit 1;
else
    echo "ok 2 - php-cs-fixer.phar can execute properly"
fi

###################
echo "# Installing PHAR and executable"

target_dir='/usr/local/bin'

if [ -e $target_dir/php-cs-fixer ] || [ -e $target_dir/php-cs-fixer.phar ]; then
    rm -f $target_dir/php-cs-fixer*
fi

cp php-cs-fixer.phar $target_dir/

echo "/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off $target_dir/php-cs-fixer.phar \$*" >$target_dir/php-cs-fixer

chmod 0755 $target_dir/php-cs-fixer

echo "Result: PASS"
exit
