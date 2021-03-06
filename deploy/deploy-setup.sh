#!/bin/bash
# Check whether composer.phar exists or not
if [ -e ../composer.phar ]
then
	echo "Composer already installed!"
	echo "Updating libaries from composer.json..."
	cd .. && rm -rf composer.lock && php composer.phar install
else
	echo "Installing composer..."
	cd .. && curl -s https://getcomposer.org/installer | php -- --install-dir=./ --version=1.9.0
	echo "Updating libaries from composer.json..."
	rm -rf composer.lock && php composer.phar update
fi
