#!/bin/bash
# Check whether composer.phar exists or not
if [ -e ../composer.phar ]
then
	echo "Composer already installed!"
else
	echo "Installing composer..."
	cd .. && curl -s https://getcomposer.org/installer | php
fi
echo "Updating libaries from composer.json..."
cd .. && rm -rf composer.lock && php composer.phar install
