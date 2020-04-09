# Simply.com (UnoEuro) Site Deployment
Deploy your site to Simply (UnoEuro) using git

## Setup and usage
First of all, you need to have access to the remote server using SSH.
<br><br>
Then let's begin...
<br><br>
Get in the right folder:
```bash
cd /var/www/SIMPLY_SITE_DOMAIN
```

Since Git is already installed, we don't need to worry about that.
<br>
Create a new "repo" directory and init a new empty git repository inside:
```bash
mkdir repo
cd repo
git init --bare YOUR_REPO_NAME
```
Move into the new repository and create a new git hook:
```bash
cd YOUR_REPO_NAME/hooks
vim post-receive
```
Paste in the content from the example "post-receive" file<br>
Replace SIMPLY_SITE_DOMAIN and YOUR_REPO_NAME<br>
and save it with ESC then :w then :qa to quit
<br>
<br>
Make it executable:
```bash
chmod +x post-receive
```
