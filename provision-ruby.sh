echo "Installing Rbenv..."
cd
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo "Installing ruby-build..."
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

echo "Installing rbenv-gem-rehash..."
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

echo "Installing Ruby..."
rbenv install 2.1.2
rbenv global 2.1.2
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler