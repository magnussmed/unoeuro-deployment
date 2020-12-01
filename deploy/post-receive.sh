#!/bin/bash
TARGET="/var/www/websider.dk/public_html"
ROOT="/var/www/websider.dk"
GIT_DIR="/var/www/websider.dk/repo/unoeuro-deployment.git"
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
