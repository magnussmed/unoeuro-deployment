# Simply.com (UnoEuro) Site Deployment
Deploy your site to Simply (UnoEuro) using git

## Setup and usage
### Make sure you have access
First of all, you need to have access to the remote server using SSH.
<br><br>
Then let's begin...
<br><br>
Get in the right folder on the remote server:
```bash
cd /var/www/SIMPLY_SITE_DOMAIN
```

### Create the remote repository
Since Git is already installed, we don't need to worry about that.
<br>
Create a new "repo" directory and init a new empty git repository inside:
```bash
mkdir repo
cd repo
git init --bare YOUR_REPO_NAME.git
```

### Create a new git hook
Move into the new repository and create a new git hook:
```bash
cd YOUR_REPO_NAME/hooks
vim post-receive
```
Paste in the content from the example "post-receive" file<br>
Replace SIMPLY_SITE_DOMAIN and YOUR_REPO_NAME in the file<br>
and save it using ESC then :w then :qa to quit
<br>
<br>
Make it executable:
```bash
chmod +x post-receive
```
### Setup the local stuff
First, move into your local working git repository<br>
Then we have to add the just generated remote repository to your local:
```bash
git remote add production ssh://SIMPLY_SITE_DOMAIN@SIMPLY_SITE_HOST/var/www/SIMPLY_SITE_DOMAIN/repo/YOUR_REPO_NAME.git
```
You can check if it was a success by running "git remote"
<br>
Note: the 'production' parameter could be anything you prefer. It could also be called 'staging', 'live' etc.
<br><br>
You will have to run since it's required for authentication:
```bash
ssh-add PATH_TO_YOUR_IDENTITY_FILE
```
Make sure it's the same identity file you got access to the server with
<br><br>
Finally, you can deploy the master branch to the remote server:
```bash
git push production master
```
That's it! Your changes should now appear on the server.
