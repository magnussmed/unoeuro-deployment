#!/bin/bash
GIT_TOKEN=`cat ../../.gittoken`

### Check whether composer.phar exists or not
if [ -e ../composer.phar ]
then
	echo "Composer already installed!"
	echo "Updating libaries from composer.json..."
	cd .. && rm -rf composer.lock && php composer.phar install
else
	echo "Installing composer..."
	cd .. && curl -s https://getcomposer.org/installer | php -- --install-dir=./ --version=2.1.3
	php composer.phar config -g --unset github-oauth.api.github.com
	php composer.phar config -g github-oauth.github.com $GIT_TOKEN
	echo "Updating libaries from composer.json..."
	rm -rf composer.lock && php composer.phar update
fi
