# Unoeuro site deployment
Deploy your site to Simply (UnoEuro) using git

## Setup and usage
First of all, you need to have access to the remote server using SSH.
<br><br>
Then let's begin...
<br><br>
Get in the right folder:
```bash
/var/www/SIMPLY_SITE_DOMAIN
```

Since Git is already installed, we don't need to worry about that.
<br>
Create a new "repo" directory, CD into it and init a new empty git repository:
```bash
mkdir repo
cd repo
git init --bare YOUR_REPO_NAME
```

```bash
curl -s https://getcomposer.org/installer | php
```

Then you can install all required runtime dependencies

```bash
php composer.phar install
```

We're using Webpack for asset management. Go to falcon/assets and run following commands:
```bash
npm install
npm run start
```
