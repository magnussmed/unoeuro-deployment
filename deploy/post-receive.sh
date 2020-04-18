#!/bin/bash
TARGET="/var/www/SIMPLY_SITE_DOMAIN/public_html"
ROOT="/var/www/SIMPLY_SITE_DOMAIN"
GIT_DIR="/var/www/SIMPLY_SITE_DOMAIN/repo/YOUR_REPO_NAME.git"
BRANCH="master"

while read oldrev newrev ref
do
	# Only checking out the master
	if [ "$ref" = "refs/heads/$BRANCH" ];
	then
		echo "Ref $ref received. Deploying ${BRANCH} branch to production..."
		git --work-tree=$TARGET --git-dir=$GIT_DIR checkout -f $BRANCH
		chmod +rx $TARGET/deploy/deploy-setup.sh
		cd $TARGET/deploy
		./deploy-setup.sh
	else
		echo "Ref $ref received. Doing nothing: only the ${BRANCH} branch may be deployed on this server."
	fi
done