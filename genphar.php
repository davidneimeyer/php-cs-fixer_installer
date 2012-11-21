<?php
$stub =<<<STUB
<?php
/** This was auto-built from source (https://github.com/fabpot/PHP-CS-Fixer) via Homebrew **/
Phar::mapPhar('php-cs-fixer.phar'); require 'phar://php-cs-fixer.phar/php-cs-fixer'; __HALT_COMPILER(); ?>";
STUB;
$phar = new Phar('php-cs-fixer.phar');
$phar->setAlias('php-cs-fixer.phar');
$phar->buildFromDirectory('src');
$phar->setStub($stub);
