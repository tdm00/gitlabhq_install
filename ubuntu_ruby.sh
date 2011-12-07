# get ruby 1.9.2
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p290.tar.gz
tar xfvz ruby-1.9.2-p290.tar.gz
cd ruby-1.9.2-p290
./configure
make
sudo make install
echo "Done"
