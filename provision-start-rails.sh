#!/usr/bin/env bash

echo "Vagrant doesn't load .bashrc properly, so hardcode the rbenv paths here"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

echo 'Change directory to vagrant folder'
cd /vagrant

echo 'Check gems up to date'
bundle

echo 'Make sure executables from the gems we just installed are available'
rbenv rehash

echo 'Start Rails'
rails s -d

# guard
# spring

