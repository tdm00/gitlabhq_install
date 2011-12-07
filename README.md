## Ubuntu installation

1. login as user, install git & generate ssh key, clone install this repo
2. Install packages - `./ubuntu_packages.sh`
3. Install ruby - `./ubuntu_ruby.sh`
4. Install gitolite with umask 0007 - `./ubuntu_gitolite.sh`
5. logout & login again
6. Clone & setup gitlab - `./ubuntu_gitlab.sh`
7. Start server - `cd gitlabhq & bundle exec rails s -e production`
