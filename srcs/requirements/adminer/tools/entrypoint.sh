#!/bin/sh

cd /usr/share/adminer/

chmod +x ./compile.php
./compile.php
mv adminer-*.php index.php

exec php -S 0.0.0.0:8000 -t /usr/share/adminer