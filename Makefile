REPO              = $(shell basename -s .git `git config --get remote.origin.url`)
CUR_BRANCH        = $(shell git rev-parse --abbrev-ref HEAD)
PROD_HOST         = example-host.com
PROD_DOMAIN       = examle.com
SSH_IDENTITY_PATH = /Path/To/Identity/File
GIT_TOKEN_PATH    = /Path/To/GitToken/File

ssh-connect:
	ssh -i $(SSH_IDENTITY_PATH) $(PROD_DOMAIN)@$(PROD_HOST)

setup-deploy:
	sed -i -e 's/SIMPLY_SITE_DOMAIN/'$(PROD_DOMAIN)'/g' deploy/post-receive.sh
	sed -i -e 's/YOUR_REPO_NAME/'$(REPO)'/g' deploy/post-receive.sh
	rm -rf deploy/post-receive.sh-e
	ssh-add $(SSH_IDENTITY_PATH)
	scp ./deploy/post-receive.sh $(PROD_USER)@$(PROD_HOST):/var/www/$(PROD_DOMAIN)
	ssh $(PROD_USER)@$(PROD_HOST) \
	"mkdir repo; cd repo; git init --bare "$(REPO)".git; mv ../post-receive.sh "$(REPO)".git/hooks/post-receive; chmod +x "$(REPO)".git/hooks/post-receive"
	rm -rf post-receive; rm -rf post-receive.sh
	git remote add production ssh://$(PROD_USER)@$(PROD_HOST)/var/www/$(PROD_DOMAIN)/repo/$(REPO).git
	git remote add stage ssh://$(PROD_USER)@$(PROD_HOST)/var/www/$(PROD_DOMAIN)/repo/$(REPO).git
	sed -i -e 's/<REMOTE_DB_USER>/'$(PROD_MYSQL_USER)'/g' public/wp-config.php
	sed -i -e 's/<REMOTE_DB_PASS>/'$(PROD_MYSQL_PASS)'/g' public/wp-config.php
	sed -i -e 's/<REMOTE_DB_HOST>/'$(PROD_MYSQL_HOST)'/g' public/wp-config.php
	sed -i -e 's/<REMOTE_TABLE_PREFIX>/'$(PROD_TABLE_PREFIX)'/g' public/wp-config.php
	sed -i -e 's/<PROD_DOMAIN>/'$(PROD_DOMAIN)'/g' public/wp-config.php
	sed -i -e 's/<REMOTE_DB_NAME>/'$(PROD_MYSQL_DB)'/g' public/wp-config.php
	rm -rf public/wp-config.php-e
	scp $(GIT_TOKEN_PATH) $(PROD_USER)@$(PROD_HOST):/var/www/$(PROD_DOMAIN)
	@echo "\033[0;32mDeployment successfully configured!\033[0m"
	@echo "\033[0;32mCall 'make app-deploy e=prod' to deploy the master branch to production servers.\033[0m"

app-deploy:
	@echo "\033[0;32mStarting deployment trigger\033[0m"
	git commit --allow-empty -m "Trigger deploy"
	git push

ifeq ($(e), prod)
	@echo "\033[0;32mDeploying master branch to production: "$(PROD_DOMAIN)"\033[0m"
	git push production master
	@echo "\033[0;32mSuccessfully deployed to production: "$(PROD_DOMAIN)"\033[0m"
else
	@echo "\033[0;32mDeploying current branch ($(CUR_BRANCH)) to stage: stage."$(PROD_DOMAIN)"\033[0m"
	git push stage $(CUR_BRANCH)
	@echo "\033[0;32mSuccessfully deployed ($(CUR_BRANCH)) to stage: stage."$(PROD_DOMAIN)"\033[0m"
endif
