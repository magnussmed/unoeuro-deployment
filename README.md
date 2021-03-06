# Simply.com (UnoEuro) Site Deployment
Deploy your site to Simply (UnoEuro) using Makefile with git

## Setup and usage
### Make sure you have access
First of all, you need to have access to the remote server using SSH.
<br>
If you don't have any SSH key set up yet, you can do that by running the following in your terminal:
```bash
ssh-keygen
```
Add your public SSH key to the server:
```bash
open -e /Path/to/publickey
```
Copy the opened key content and paste it in your simply.com administration panel.
<br><br>
Then let's begin...
<br><br>
### Configure the Makefile
If you don't have Make installed, you can do that by using Homebrew:
```bash
brew install make
```
Open the Makefile and take a look at the variables provided in the top.
<br>
You will need to change the three of them. REPO is automatically getting the current repository name that we're working in. So, we don't need to change that unless your .git folder isn't placed at the root as it should.
<br><br>
PROD_HOST is the remote host address<br>
PROD_DOMAIN is the production domain name<br>
SSH_IDENTITY_PATH is the absolute path to your SSH private key
<br><br>

### Run the commands
Once you have configured the above variables, you will now be able to run the make command:
```bash
make setup-deploy
```
You will be asked your SSH password once, and the remote password twice.
<br>
Once it is done, it should return a green response saying "Deployment successfully configured".
<br><br>
Now you are able to make the deploy command:
```bash
make app-deploy
```
You can apply e=prod to target production servers. This will deploy the origin master branch:
```bash
make app-deploy e=prod
```

<b>Remember</b> you will have to push some changes before you can run the deploy command.
