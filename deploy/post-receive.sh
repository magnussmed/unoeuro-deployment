#!/bin/bash
TARGET_PROD="/var/www/SIMPLY_SITE_DOMAIN/public_html"
TARGET_STAGE="/var/www/SIMPLY_SITE_DOMAIN/staging"
ROOT="/var/www/SIMPLY_SITE_DOMAIN"
GIT_DIR="/var/www/SIMPLY_SITE_DOMAIN/repo/YOUR_REPO_NAME.git"

while read oldrev newrev ref
do

	BRANCH=`echo $ref | cut -d/ -f3`

	# Deploy to production servers (only master branch allowed)
	if [ "master" == "$BRANCH" ];
	then
		echo "Ref $ref received. Deploying ${BRANCH} branch to production..."
		git --work-tree=$TARGET_PROD --git-dir=$GIT_DIR checkout -f $BRANCH
		chmod +rx $TARGET_PROD/deploy/deploy-setup.sh
		cd $TARGET_PROD
		sed -i -e '$aSetEnv PHP_ENV production' .htaccess
		cd deploy
		./deploy-setup.sh
	else
		# Deploy to stage...
		echo "Ref $ref received. Deploying ${BRANCH} to stage..."
		git --work-tree=$TARGET_STAGE --git-dir=$GIT_DIR checkout -f $BRANCH
		chmod +rx $TARGET_STAGE/deploy/deploy-setup.sh
		cd $TARGET_STAGE
		sed -i -e '$aSetEnv PHP_ENV staging' .htaccess
		cd deploy
		./deploy-setup.sh
	fi
done
