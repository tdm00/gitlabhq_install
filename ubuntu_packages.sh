# install all packages needed
# easier to maintain the list if separated out as
# a list instead of one long command
sudo apt-get install -y build-essential 
sudo apt-get install -y checkinstall 
sudo apt-get install -y curl 
sudo apt-get install -y gcc 
sudo apt-get install -y git-core
sudo apt-get install -y install
sudo apt-get install -y libc6-dev 
sudo apt-get install -y libcurl4-openssl-dev 
sudo apt-get install -y libicu-dev 
sudo apt-get install -y libmysql++-dev 
sudo apt-get install -y libpcre3-dev
sudo apt-get install -y libsqlite3-dev 
sudo apt-get install -y libssl-dev 
sudo apt-get install -y libxml2-dev 
sudo apt-get install -y libxslt-dev 
sudo apt-get install -y make 
sudo apt-get install -y nano
sudo apt-get install -y python-dev 
sudo apt-get install -y python-pip
sudo apt-get install -y redis-server
sudo apt-get install -y sqlite3 
sudo apt-get install -y wget 
sudo apt-get install -y zlib1g-dev 

# configure git global options to prevent problems
# with gitlabhq user pushing repos back to gitolite
git config --global user.email "admin@local.host"
git config --global user.name "GitLabHQ Admin User"
