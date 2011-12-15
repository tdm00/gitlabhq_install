# Installing GitLabHQ on Ubuntu Server 11.10 #

#### Download the latest server updates ####
<pre>
sudo apt-get update
sudo apt-get dist-upgrade -y
</pre>

#### Install VMWare Tools ####
<pre>
sudo apt-get install dkms build-essential gcc linux-headers-$(uname -r) -y
sudo mkdir -p /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cp /media/cdrom/VM* /tmp
sudo umount /media/cdrom
cd /tmp
tar -xzvf VMware*.gz
cd vmware-tools-distrib/
sudo ./vmware-install.pl -d
</pre>

#### Dedicated gitlabhq user account ####
Next we need to create a dedicated gitlabhq user account to run the application, set a password for this account and add it to the admin group so it can perform root actions.
<pre>
sudo useradd -s /bin/bash -m -G admin gitlabhq
sudo passwd gitlabhq
</pre>

Now login as the gitlabhq users we just created.  When prompted to accept the authenticity of the RSA key fingerprint type "yes"
<pre>
ssh gitlabhq@localhost
</pre>

#### Install Additional Packages ####
Now we'll install the git version control system so we can clone repositories and setup the system.  We'll also install the postfix SMTP system so GitLabHQ can send emails to users.
<pre>
sudo aptitude install git-core postfix -y
</pre>

Now configure Git with some global variables that will be used w hen gitlabhq performs a `git push` operation.  You can change the name and email address below if you wish:
<pre>
git config --global user.email "admin@local.host"
git config --global user.name "GitLabHQ Admin User"
</pre>

#### Generate SSH Keys ####
The GitLabHQ user will use SSH keys for login and authentication with the git user we'll create later.  So let's generate our keys.  Make sure to do the following:
When prompted for the file in which to save the file, press Enter
When prompted for a passphrase, press Enter
When prompted to confirm the passphrase again, press Enter
<pre>
ssh-keygen -t rsa
</pre>

#### Prepare To Install GitLabHQ ####
First let's clone the GitLabHQ installer scripts to help automate the installation
<pre>
cd ~
git clone https://github.com/gitlabhq/gitlabhq_install.git
</pre>

Now we'll run the scripts to install any additional packages.
Run the command below and select "Y" to confirm you want to install the packages.
<pre>
cd ~ 
gitlabhq_install/ubuntu_packages.sh
</pre>

Now we'll run the script to install the ruby language.
<pre>
cd ~ 
gitlabhq_install/ubuntu_ruby.sh
</pre>

Now we'll run the script to install the gitolite program.
This creates a new user "git" on the system, and will store our repositories under this accounts home directory.
<pre>
cd ~ 
gitlabhq_install/ubuntu_gitolite.sh
</pre>
When you run this script it will stop at some point with a warning about the path, just press the "Enter" key to continue.
On the next screen is the gitolite configuration screen.  Here we need to make one change that's very important.
Find the line that reads:
<pre>
REPO_UMASK = 0077;
</pre>
Move over the first "7" character, press the "i" key on your keyboard to go into INSERT mode.  Type a "0", then remove the "7" so it now reads:
<pre>
REPO_UMASK = 0007;
</pre>
Press the Escape key once, then type the ":" to enter COMMAND mode.  Now type "wq" which will Write the changes to the file and Quit.

You now need to change the directory privileges on the /repositories directory so GitLabHQ can use them:
<pre>
sudo chmod -R 770 /home/git/repositories/
sudo chown -R git:git /home/git/repositories/
</pre>

Next we need to logout of the system to allow environment settings to be set upon the next time we login.
<pre>
logout
</pre>

#### Install GitLabHQ ####
Log back into the system so the environment settings take place
<pre>
ssh gitlabhq@localhost
</pre>

Now we'll install GitLabHQ, again using one of the install scripts.  When prompted about installing additional packages, type "Y"
<pre>
cd ~ 
gitlabhq_install/ubuntu_gitlab.sh
</pre>

#### Configure GitLabHQ ####
You can configure GitLabHQ by editing the `gitlab.yml` file.  One of the changes you'll want to make is to set your computer name that GitLabHQ is running on, if not localhost, so the instructions to users for connecting to repositories is correct.
<pre>
nano /home/gitlabhq/gitlabhq/gitlab.yml
</pre>

Change the host value to whatever your servers fully qualified domain name (FQDN) is.  So for example if I'm running GitLabHQ on a server named "gitlabhq.corp.com" I'd change the value:
<pre>
# Git Hosting congiguration
git_host:
  system: gitolite
  admin_uri: git@localhost:gitolite-admin
  base_path: /home/git/repositories/
  host: localhost
  git_user: git
  # port: 22
</pre>
to
<pre>
# Git Hosting congiguration
git_host:
  system: gitolite
  admin_uri: git@localhost:gitolite-admin
  base_path: /home/git/repositories/
  host: gitlabhq.corp.com
  git_user: git
  # port: 22
</pre>



#### Running GitLabHQ ####
Now that we have GitLabHQ installed, let's start the application using WEBrick (even if you'll use something else later) so we can login and accept an RSA key, then confirm it works.
<pre>
cd /home/gitlabhq/gitlabhq
bundle exec rails s -e production
</pre>

Now you can login to your server by pointing your web browser to http://<server_name>:3000/ and login using the default credentials

* Login Email:    admin@local.host
* Login Password: 5iveL!fe

#### Important! ####
You should now create a new **PROJECT**.  It's important to note that when you add this project the *FIRST TIME* you need to type "yes" on the console where you started the application running.