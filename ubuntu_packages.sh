# install all packages
sudo apt-get install git-core wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libpcre3-dev  libssl-dev libmysql++-dev make build-essential zlib1g-dev -y

# configure git global options to prevent problems
# with gitlabhq user pushing repos back to gitolite
git config --global user.email "admin@local.host"
git config --global user.name "GitLabHQ Admin User"
