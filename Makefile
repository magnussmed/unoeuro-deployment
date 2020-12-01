REPO              = $(shell basename -s .git `git config --get remote.origin.url`)
PROD_HOST         = example-host.com
PROD_DOMAIN       = examle.com
SSH_IDENTITY_PATH = /Path/To/Identity/File

ssh-connect:
	ssh -i $(SSH_IDENTITY_PATH) $(PROD_DOMAIN)@$(PROD_HOST)

setup-deploy:
	sed -i -e 's/SIMPLY_SITE_DOMAIN/'$(PROD_DOMAIN)'/g' deploy/post-receive.sh
	sed -i -e 's/YOUR_REPO_NAME/'$(REPO)'/g' deploy/post-receive.sh
	rm -rf deploy/post-receive.sh-e
	ssh-add $(SSH_IDENTITY_PATH)
	scp ./deploy/post-receive.sh $(PROD_DOMAIN)@$(PROD_HOST):/var/www/$(PROD_DOMAIN)
	ssh $(PROD_DOMAIN)@$(PROD_HOST) \
	"mkdir repo; cd repo; git init --bare "$(REPO)".git; mv ../post-receive.sh "$(REPO)".git/hooks/post-receive; chmod +x "$(REPO)".git/hooks/post-receive"
	rm -rf post-receive; rm -rf post-receive.sh
	git remote add production ssh://$(PROD_DOMAIN)@$(PROD_HOST)/var/www/$(PROD_DOMAIN)/repo/$(REPO).git
	@echo "\033[0;32mDeployment successfully configured!\033[0m"
	@echo "\033[0;32mCall make deploy-prod to deploy the master branch to production servers. Remember to push a commit first!\033[0m"

deploy-prod:
	@echo "\033[0;32mDeploying master branch to production: "$(PROD_DOMAIN)"\033[0m"
	git push production master
	@echo "\033[0;32mSuccessfully deployed to production: "$(PROD_DOMAIN)"\033[0m"
